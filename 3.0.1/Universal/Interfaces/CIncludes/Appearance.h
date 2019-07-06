/*
 	File:		Appearance.h
 
 	Contains:	Appearance Manager & SDK Interfaces.
 
 	Version:	Technology:	Appearance 1.0
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1994-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
#ifndef __APPEARANCE__
#define __APPEARANCE__

#ifndef __TYPES__
#include <Types.h>
#endif
#ifndef __MACWINDOWS__
#include <MacWindows.h>
#endif
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
#ifndef __DIALOGS__
#include <Dialogs.h>
#endif
#ifndef __FILES__
#include <Files.h>
#endif
#ifndef __ICONS__
#include <Icons.h>
#endif
#ifndef __CONTROLS__
#include <Controls.h>
#endif
#ifndef __TEXTEDIT__
#include <TextEdit.h>
#endif
#ifndef __QDOFFSCREEN__
#include <QDOffscreen.h>
#endif
#ifndef __TEXTCOMMON__
#include <TextCommon.h>
#endif

/*——————————————————————————————————————————————————————————————————————————————————*/
/* Appearance Manager constants, etc.												*/
/*——————————————————————————————————————————————————————————————————————————————————*/


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
																/* Appearance Trap Number */
	_AppearanceDispatch			= 0xAA74
};

/* Gestalt selector and values for the Appearance Manager */

enum {
	gestaltAppearanceAttr		= FOUR_CHAR_CODE('appr'),
	gestaltAppearanceExists		= 0,
	gestaltAppearanceCompatMode	= 1
};

/* Appearance Manager Error Codes */

enum {
	appearanceBadBrushIndexErr	= -30560,						/* pattern index invalid */
	appearanceProcessRegisteredErr = -30561,
	appearanceProcessNotRegisteredErr = -30562,
	appearanceBadTextColorIndexErr = -30563
};


enum {
	kThemeActiveDialogBackgroundBrush = 1,						/* Dialogs */
	kThemeInactiveDialogBackgroundBrush = 2,					/* Dialogs */
	kThemeActiveAlertBackgroundBrush = 3,
	kThemeInactiveAlertBackgroundBrush = 4,
	kThemeActiveModelessDialogBackgroundBrush = 5,
	kThemeInactiveModelessDialogBackgroundBrush = 6,
	kThemeActiveUtilityWindowBackgroundBrush = 7,				/* Miscellaneous */
	kThemeInactiveUtilityWindowBackgroundBrush = 8,				/* Miscellaneous */
	kThemeListViewSortColumnBackgroundBrush = 9,				/* Finder */
	kThemeListViewBackgroundBrush = 10,
	kThemeIconLabelBackgroundBrush = 11,
	kThemeListViewSeparatorBrush = 12,
	kThemeChasingArrowsBrush	= 13,
	kThemeDragHiliteBrush		= 14,
	kThemeDocumentWindowBackgroundBrush = 15,
	kThemeFinderWindowBackgroundBrush = 16
};

typedef SInt16 							ThemeBrush;

enum {
	kThemeActiveDialogTextColor	= 1,							/* Dialogs */
	kThemeInactiveDialogTextColor = 2,
	kThemeActiveAlertTextColor	= 3,
	kThemeInactiveAlertTextColor = 4,
	kThemeActiveModelessDialogTextColor = 5,
	kThemeInactiveModelessDialogTextColor = 6,
	kThemeActiveWindowHeaderTextColor = 7,						/* Primitives */
	kThemeInactiveWindowHeaderTextColor = 8,
	kThemeActivePlacardTextColor = 9,							/* Primitives */
	kThemeInactivePlacardTextColor = 10,
	kThemePressedPlacardTextColor = 11,
	kThemeActivePushButtonTextColor = 12,						/* Primitives */
	kThemeInactivePushButtonTextColor = 13,
	kThemePressedPushButtonTextColor = 14,
	kThemeActiveBevelButtonTextColor = 15,						/* Primitives */
	kThemeInactiveBevelButtonTextColor = 16,
	kThemePressedBevelButtonTextColor = 17,
	kThemeActivePopupButtonTextColor = 18,						/* Primitives */
	kThemeInactivePopupButtonTextColor = 19,
	kThemePressedPopupButtonTextColor = 20,
	kThemeIconLabelTextColor	= 21,							/* Finder */
	kThemeListViewTextColor		= 22
};

typedef SInt16 							ThemeTextColor;
/* States to draw primitives: disabled, active, and pressed (hilited) */

enum {
	kThemeStateDisabled			= 0,
	kThemeStateActive			= 1,
	kThemeStatePressed			= 2
};

typedef UInt32 							ThemeDrawState;
/*——————————————————————————————————————————————————————————————————————————————————*/
/* Window Manager constants, etc.													*/
/*——————————————————————————————————————————————————————————————————————————————————*/

enum {
																/* Resource IDs for new window defprocs */
	kWindowDocumentDefProcResID	= 64,
	kWindowDialogDefProcResID	= 65,
	kWindowUtilityDefProcResID	= 66,
	kWindowUtilitySideTitleDefProcResID = 67
};


enum {
																/* Proc IDs for theme-savvy windows */
	kWindowDocumentProc			= 1024,
	kWindowGrowDocumentProc		= 1025,
	kWindowHorizZoomDocumentProc = 1026,
	kWindowHorizZoomGrowDocumentProc = 1027,
	kWindowVertZoomDocumentProc	= 1028,
	kWindowVertZoomGrowDocumentProc = 1029,
	kWindowFullZoomDocumentProc	= 1030,
	kWindowFullZoomGrowDocumentProc = 1031
};


enum {
																/* Proc IDs for theme-savvy dialogs */
	kWindowPlainDialogProc		= 1040,
	kWindowShadowDialogProc		= 1041,
	kWindowModalDialogProc		= 1042,
	kWindowMovableModalDialogProc = 1043,
	kWindowAlertProc			= 1044,
	kWindowMovableAlertProc		= 1045
};


enum {
																/* Proc IDs for top title bar theme-savvy floating windows */
	kWindowFloatProc			= 1057,
	kWindowFloatGrowProc		= 1059,
	kWindowFloatHorizZoomProc	= 1061,
	kWindowFloatHorizZoomGrowProc = 1063,
	kWindowFloatVertZoomProc	= 1065,
	kWindowFloatVertZoomGrowProc = 1067,
	kWindowFloatFullZoomProc	= 1069,
	kWindowFloatFullZoomGrowProc = 1071
};


enum {
																/* Proc IDs for side title bar theme-savvy floating windows */
	kWindowFloatSideProc		= 1073,
	kWindowFloatSideGrowProc	= 1075,
	kWindowFloatSideHorizZoomProc = 1077,
	kWindowFloatSideHorizZoomGrowProc = 1079,
	kWindowFloatSideVertZoomProc = 1081,
	kWindowFloatSideVertZoomGrowProc = 1083,
	kWindowFloatSideFullZoomProc = 1085,
	kWindowFloatSideFullZoomGrowProc = 1087
};


enum {
																/* Region values to pass into GetWindowRegion */
	kWindowTitleBarRgn			= 0,
	kWindowTitleTextRgn			= 1,
	kWindowCloseBoxRgn			= 2,
	kWindowZoomBoxRgn			= 3,
	kWindowDragRgn				= 5,
	kWindowGrowRgn				= 6,
	kWindowCollapseBoxRgn		= 7,
	kWindowStructureRgn			= 32,
	kWindowContentRgn			= 33
};

typedef UInt16 							WindowRegionCode;

enum {
																/* Window Features returned by GetWindowFeatures */
	kWindowCanGrow				= (1 << 0),
	kWindowCanZoom				= (1 << 1),
	kWindowCanCollapse			= (1 << 2),
	kWindowIsModal				= (1 << 3),
	kWindowCanGetWindowRegion	= (1 << 4),
	kWindowIsAlert				= (1 << 5),
	kWindowHasTitleBar			= (1 << 6)
};


enum {
																/* New window messages */
	kWindowMsgGetFeatures		= 7,
	kWindowMsgGetRegion			= 8
};


enum {
																/* New Window part codes */
	inCollapseBox				= 11
};


enum {
																/* Window Definition hit test result codes ("WindowPart")*/
	wInCollapseBox				= 9
};

/* Window positioning constants */

enum {
	kWindowDefaultPosition		= 0x0000,
	kWindowCenterMainScreen		= 0x280A,
	kWindowAlertPositionMainScreen = 0x300A,
	kWindowStaggerMainScreen	= 0x380A,
	kWindowCenterParentWindow	= 0xA80A,
	kWindowAlertPositionParentWindow = 0xB00A,
	kWindowStaggerParentWindow	= 0xB80A,
	kWindowCenterParentWindowScreen = 0x680A,
	kWindowAlertPositionParentWindowScreen = 0x700A,
	kWindowStaggerParentWindowScreen = 0x780A
};

/* GetWindowRegionRec - used for WDEF calls with kWindowMsgGetRegion */
struct GetWindowRegionRec {
	RgnHandle 						winRgn;
	WindowRegionCode 				regionCode;
};
typedef struct GetWindowRegionRec GetWindowRegionRec;

typedef GetWindowRegionRec *			GetWindowRegionPtr;
/*——————————————————————————————————————————————————————————————————————————————————*/
/* Dialog Manager constants, etc.													*/
/*——————————————————————————————————————————————————————————————————————————————————*/

enum {
																/* Alert types to pass into StandardAlert */
	kAlertStopAlert				= 0,
	kAlertNoteAlert				= 1,
	kAlertCautionAlert			= 2,
	kAlertPlainAlert			= 3
};

typedef SInt16 							AlertType;

enum {
	kAlertDefaultOKText			= -1,							/* "OK"*/
	kAlertDefaultCancelText		= -1,							/* "Cancel"*/
	kAlertDefaultOtherText		= -1							/* "Don't Save"*/
};

/* StandardAlert alert button numbers */

enum {
	kAlertStdAlertOKButton		= 1,
	kAlertStdAlertCancelButton	= 2,
	kAlertStdAlertOtherButton	= 3,
	kAlertStdAlertHelpButton	= 4
};


enum {
																/* Dialog Flags for use in NewFeaturesDialog or dlgx resource */
	kDialogFlagsUseThemeBackground = (1 << 0),
	kDialogFlagsUseControlHierarchy = (1 << 1),
	kDialogFlagsHandleMovableModal = (1 << 2),
	kDialogFlagsUseThemeControls = (1 << 3)
};


enum {
																/* Alert Flags for use in alrx resource */
	kAlertFlagsUseThemeBackground = (1 << 0),
	kAlertFlagsUseControlHierarchy = (1 << 1),
	kAlertFlagsAlertIsMovable	= (1 << 2),
	kAlertFlagsUseThemeControls	= (1 << 3)
};

/* For dftb resource */

enum {
	kDialogFontNoFontStyle		= 0,
	kDialogFontUseFontMask		= 0x0001,
	kDialogFontUseFaceMask		= 0x0002,
	kDialogFontUseSizeMask		= 0x0004,
	kDialogFontUseForeColorMask	= 0x0008,
	kDialogFontUseBackColorMask	= 0x0010,
	kDialogFontUseModeMask		= 0x0020,
	kDialogFontUseJustMask		= 0x0040,
	kDialogFontUseAllMask		= 0x00FF,
	kDialogFontAddFontSizeMask	= 0x0100,
	kDialogFontUseFontMaskMask	= 0x0200
};

struct AlertStdAlertParamRec {
	Boolean 						movable;					/* Make alert movable modal */
	Boolean 						helpButton;					/* Is there a help button? */
	ModalFilterUPP 					filterProc;					/* Event filter */
	StringPtr 						defaultText;				/* Text for button in OK position */
	StringPtr 						cancelText;					/* Text for button in cancel position */
	StringPtr 						otherText;					/* Text for button in left position */
	SInt16 							defaultButton;				/* Which button behaves as the default */
	SInt16 							cancelButton;				/* Which one behaves as cancel (can be 0) */
	UInt16 							position;					/* Position (kWindowDefaultPosition in this case */
																/* equals kWindowAlertPositionParentWindowScreen) */
};
typedef struct AlertStdAlertParamRec AlertStdAlertParamRec;

typedef AlertStdAlertParamRec *			AlertStdAlertParamPtr;
/*——————————————————————————————————————————————————————————————————————————————————*/
/* Control Manager constants, etc.													*/
/*——————————————————————————————————————————————————————————————————————————————————*/

enum {
	_ControlDispatch			= 0xAA73
};


enum {
																/* resource types for new controls */
	kControlTabListResType		= FOUR_CHAR_CODE('tab#'),		/* used for tab control only*/
	kControlListDescResType		= FOUR_CHAR_CODE('ldes')		/* used for list box control only*/
};


enum {
																/* new part codes for new controls */
	kControlEditTextPart		= 5,
	kControlPicturePart			= 6,
	kControlIconPart			= 7,
	kControlClockPart			= 8,
	kControlListBoxPart			= 24,
	kControlListBoxDoubleClickPart = 25
};


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
typedef struct ControlFontStyleRec ControlFontStyleRec;

typedef ControlFontStyleRec *			ControlFontStylePtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* Common data tags for Get/SetControlData												*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
	kControlFontStyleTag		= FOUR_CHAR_CODE('font'),
	kControlKeyFilterTag		= FOUR_CHAR_CODE('fltr')
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* Errors are in the range -30580 .. -30599												*/
/*——————————————————————————————————————————————————————————————————————————————————————*/

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
	errItemNotControl			= -30596
};


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


enum {
																/* Control Messages */
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
	kControlMsgCalcValue		= 24,
	kControlMsgSubControlHit	= 25,
	kControlMsgCalcValueFromPos	= 26,
	kControlMsgTestNewMsgSupport = 27							/* See if this control supports new messaging*/
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
typedef struct ControlTrackingRec ControlTrackingRec;

typedef ControlTrackingRec *			ControlTrackingPtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* This structure is passed into a CDEF when called with the kControlMsgKeyDown message */
/*——————————————————————————————————————————————————————————————————————————————————————*/
struct ControlKeyDownRec {
	SInt16 							modifiers;
	SInt16 							keyCode;
	SInt16 							charCode;
};
typedef struct ControlKeyDownRec ControlKeyDownRec;

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
typedef struct ControlDataAccessRec ControlDataAccessRec;

typedef ControlDataAccessRec *			ControlDataAccessPtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* This structure is passed into a CDEF when called with the kControlCalcBestRect msg 	*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
struct ControlCalcSizeRec {
	SInt16 							height;
	SInt16 							width;
	SInt16 							baseLine;
};
typedef struct ControlCalcSizeRec ControlCalcSizeRec;

typedef ControlCalcSizeRec *			ControlCalcSizePtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* This structure is passed into a CDEF when called with the kControlMsgSetUpBackground */
/* message is sent																		*/
/*——————————————————————————————————————————————————————————————————————————————————————*/
struct ControlBackgroundRec {
	SInt16 							depth;
	Boolean 						colorDevice;
};
typedef struct ControlBackgroundRec ControlBackgroundRec;

typedef ControlBackgroundRec *			ControlBackgroundPtr;
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
	kControlBevelButtonMenuHandleTag = FOUR_CHAR_CODE('mhnd')	/* MenuHandle*/
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
typedef struct ControlButtonContentInfo ControlButtonContentInfo;

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
/*
|*		kSliderReverseDirection	Slider thumb points in opposite direction than normal.	*/
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

enum {
																/* Tabs proc IDs */
	kControlTabLargeProc		= 128,							/* Large tab size	*/
	kControlTabSmallProc		= 129							/* Small tab size	*/
};


enum {
																/* Tagged data supported by progress bars */
	kControlTabContentRectTag	= FOUR_CHAR_CODE('rect'),		/* Rect*/
	kControlTabEnabledFlagTag	= FOUR_CHAR_CODE('enab'),		/* Boolean*/
	kControlTabFontStyleTag		= kControlFontStyleTag			/* ControlFontStyleRec*/
};

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
/*	Checked State																		*/
/*	—————————————																		*/
/*	The checked state is enabled by setting the value of the control to 1, just like a 	*/
/*	check box.																			*/
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
/*																						*/
/*	AutoTracking																		*/
/*	————————————																		*/
/*	Image Wells are capable of autotracking. The current autotracking feature sets the 	*/
/*	value itself, so that the control remains hilited. It behaves as a sort of palette 	*/
/*	type object where clicking selects it, it cannot be delected by clicking it again, 	*/
/*	clicking on another object should cause the focus to change (as in Get Info windows)*/
/*	and the application should then set the value to 0 to take away the checked border.	*/
/*																						*/

enum {
																/* Image Well proc IDs */
	kControlImageWellProc		= 176,
	kControlImageWellAutoTrackProc = 177
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
	kControlEditTextDialogProc	= 273,
	kControlEditTextPasswordProc = 274
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

struct ControlEditTextSelectionRec {
																/* Structure for getting the edit text selection */
	SInt16 							selStart;
	SInt16 							selEnd;
};
typedef struct ControlEditTextSelectionRec ControlEditTextSelectionRec;

typedef ControlEditTextSelectionRec *	ControlEditTextSelectionPtr;
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

/* Tagged data supported by icon controls */

enum {
	kControlIconTransformTag	= FOUR_CHAR_CODE('trfm'),		/* IconTransformType*/
	kControlIconAlignmentTag	= FOUR_CHAR_CODE('algn')		/* IconAlignmentType*/
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
/*	the ldes is passed in the 'value' parameter when creating the control.				*/

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

enum {
																/* Theme Push Button/Check Box/Radio Button proc IDs */
	kControlPushButtonProc		= 368,
	kControlCheckBoxProc		= 369,
	kControlRadioButtonProc		= 370,
	kControlPushButLeftIconProc	= 374,							/* Standard pushbutton with left-side icon*/
	kControlPushButRightIconProc = 375							/* Standard pushbutton with right-side icon*/
};


enum {
																/* Tagged data supported by standard buttons */
	kControlPushButtonDefaultTag = FOUR_CHAR_CODE('dflt')		/* default ring flag*/
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
	kControlPopupUseWFontVariant = kControlUsesOwningWindowsFontVariant
};

/*——————————————————————————————————————————————————————————————————————————————————*/
/* Menu Manager constants, etc.														*/
/*——————————————————————————————————————————————————————————————————————————————————*/

enum {
	kMenuStdMenuProc			= 63,
	kMenuStdMenuBarProc			= 63
};


enum {
	kMenuNoModifiers			= 0,							/* Mask for no modifiers*/
	kMenuShiftModifier			= (1 << 0),						/* Mask for shift key modifier*/
	kMenuOptionModifier			= (1 << 1),						/* Mask for option key modifier*/
	kMenuControlModifier		= (1 << 2),						/* Mask for control key modifier*/
	kMenuNoCommandModifier		= (1 << 3)						/* Mask for no command key modifier*/
};


enum {
	kMenuNoIcon					= 0,							/* No icon*/
	kMenuIconType				= 1,							/* Type for ICON*/
	kMenuShrinkIconType			= 2,							/* Type for ICON plotted 16 x 16*/
	kMenuSmallIconType			= 3,							/* Type for SICN*/
	kMenuColorIconType			= 4,							/* Type for cicn*/
	kMenuIconSuiteType			= 5,							/* Type for Icon Suite*/
	kMenuIconRefType			= 6								/* Type for Icon Ref*/
};

/*——————————————————————————————————————————————————————————————————————————————————*/
/*	Appearance Manager APIs															*/
/*——————————————————————————————————————————————————————————————————————————————————*/
/* Registering Appearance-Savvy Applications */
EXTERN_API( OSStatus )
RegisterAppearanceClient		(void)														THREEWORDINLINE(0x303C, 0x0015, 0xAA74);

EXTERN_API( OSStatus )
UnregisterAppearanceClient		(void)														THREEWORDINLINE(0x303C, 0x0016, 0xAA74);

/*****************************************************************************
	NOTES ON THEME BRUSHES
	Theme brushes can be either colors or patterns, depending on the theme.
	Because of this, you should be prepared to handle the case where a brush
	is a pattern and save and restore the pnPixPat and bkPixPat fields of
	your GrafPorts when saving the fore and back colors. Also, since patterns
	in bkPixPat override the background color of the window, you should use
	BackPat to set your background pattern to a normal white pattern. This
	will ensure that you can use RGBBackColor to set your back color to white,
	call EraseRect and get the expected results.
*****************************************************************************/

EXTERN_API( OSStatus )
SetThemePen						(ThemeBrush 			brush,
								 SInt16 				depth,
								 Boolean 				colorDevice)						THREEWORDINLINE(0x303C, 0x0001, 0xAA74);

EXTERN_API( OSStatus )
SetThemeBackground				(ThemeBrush 			brush,
								 SInt16 				depth,
								 Boolean 				colorDevice)						THREEWORDINLINE(0x303C, 0x0002, 0xAA74);

EXTERN_API( OSStatus )
SetThemeTextColor				(ThemeTextColor 		color,
								 SInt16 				depth,
								 Boolean 				colorDevice)						THREEWORDINLINE(0x303C, 0x0003, 0xAA74);

EXTERN_API( OSStatus )
SetThemeWindowBackground		(WindowPtr 				window,
								 ThemeBrush 			brush,
								 Boolean 				update)								THREEWORDINLINE(0x303C, 0x0004, 0xAA74);


/* Window Placards, Headers and Frames */
EXTERN_API( OSStatus )
DrawThemeWindowHeader			(const Rect *			rect,
								 ThemeDrawState 		state)								THREEWORDINLINE(0x303C, 0x0005, 0xAA74);

EXTERN_API( OSStatus )
DrawThemeWindowListViewHeader	(const Rect *			rect,
								 ThemeDrawState 		state)								THREEWORDINLINE(0x303C, 0x0006, 0xAA74);

EXTERN_API( OSStatus )
DrawThemePlacard				(const Rect *			rect,
								 ThemeDrawState 		state)								THREEWORDINLINE(0x303C, 0x0007, 0xAA74);

EXTERN_API( OSStatus )
DrawThemeEditTextFrame			(const Rect *			rect,
								 ThemeDrawState 		state)								THREEWORDINLINE(0x303C, 0x0009, 0xAA74);

EXTERN_API( OSStatus )
DrawThemeListBoxFrame			(const Rect *			rect,
								 ThemeDrawState 		state)								THREEWORDINLINE(0x303C, 0x000A, 0xAA74);

/* Keyboard Focus Drawing */
EXTERN_API( OSStatus )
DrawThemeFocusRect				(const Rect *			rect,
								 Boolean 				hasFocus)							THREEWORDINLINE(0x303C, 0x000B, 0xAA74);

/* Dialog Group Boxes and Separators */
EXTERN_API( OSStatus )
DrawThemePrimaryGroup			(const Rect *			rect,
								 ThemeDrawState 		state)								THREEWORDINLINE(0x303C, 0x000C, 0xAA74);

EXTERN_API( OSStatus )
DrawThemeSecondaryGroup			(const Rect *			rect,
								 ThemeDrawState 		state)								THREEWORDINLINE(0x303C, 0x000D, 0xAA74);

EXTERN_API( OSStatus )
DrawThemeSeparator				(const Rect *			rect,
								 ThemeDrawState 		state)								THREEWORDINLINE(0x303C, 0x000E, 0xAA74);


/*——————————————————————————————————————————————————————————————————————————————————*/
/*	Window Manager APIs																*/
/*——————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( OSStatus )
GetWindowFeatures				(WindowPtr 				window,
								 UInt32 *				features)							THREEWORDINLINE(0x303C, 0x0013, 0xAA74);

EXTERN_API( Boolean )
IsWindowCollapsable				(WindowPtr 				window)								THREEWORDINLINE(0x303C, 0x000F, 0xAA74);

EXTERN_API( Boolean )
IsWindowCollapsed				(WindowPtr 				window)								THREEWORDINLINE(0x303C, 0x0010, 0xAA74);

EXTERN_API( OSStatus )
CollapseWindow					(WindowPtr 				window,
								 Boolean 				collapseIt)							THREEWORDINLINE(0x303C, 0x0011, 0xAA74);

EXTERN_API( OSStatus )
CollapseAllWindows				(Boolean 				collapseEm)							THREEWORDINLINE(0x303C, 0x0012, 0xAA74);

EXTERN_API( OSStatus )
GetWindowRegion					(WindowPtr 				window,
								 WindowRegionCode 		regionCode,
								 RgnHandle 				winRgn)								THREEWORDINLINE(0x303C, 0x0014, 0xAA74);

/*——————————————————————————————————————————————————————————————————————————————————*/
/*	Dialog Manager APIs																*/
/*——————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( DialogPtr )
NewFeaturesDialog				(void *					wStorage,
								 const Rect *			boundsRect,
								 ConstStr255Param 		title,
								 Boolean 				visible,
								 SInt16 				procID,
								 WindowPtr 				behind,
								 Boolean 				goAwayFlag,
								 SInt32 				refCon,
								 Handle 				itmLstHndl,
								 UInt32 				flags)								THREEWORDINLINE(0x303C, 0x110C, 0xAA68);

EXTERN_API( OSErr )
AutoSizeDialog					(DialogPtr 				dialog)								THREEWORDINLINE(0x303C, 0x020D, 0xAA68);

EXTERN_API( OSErr )
StandardAlert					(AlertType 				alertType,
								 StringPtr 				error,
								 StringPtr 				explanation,
								 AlertStdAlertParamPtr 	alertParam,
								 SInt16 *				itemHit)							THREEWORDINLINE(0x303C, 0x090E, 0xAA68);

EXTERN_API( OSErr )
GetDialogItemAsControl			(DialogPtr 				dialog,
								 SInt16 				itemNo,
								 ControlHandle *		control)							THREEWORDINLINE(0x303C, 0x050F, 0xAA68);

EXTERN_API( OSErr )
MoveDialogItem					(DialogPtr 				dialog,
								 SInt16 				itemNo,
								 SInt16 				horiz,
								 SInt16 				vert)								THREEWORDINLINE(0x303C, 0x0510, 0xAA68);

EXTERN_API( OSErr )
SizeDialogItem					(DialogPtr 				dialog,
								 SInt16 				itemNo,
								 SInt16 				height,
								 SInt16 				width)								THREEWORDINLINE(0x303C, 0x0511, 0xAA68);

/*——————————————————————————————————————————————————————————————————————————————————*/
/*	Control Manager APIs															*/
/*——————————————————————————————————————————————————————————————————————————————————*/
/*
   These routines are available only thru the shared library/glue
   Bevel button routines
*/

EXTERN_API( OSErr )
GetBevelButtonMenuValue			(ControlHandle 			button,
								 SInt16 *				value);

EXTERN_API( OSErr )
SetBevelButtonMenuValue			(ControlHandle 			button,
								 SInt16 				value);

EXTERN_API( OSErr )
GetBevelButtonMenuHandle		(ControlHandle 			button,
								 MenuHandle *			handle);

EXTERN_API( OSErr )
GetBevelButtonContentInfo		(ControlHandle 			button,
								 ControlButtonContentInfoPtr  content);

EXTERN_API( OSErr )
SetBevelButtonContentInfo		(ControlHandle 			button,
								 ControlButtonContentInfoPtr  content);

EXTERN_API( OSErr )
SetBevelButtonTransform			(ControlHandle 			button,
								 IconTransformType 		transform);

EXTERN_API( OSErr )
SetBevelButtonGraphicAlignment	(ControlHandle 			button,
								 ControlButtonGraphicAlignment  align,
								 SInt16 				hOffset,
								 SInt16 				vOffset);

EXTERN_API( OSErr )
SetBevelButtonTextAlignment		(ControlHandle 			button,
								 ControlButtonTextAlignment  align,
								 SInt16 				hOffset);

EXTERN_API( OSErr )
SetBevelButtonTextPlacement		(ControlHandle 			button,
								 ControlButtonTextPlacement  where);

/* Image well routines*/

EXTERN_API( OSErr )
GetImageWellContentInfo			(ControlHandle 			button,
								 ControlButtonContentInfoPtr  content);

EXTERN_API( OSErr )
SetImageWellContentInfo			(ControlHandle 			button,
								 ControlButtonContentInfoPtr  content);

EXTERN_API( OSErr )
SetImageWellTransform			(ControlHandle 			button,
								 IconTransformType 		transform);

/* Tab routines*/

EXTERN_API( OSErr )
GetTabContentRect				(ControlHandle 			tabControl,
								 Rect *					contentRect);

EXTERN_API( OSErr )
SetTabEnabled					(ControlHandle 			tabControl,
								 SInt16 				tabToHilite,
								 Boolean 				enabled);

/* Disclosure triangles*/

EXTERN_API( OSErr )
SetDisclosureTriangleLastValue	(ControlHandle 			tabControl,
								 SInt16 				value);

/* Trap-based routines*/

EXTERN_API( SInt32 )
SendControlMessage				(ControlHandle 			theControl,
								 SInt16 				message,
								 SInt32 				param)								THREEWORDINLINE(0x303C, 0xFFFE, 0xAA73);

EXTERN_API( OSErr )
DumpControlHierarchy			(WindowPtr 				window,
								 const FSSpec *			outFile)							THREEWORDINLINE(0x303C, 0xFFFF, 0xAA73);

EXTERN_API( OSErr )
CreateRootControl				(WindowPtr 				window,
								 ControlHandle *		control)							THREEWORDINLINE(0x303C, 0x0001, 0xAA73);

EXTERN_API( OSErr )
GetRootControl					(WindowPtr 				window,
								 ControlHandle *		control)							THREEWORDINLINE(0x303C, 0x0002, 0xAA73);

EXTERN_API( OSErr )
EmbedControl					(ControlHandle 			control,
								 ControlHandle 			container)							THREEWORDINLINE(0x303C, 0x0003, 0xAA73);

EXTERN_API( OSErr )
AutoEmbedControl				(ControlHandle 			control,
								 WindowPtr 				window)								THREEWORDINLINE(0x303C, 0x0004, 0xAA73);

EXTERN_API( Boolean )
IsControlActive					(ControlHandle 			control)							THREEWORDINLINE(0x303C, 0x0005, 0xAA73);

EXTERN_API( Boolean )
IsControlVisible				(ControlHandle 			control)							THREEWORDINLINE(0x303C, 0x0006, 0xAA73);

EXTERN_API( OSErr )
ActivateControl					(ControlHandle 			control)							THREEWORDINLINE(0x303C, 0x0007, 0xAA73);

EXTERN_API( OSErr )
DeactivateControl				(ControlHandle 			control)							THREEWORDINLINE(0x303C, 0x0008, 0xAA73);

EXTERN_API( ControlHandle )
FindControlUnderMouse			(Point 					where,
								 WindowPtr 				window,
								 SInt16 *				part)								THREEWORDINLINE(0x303C, 0x0009, 0xAA73);

EXTERN_API( SInt16 )
HandleControlClick				(ControlHandle 			control,
								 Point 					where,
								 SInt16 				modifiers,
								 ControlActionUPP 		action)								THREEWORDINLINE(0x303C, 0x000A, 0xAA73);

EXTERN_API( SInt16 )
HandleControlKey				(ControlHandle 			control,
								 SInt16 				keyCode,
								 SInt16 				charCode,
								 SInt16 				modifiers)							THREEWORDINLINE(0x303C, 0x000B, 0xAA73);

EXTERN_API( void )
IdleControls					(WindowPtr 				window)								THREEWORDINLINE(0x303C, 0x000C, 0xAA73);

EXTERN_API( OSErr )
GetKeyboardFocus				(WindowPtr 				window,
								 ControlHandle *		control)							THREEWORDINLINE(0x303C, 0x000D, 0xAA73);

EXTERN_API( OSErr )
SetKeyboardFocus				(WindowPtr 				window,
								 ControlHandle 			control,
								 ControlFocusPart 		part)								THREEWORDINLINE(0x303C, 0x000E, 0xAA73);

EXTERN_API( OSErr )
AdvanceKeyboardFocus			(WindowPtr 				window)								THREEWORDINLINE(0x303C, 0x000F, 0xAA73);

EXTERN_API( OSErr )
ReverseKeyboardFocus			(WindowPtr 				window)								THREEWORDINLINE(0x303C, 0x0010, 0xAA73);

EXTERN_API( OSErr )
GetControlFeatures				(ControlHandle 			control,
								 UInt32 *				features)							THREEWORDINLINE(0x303C, 0x0011, 0xAA73);

EXTERN_API( OSErr )
SetControlData					(ControlHandle 			control,
								 ControlPartCode 		part,
								 ResType 				tagName,
								 Size 					size,
								 Ptr 					data)								THREEWORDINLINE(0x303C, 0x0012, 0xAA73);

EXTERN_API( OSErr )
GetControlData					(ControlHandle 			control,
								 ControlPartCode 		part,
								 ResType 				tagName,
								 Size 					bufferSize,
								 Ptr 					buffer,
								 Size *					actualSize)							THREEWORDINLINE(0x303C, 0x0013, 0xAA73);

EXTERN_API( OSErr )
GetControlDataSize				(ControlHandle 			control,
								 ControlPartCode 		part,
								 ResType 				tagName,
								 Size *					maxSize)							THREEWORDINLINE(0x303C, 0x0014, 0xAA73);

EXTERN_API( OSErr )
GetSuperControl					(ControlHandle 			control,
								 ControlHandle *		parent)								THREEWORDINLINE(0x303C, 0x0015, 0xAA73);

EXTERN_API( OSErr )
CountSubControls				(ControlHandle 			control,
								 SInt16 *				numChildren)						THREEWORDINLINE(0x303C, 0x0016, 0xAA73);

EXTERN_API( OSErr )
GetIndexedSubControl			(ControlHandle 			control,
								 SInt16 				index,
								 ControlHandle *		subControl)							THREEWORDINLINE(0x303C, 0x0017, 0xAA73);

EXTERN_API( void )
DrawControlInCurrentPort		(ControlHandle 			theControl)							THREEWORDINLINE(0x303C, 0x0018, 0xAA73);

EXTERN_API( OSErr )
ClearKeyboardFocus				(WindowPtr 				window)								THREEWORDINLINE(0x303C, 0x0019, 0xAA73);

EXTERN_API( OSErr )
SetControlSupervisor			(ControlHandle 			control,
								 ControlHandle 			boss)								THREEWORDINLINE(0x303C, 0x001A, 0xAA73);

EXTERN_API( OSErr )
GetBestControlRect				(ControlHandle 			control,
								 Rect *					rect,
								 SInt16 *				baseLineOffset)						THREEWORDINLINE(0x303C, 0x001B, 0xAA73);

EXTERN_API( OSErr )
SetControlFontStyle				(ControlHandle 			control,
								 ControlFontStyleRec *	style)								THREEWORDINLINE(0x303C, 0x001C, 0xAA73);

EXTERN_API( OSErr )
SetUpControlBackground			(ControlHandle 			control,
								 SInt16 				depth,
								 Boolean 				colorDevice)						THREEWORDINLINE(0x303C, 0x001D, 0xAA73);

EXTERN_API( OSErr )
SetControlVisibility			(ControlHandle 			control,
								 Boolean 				isVisible,
								 Boolean 				draw)								THREEWORDINLINE(0x303C, 0x001E, 0xAA73);

/*——————————————————————————————————————————————————————————————————————————————————*/
/*	Menu Manager APIs																*/
/*——————————————————————————————————————————————————————————————————————————————————*/
EXTERN_API( UInt32 )
MenuEvent						(const EventRecord *	event)								THREEWORDINLINE(0x303C, 0x020C, 0xA825);

EXTERN_API( OSErr )
SetMenuItemCommandID			(MenuHandle 			menu,
								 SInt16 				item,
								 UInt32 				commandID)							THREEWORDINLINE(0x303C, 0x0502, 0xA825);

EXTERN_API( OSErr )
GetMenuItemCommandID			(MenuHandle 			menu,
								 SInt16 				item,
								 UInt32 *				commandID)							THREEWORDINLINE(0x303C, 0x0503, 0xA825);

EXTERN_API( OSErr )
SetMenuItemModifiers			(MenuHandle 			menu,
								 SInt16 				item,
								 UInt8 					modifiers)							THREEWORDINLINE(0x303C, 0x0404, 0xA825);

EXTERN_API( OSErr )
GetMenuItemModifiers			(MenuHandle 			menu,
								 SInt16 				item,
								 UInt8 *				modifiers)							THREEWORDINLINE(0x303C, 0x0505, 0xA825);

EXTERN_API( OSErr )
SetMenuItemIconHandle			(MenuHandle 			menu,
								 SInt16 				item,
								 UInt8 					iconType,
								 Handle 				icon)								THREEWORDINLINE(0x303C, 0x0606, 0xA825);

EXTERN_API( OSErr )
GetMenuItemIconHandle			(MenuHandle 			menu,
								 SInt16 				item,
								 UInt8 *				iconType,
								 Handle *				icon)								THREEWORDINLINE(0x303C, 0x0707, 0xA825);

EXTERN_API( OSErr )
SetMenuItemTextEncoding			(MenuHandle 			menu,
								 SInt16 				item,
								 TextEncoding 			scriptID)							THREEWORDINLINE(0x303C, 0x0408, 0xA825);

EXTERN_API( OSErr )
GetMenuItemTextEncoding			(MenuHandle 			menu,
								 SInt16 				item,
								 TextEncoding *			scriptID)							THREEWORDINLINE(0x303C, 0x0509, 0xA825);

EXTERN_API( OSErr )
SetMenuItemHierarchicalID		(MenuHandle 			menu,
								 SInt16 				item,
								 SInt16 				hierID)								THREEWORDINLINE(0x303C, 0x040D, 0xA825);

EXTERN_API( OSErr )
GetMenuItemHierarchicalID		(MenuHandle 			menu,
								 SInt16 				item,
								 SInt16 *				hierID)								THREEWORDINLINE(0x303C, 0x050E, 0xA825);

EXTERN_API( OSErr )
SetMenuItemFontID				(MenuHandle 			menu,
								 SInt16 				item,
								 SInt16 				fontID)								THREEWORDINLINE(0x303C, 0x040F, 0xA825);

EXTERN_API( OSErr )
GetMenuItemFontID				(MenuHandle 			menu,
								 SInt16 				item,
								 SInt16 *				fontID)								THREEWORDINLINE(0x303C, 0x0510, 0xA825);

EXTERN_API( OSErr )
SetMenuItemRefCon				(MenuHandle 			menu,
								 SInt16 				item,
								 UInt32 				refCon)								THREEWORDINLINE(0x303C, 0x050A, 0xA825);

EXTERN_API( OSErr )
GetMenuItemRefCon				(MenuHandle 			menu,
								 SInt16 				item,
								 UInt32 *				refCon)								THREEWORDINLINE(0x303C, 0x050B, 0xA825);

EXTERN_API( OSErr )
SetMenuItemRefCon2				(MenuHandle 			menu,
								 SInt16 				item,
								 UInt32 				refCon2)							THREEWORDINLINE(0x303C, 0x0511, 0xA825);

EXTERN_API( OSErr )
GetMenuItemRefCon2				(MenuHandle 			menu,
								 SInt16 				item,
								 UInt32 *				refCon2)							THREEWORDINLINE(0x303C, 0x0512, 0xA825);

EXTERN_API( OSErr )
SetMenuItemKeyGlyph				(MenuHandle 			menu,
								 SInt16 				item,
								 SInt16 				glyph)								THREEWORDINLINE(0x303C, 0x0513, 0xA825);

EXTERN_API( OSErr )
GetMenuItemKeyGlyph				(MenuHandle 			menu,
								 SInt16 				item,
								 SInt16 *				glyph)								THREEWORDINLINE(0x303C, 0x0514, 0xA825);


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

#endif /* __APPEARANCE__ */

