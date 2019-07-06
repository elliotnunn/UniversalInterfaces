{
 	File:		Controls.p
 
 	Contains:	Control Manager interfaces
 
 	Version:	Technology:	Mac OS 8.1
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1985-1998 by Apple Computer, Inc., all rights reserved
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}
{$IFC UNDEFINED __DRAG__}
{$I Drag.p}
{$ENDC}
{$IFC UNDEFINED __ICONS__}
{$I Icons.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	_ControlDispatch			= $AA73;


{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• Resource Types																					}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
	kControlDefProcType			= 'CDEF';
	kControlTemplateResourceType = 'CNTL';
	kControlColorTableResourceType = 'cctb';
	kControlDefProcResourceType	= 'CDEF';
	kControlTabListResType		= 'tab#';						{  used for tab control (Appearance 1.0 and later) }
	kControlListDescResType		= 'ldes';						{  used for list box control (Appearance 1.0 and later) }

{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• Format of a ‘CNTL’ resource																		}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}

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


{$IFC NOT TARGET_OS_MAC }
{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
   • NON-MAC COMPATIBILITY CODES (QuickTime 3.0)
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}
	ControlNotification					= UInt32;

CONST
	controlNotifyNothing		= 'nada';						{  No (null) notification }
	controlNotifyClick			= 'clik';						{  Control was clicked }
	controlNotifyFocus			= 'focu';						{  Control got keyboard focus }
	controlNotifyKey			= 'key ';						{  Control got a keypress }


TYPE
	ControlCapabilities					= UInt32;

CONST
	kControlCanAutoInvalidate	= $00000001;					{  Control component automatically invalidates areas left behind after hide/move operation. }

{  procID's for our added "controls" }
	staticTextProc				= 256;							{  static text }
	editTextProc				= 272;							{  editable text }
	iconProc					= 288;							{  icon }
	userItemProc				= 304;							{  user drawn item }
	pictItemProc				= 320;							{  pict }

{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• ControlHandle																						}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}

TYPE
	ControlRecordPtr = ^ControlRecord;
	ControlPtr							= ^ControlRecord;
	ControlHandle						= ^ControlPtr;
{  ControlRef is obsolete. Use ControlHandle.  }
	ControlRef							= ControlHandle;
	ControlPartCode						= SInt16;
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{ • Control ActionProcPtr																				}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{$IFC TYPED_FUNCTION_POINTERS}
	ControlActionProcPtr = PROCEDURE(theControl: ControlHandle; partCode: ControlPartCode);
{$ELSEC}
	ControlActionProcPtr = ProcPtr;
{$ENDC}

	ControlActionUPP = UniversalProcPtr;
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• ControlRecord																						}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
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

{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{ • Control ActionProcPtr : Epilogue																	}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}

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
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• Control Color Table																				}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}

CONST
	cFrameColor					= 0;
	cBodyColor					= 1;
	cTextColor					= 2;
	cThumbColor					= 3;
	kNumberCtlCTabEntries		= 4;


TYPE
	CtlCTabPtr = ^CtlCTab;
	CtlCTab = RECORD
		ccSeed:					SInt32;
		ccRider:				SInt16;
		ctSize:					SInt16;
		ctTable:				ARRAY [0..3] OF ColorSpec;
	END;

	CCTabPtr							= ^CtlCTab;
	CCTabHandle							= ^CCTabPtr;
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• Auxiliary Control Record																			}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
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
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• PopUp Menu Private Data Structure																	}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
	PopupPrivateDataPtr = ^PopupPrivateData;
	PopupPrivateData = RECORD
		mHandle:				MenuHandle;
		mID:					SInt16;
	END;

	PopupPrivateDataHandle				= ^PopupPrivateDataPtr;

{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• Errors are in the range -30580 .. -30599															}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}

CONST
	errMessageNotSupported		= -30580;
	errDataNotSupported			= -30581;
	errControlDoesntSupportFocus = -30582;
	errWindowDoesntSupportFocus	= -30583;
	errUnknownControl			= -30584;
	errCouldntSetFocus			= -30585;
	errNoRootControl			= -30586;
	errRootAlreadyExists		= -30587;
	errInvalidPartCode			= -30588;
	errControlsAlreadyExist		= -30589;
	errControlIsNotEmbedder		= -30590;
	errDataSizeMismatch			= -30591;
	errControlHiddenOrDisabled	= -30592;
	errWindowRegionCodeInvalid	= -30593;
	errCantEmbedIntoSelf		= -30594;
	errCantEmbedRoot			= -30595;
	errItemNotControl			= -30596;

{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• Control Definition ID’s																			}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{  Standard System 7 procIDs }

	pushButProc					= 0;
	checkBoxProc				= 1;
	radioButProc				= 2;
	scrollBarProc				= 16;
	popupMenuProc				= 1008;


{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• Control Types and ID’s available only with Appearance 1.0 and later								}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}

	kControlSupportsNewMessages	= ' ok ';						{  CDEF should return as result of kControlMsgTestNewMsgSupport }

{ focusing part codes }
	kControlFocusNoPart			= 0;							{  tells control to clear its focus }
	kControlFocusNextPart		= -1;							{  tells control to focus on the next part }
	kControlFocusPrevPart		= -2;							{  tells control to focus on the previous part }


TYPE
	ControlFocusPart					= SInt16;
{ Key Filter result codes 															}
{																					}
{ Certain controls can have a keyfilter attached to them. The filter proc should	}
{ return one of the two constants below. If kKeyFilterBlockKey is returned, the	}
{ key is blocked and never makes it to the control. If kKeyFilterPassKey is		}
{ returned, the control receives the keystroke.									}

CONST
	kControlKeyFilterBlockKey	= 0;
	kControlKeyFilterPassKey	= 1;


TYPE
	ControlKeyFilterResult				= SInt16;
{——————————————————————————————————————————————————————————————————————————————————————}
{ 	SPECIAL FONT USAGE NOTES: You can specify the font to use for many control types.
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
}
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
																{  Meta-font numbering - see not above  }
	kControlFontBigSystemFont	= -1;							{  force to big system font }
	kControlFontSmallSystemFont	= -2;							{  force to small system font }
	kControlFontSmallBoldSystemFont = -3;						{  force to small bold system font }

{ Add these masks together to set the flags field of a ControlFontStyleRec	}
{ They specify which fields to apply to the text. It is important to make	}
{ sure that you specify only the fields that you wish to set.				}
	kControlUseFontMask			= $0001;
	kControlUseFaceMask			= $0002;
	kControlUseSizeMask			= $0004;
	kControlUseForeColorMask	= $0008;
	kControlUseBackColorMask	= $0010;
	kControlUseModeMask			= $0020;
	kControlUseJustMask			= $0040;
	kControlUseAllMask			= $00FF;
	kControlAddFontSizeMask		= $0100;


TYPE
	ControlFontStyleRecPtr = ^ControlFontStyleRec;
	ControlFontStyleRec = RECORD
		flags:					SInt16;
		font:					SInt16;
		size:					SInt16;
		style:					SInt16;
		mode:					SInt16;
		just:					SInt16;
		foreColor:				RGBColor;
		backColor:				RGBColor;
	END;

	ControlFontStylePtr					= ^ControlFontStyleRec;
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• Common data tags for Get/SetControlData															}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kControlFontStyleTag		= 'font';
	kControlKeyFilterTag		= 'fltr';


{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• Control Feature Bits																				}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
																{  Control feature bits - returned by GetControlFeatures  }
	kControlSupportsGhosting	= $01;
	kControlSupportsEmbedding	= $02;
	kControlSupportsFocus		= $04;
	kControlWantsIdle			= $08;
	kControlWantsActivate		= $10;
	kControlHandlesTracking		= $20;
	kControlSupportsDataAccess	= $40;
	kControlHasSpecialBackground = $80;
	kControlGetsFocusOnClick	= $0100;
	kControlSupportsCalcBestRect = $0200;
	kControlSupportsLiveFeedback = $0400;

{ Features introduced in Appearance 1.0.1 }
	kControlHasRadioBehavior	= $0800;

{ Control Messages }
	kControlMsgDrawGhost		= 13;
	kControlMsgCalcBestRect		= 14;							{  Calculate best fitting rectangle for control }
	kControlMsgHandleTracking	= 15;
	kControlMsgFocus			= 16;							{  param indicates action. }
	kControlMsgKeyDown			= 17;
	kControlMsgIdle				= 18;
	kControlMsgGetFeatures		= 19;
	kControlMsgSetData			= 20;
	kControlMsgGetData			= 21;
	kControlMsgActivate			= 22;
	kControlMsgSetUpBackground	= 23;
	kControlMsgCalcValueFromPos	= 26;
	kControlMsgTestNewMsgSupport = 27;							{  See if this control supports new messaging }

{ Messages in Appearance 1.0.1 or later}
	kControlMsgSubValueChanged	= 25;
	kControlMsgSubControlAdded	= 28;
	kControlMsgSubControlRemoved = 29;

{——————————————————————————————————————————————————————————————————————————————————————}
{ 	This structure is passed into a CDEF when called with the kControlMsgHandleTracking	}
{	message 																			}
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	ControlTrackingRecPtr = ^ControlTrackingRec;
	ControlTrackingRec = RECORD
		startPt:				Point;
		modifiers:				SInt16;
		action:					ControlActionUPP;
	END;

	ControlTrackingPtr					= ^ControlTrackingRec;
{——————————————————————————————————————————————————————————————————————————————————————}
{ This structure is passed into a CDEF when called with the kControlMsgKeyDown message }
{——————————————————————————————————————————————————————————————————————————————————————}
	ControlKeyDownRecPtr = ^ControlKeyDownRec;
	ControlKeyDownRec = RECORD
		modifiers:				SInt16;
		keyCode:				SInt16;
		charCode:				SInt16;
	END;

	ControlKeyDownPtr					= ^ControlKeyDownRec;
{——————————————————————————————————————————————————————————————————————————————————————}
{ This structure is passed into a CDEF when called with the kControlMsgGetData or		}
{ kControlMsgSetData message 															}
{——————————————————————————————————————————————————————————————————————————————————————}
	ControlDataAccessRecPtr = ^ControlDataAccessRec;
	ControlDataAccessRec = RECORD
		tag:					ResType;
		part:					ResType;
		size:					Size;
		dataPtr:				Ptr;
	END;

	ControlDataAccessPtr				= ^ControlDataAccessRec;
{——————————————————————————————————————————————————————————————————————————————————————}
{ This structure is passed into a CDEF when called with the kControlCalcBestRect msg 	}
{——————————————————————————————————————————————————————————————————————————————————————}
	ControlCalcSizeRecPtr = ^ControlCalcSizeRec;
	ControlCalcSizeRec = RECORD
		height:					SInt16;
		width:					SInt16;
		baseLine:				SInt16;
	END;

	ControlCalcSizePtr					= ^ControlCalcSizeRec;
{——————————————————————————————————————————————————————————————————————————————————————}
{ This structure is passed into a CDEF when called with the kControlMsgSetUpBackground }
{ message is sent																		}
{——————————————————————————————————————————————————————————————————————————————————————}
	ControlBackgroundRecPtr = ^ControlBackgroundRec;
	ControlBackgroundRec = RECORD
		depth:					SInt16;
		colorDevice:			BOOLEAN;
	END;

	ControlBackgroundPtr				= ^ControlBackgroundRec;
{——————————————————————————————————————————————————————————————————————————————————————}
{ This structure is passed into a CDEF when called with the kControlMsgApplyTextColor	}
{ message is sent																		}
{——————————————————————————————————————————————————————————————————————————————————————}
	ControlApplyTextColorRecPtr = ^ControlApplyTextColorRec;
	ControlApplyTextColorRec = RECORD
		depth:					SInt16;
		colorDevice:			BOOLEAN;
		active:					BOOLEAN;
	END;

	ControlApplyTextColorPtr			= ^ControlApplyTextColorRec;
{——————————————————————————————————————————————————————————————————————————————————————}
{	Key Filter																			}
{																						}
{ Definition of a key filter for intercepting and possibly changing keystrokes			}
{ which are destined for a control														}
{——————————————————————————————————————————————————————————————————————————————————————}
{$IFC TYPED_FUNCTION_POINTERS}
	ControlKeyFilterProcPtr = FUNCTION(theControl: ControlHandle; VAR keyCode: SInt16; VAR charCode: SInt16; VAR modifiers: SInt16): ControlKeyFilterResult;
{$ELSEC}
	ControlKeyFilterProcPtr = ProcPtr;
{$ENDC}

	ControlKeyFilterUPP = UniversalProcPtr;

CONST
	uppControlKeyFilterProcInfo = $00003FE0;

FUNCTION NewControlKeyFilterProc(userRoutine: ControlKeyFilterProcPtr): ControlKeyFilterUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallControlKeyFilterProc(theControl: ControlHandle; VAR keyCode: SInt16; VAR charCode: SInt16; VAR modifiers: SInt16; userRoutine: ControlKeyFilterUPP): ControlKeyFilterResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————}
{	• BEVEL BUTTON INTERFACE (CDEF 2)													}
{——————————————————————————————————————————————————————————————————————————————————————}
{	Bevel buttons allow you to control the content type (pict/icon/etc.), the behavior	}
{ (pushbutton/toggle/sticky), and the bevel size. You also have the option of			}
{	attaching a menu to it. When a menu is present, you can specify which way the 		}
{	popup arrow is facing (down or right).												}
{																						}
{	This is all made possible by overloading the Min, Max, and Value parameters for the	}
{	control, as well as adjusting the variant. Here's the breakdown of what goes where:	}
{																						}
{	Parameter					What Goes Here											}
{	———————————————————			————————————————————————————————————————————————————	}
{	Min							Hi Byte = Behavior, Lo Byte = content type.				}
{	Max							ResID for resource-based content types.					}
{	Value						MenuID to attach, 0 = no menu, please.					}
{																						}
{	The variant is broken down into two halfs. The low 2 bits control the bevel type.	}
{	Bit 2 controls the popup arrow direction (if a menu is present) and bit 3 controls	}
{	whether or not to use the control's owning window's font.							}
{																						}
{	Constants for all you need to put this together are below. The values for behaviors	}
{	are set up so that you can simply add them to the content type and pass them into	}
{	the Min parameter of NewControl.													}
{																						}
{	An example call:																	}
{																						}
{	control = NewControl( window, &bounds, "\p", true, 0, kContentIconSuiteRes + 		}
{							kBehaviorToggles, myIconSuiteID, bevelButtonSmallBevelProc,	}
{							0L );														}
{																						}
{	Attaching a menu:																	}
{																						}
{	control = NewControl( window, &bounds, "\p", true, kMyMenuID, kContentIconSuiteRes,	}
{			myIconSuiteID, bevelButtonSmallBevelProc + kBevelButtonMenuOnRight, 0L );	}
{																						}
{	This will attach menu ID kMyMenuID to the button, with the popup arrow facing right.}
{	This also puts the menu up to the right of the button. You can also specify that a	}
{	menu can have multiple items checked at once by adding kBehaviorMultiValueMenus		}
{	into the Min parameter. If you do use multivalue menus, the GetBevelButtonMenuValue	}
{	helper function will return the last item chosen from the menu, whether or not it	}
{	was checked.																		}
{																						}
{	NOTE: 	Bevel buttons with menus actually have *two* values. The value of the 		}
{			button (on/off), and the value of the menu. The menu value can be gotten	}
{			with the GetBevelButtonMenuValue helper function.							}
{																						}
{	Handle-based Content																}
{	————————————————————																}
{	You can create your control and then set the content to an existing handle to an	}
{	icon suite, etc. using the macros below. Please keep in mind that resource-based	}
{	content is owned by the control, handle-based content is owned by you. The CDEF will}
{	not try to dispose of handle-based content. If you are changing the content type of	}
{	the button on the fly, you must make sure that if you are replacing a handle-		}
{	based content with a resource-based content to properly dispose of the handle,		}
{	else a memory leak will ensue.														}
{																						}

CONST
																{  Bevel Button Proc IDs  }
	kControlBevelButtonSmallBevelProc = 32;
	kControlBevelButtonNormalBevelProc = 33;
	kControlBevelButtonLargeBevelProc = 34;

																{  Bevel button graphic alignment values  }
	kControlBevelButtonAlignSysDirection = -1;					{  only left or right }
	kControlBevelButtonAlignCenter = 0;
	kControlBevelButtonAlignLeft = 1;
	kControlBevelButtonAlignRight = 2;
	kControlBevelButtonAlignTop	= 3;
	kControlBevelButtonAlignBottom = 4;
	kControlBevelButtonAlignTopLeft = 5;
	kControlBevelButtonAlignBottomLeft = 6;
	kControlBevelButtonAlignTopRight = 7;
	kControlBevelButtonAlignBottomRight = 8;


TYPE
	ControlButtonGraphicAlignment		= SInt16;

CONST
																{  Bevel button text alignment values  }
	kControlBevelButtonAlignTextSysDirection = 0;
	kControlBevelButtonAlignTextCenter = 1;
	kControlBevelButtonAlignTextFlushRight = -1;
	kControlBevelButtonAlignTextFlushLeft = -2;


TYPE
	ControlButtonTextAlignment			= SInt16;

CONST
																{  Bevel button text placement values  }
	kControlBevelButtonPlaceSysDirection = -1;					{  if graphic on right, then on left }
	kControlBevelButtonPlaceNormally = 0;
	kControlBevelButtonPlaceToRightOfGraphic = 1;
	kControlBevelButtonPlaceToLeftOfGraphic = 2;
	kControlBevelButtonPlaceBelowGraphic = 3;
	kControlBevelButtonPlaceAboveGraphic = 4;


TYPE
	ControlButtonTextPlacement			= SInt16;
{ Add these variant codes to kBevelButtonSmallBevelProc to change the type of button }

CONST
	kControlBevelButtonSmallBevelVariant = 0;
	kControlBevelButtonNormalBevelVariant = $01;
	kControlBevelButtonLargeBevelVariant = $02;
	kControlBevelButtonMenuOnRight = $04;

{
   Behaviors of bevel buttons. These are set up so you can add
   them together with the content types.
}
	kControlBehaviorPushbutton	= 0;
	kControlBehaviorToggles		= $0100;
	kControlBehaviorSticky		= $0200;
	kControlBehaviorMultiValueMenu = $4000;						{  only makes sense when a menu is attached. }
	kControlBehaviorOffsetContents = $8000;

{ Behaviors for 1.0.1 or later }
	kControlBehaviorCommandMenu	= $2000;						{  menu holds commands, not choices. Overrides multi-value bit. }

{  Content types supported by bevel buttons *and* image wells }
	kControlContentTextOnly		= 0;
	kControlContentIconSuiteRes	= 1;
	kControlContentCIconRes		= 2;
	kControlContentPictRes		= 3;
	kControlContentIconSuiteHandle = 129;
	kControlContentCIconHandle	= 130;
	kControlContentPictHandle	= 131;
	kControlContentIconRef		= 132;


TYPE
	ControlContentType					= SInt16;
{ Data tags supported by the bevel button controls }

CONST
	kControlBevelButtonContentTag = 'cont';						{  ButtonContentInfo }
	kControlBevelButtonTransformTag = 'tran';					{  IconTransformType }
	kControlBevelButtonTextAlignTag = 'tali';					{  ButtonTextAlignment }
	kControlBevelButtonTextOffsetTag = 'toff';					{  SInt16 }
	kControlBevelButtonGraphicAlignTag = 'gali';				{  ButtonGraphicAlignment }
	kControlBevelButtonGraphicOffsetTag = 'goff';				{  Point }
	kControlBevelButtonTextPlaceTag = 'tplc';					{  ButtonTextPlacement }
	kControlBevelButtonMenuValueTag = 'mval';					{  SInt16 }
	kControlBevelButtonMenuHandleTag = 'mhnd';					{  MenuHandle }
	kControlBevelButtonCenterPopupGlyphTag = 'pglc';			{  Boolean: true = center, false = bottom right }

{ These are tags in 1.0.1 or later }
	kControlBevelButtonLastMenuTag = 'lmnu';					{  SInt16: menuID of last menu item selected from }
	kControlBevelButtonMenuDelayTag = 'mdly';					{  SInt32: ticks to delay before menu appears }

{ Structure to pass into bevel buttons and image wells to set/get content type }

TYPE
	ControlButtonContentInfoPtr = ^ControlButtonContentInfo;
	ControlButtonContentInfo = RECORD
		contentType:			ControlContentType;
		CASE INTEGER OF
		0: (
			resID:				SInt16;
			);
		1: (
			cIconHandle:		CIconHandle;
			);
		2: (
			iconSuite:			Handle;
			);
		3: (
			iconRef:			Handle;
			);
		4: (
			picture:			PicHandle;
			);
	END;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• SLIDER (CDEF 3)																	}
{——————————————————————————————————————————————————————————————————————————————————————}
{	There are several variants that control the behavior of the slider control. Any		}
{	combination of the following three constants can be added to the basic CDEF ID		}
{	(kSliderProc).																		}
{																						}
{	Variants:																			}
{																						}
{		kSliderLiveFeedback	 	Slider does not use "ghosted" indicator when tracking.	}
{								ActionProc is called (set via SetControlAction) as the	}
{								indicator is dragged. The value is updated so that the	}
{								actionproc can adjust some other property based on the	}
{								value each time the action proc is called. If no action	}
{								proc is installed, it reverts to the ghost indicator.	}
{																						}
{		kSliderHasTickMarks	 	Slider is drawn with 'tick marks'. The control			}
{								rectangle must be large enough to accomidate the tick	}
{								marks.													}
{																						}
{		kSliderReverseDirection	Slider thumb points in opposite direction than normal.	}
{								If the slider is vertical, the thumb will point to the	}
{								left, if the slider is horizontal, the thumb will point	}
{								upwards.												}
{																						}
{		kSliderNonDirectional	This option overrides the kSliderReverseDirection and	}
{								kSliderHasTickMarks variants. It creates an indicator	}
{								which is rectangular and doesn't point in any direction	}
{								like the normal indicator does.							}

CONST
																{  Slider proc IDs  }
	kControlSliderProc			= 48;
	kControlSliderLiveFeedback	= $01;
	kControlSliderHasTickMarks	= $02;
	kControlSliderReverseDirection = $04;
	kControlSliderNonDirectional = $08;


{——————————————————————————————————————————————————————————————————————————————————————}
{	• DISCLOSURE TRIANGLE (CDEF 4)														}
{——————————————————————————————————————————————————————————————————————————————————————}
{	This control can be used as either left or right facing. It can also handle its own	}
{	tracking if you wish. This means that when the 'autotoggle' variant is used, if the	}
{	user clicks the control, it's state will change automatically from open to closed	}
{	and vice-versa depending on its initial state. After a successful call to Track-	}
{ 	Control, you can just check the current value to see what state it was switched to.	}
																{  Triangle proc IDs  }
	kControlTriangleProc		= 64;
	kControlTriangleLeftFacingProc = 65;
	kControlTriangleAutoToggleProc = 66;
	kControlTriangleLeftFacingAutoToggleProc = 67;

																{  Tagged data supported by disclosure triangles  }
	kControlTriangleLastValueTag = 'last';						{  SInt16 }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• PROGRESS INDICATOR (CDEF 5)														}
{——————————————————————————————————————————————————————————————————————————————————————}
{	This CDEF implements both determinate and indeterminate progress bars. To switch, 	}
{	just use SetControlData to set the indeterminate flag to make it indeterminate call	}
{	IdleControls to step thru the animation. IdleControls should be called at least		}
{	once during your event loop.														}
{																						}
																{  Progress Bar proc IDs  }
	kControlProgressBarProc		= 80;

																{  Tagged data supported by progress bars  }
	kControlProgressBarIndeterminateTag = 'inde';				{  Boolean }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• LITTLE ARROWS (CDEF 6)															}
{——————————————————————————————————————————————————————————————————————————————————————}
{ 	This control implements the little up and down arrows you'd see in the Memory		}
{	control panel for adjusting the cache size. 										}
																{  Little Arrows proc IDs  }
	kControlLittleArrowsProc	= 96;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• CHASING ARROWS (CDEF 7)															}
{——————————————————————————————————————————————————————————————————————————————————————}
{	To animate this control, make sure to call IdleControls repeatedly.					}
{																						}
																{  Chasing Arrows proc IDs  }
	kControlChasingArrowsProc	= 112;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• TABS (CDEF 8)																		}
{——————————————————————————————————————————————————————————————————————————————————————}
{	Tabs use an auxiliary resource (tab#) to hold tab information such as the tab name	}
{	and an icon suite ID for each tab.													}
{																						}
{	The ID of the tab# resource that you wish to associate with a tab control should 	}
{	be passed in as the Value parameter of the control. If you are using GetNewControl, }
{	then the Value slot in the CNTL resource should have the ID of the 'tab#' resource	}
{	on creation.																		}
{																						}
{	Passing zero in for the tab# resource tells the control not to read in a tab# res.	}
{	You can then use SetControlMaximum to add tabs, followed by a call to SetControlData}
{	with the kControlTabInfoTag, passing in a pointer to a ControlTabInfoRec. This sets	}
{ 	the name and optionally an icon for a tab.											}
																{  Tabs proc IDs  }
	kControlTabLargeProc		= 128;							{  Large tab size, north facing	 }
	kControlTabSmallProc		= 129;							{  Small tab size, north facing	 }
	kControlTabLargeNorthProc	= 128;							{  Large tab size, north facing	 }
	kControlTabSmallNorthProc	= 129;							{  Small tab size, north facing	 }
	kControlTabLargeSouthProc	= 130;							{  Large tab size, south facing	 }
	kControlTabSmallSouthProc	= 131;							{  Small tab size, south facing	 }
	kControlTabLargeEastProc	= 132;							{  Large tab size, east facing	 }
	kControlTabSmallEastProc	= 133;							{  Small tab size, east facing	 }
	kControlTabLargeWestProc	= 134;							{  Large tab size, west facing	 }
	kControlTabSmallWestProc	= 135;							{  Small tab size, west facing	 }

																{  Tagged data supported by progress bars  }
	kControlTabContentRectTag	= 'rect';						{  Rect }
	kControlTabEnabledFlagTag	= 'enab';						{  Boolean }
	kControlTabFontStyleTag		= 'font';						{  ControlFontStyleRec }

{ New tags in 1.0.1 or later }
	kControlTabInfoTag			= 'tabi';						{  ControlTabInfoRec }

	kControlTabInfoVersionZero	= 0;


TYPE
	ControlTabInfoRecPtr = ^ControlTabInfoRec;
	ControlTabInfoRec = RECORD
		version:				SInt16;									{  version of this structure. }
		iconSuiteID:			SInt16;									{  icon suite to use. Zero indicates no icon }
		name:					Str255;									{  name to be displayed on the tab }
	END;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• VISUAL SEPARATOR (CDEF 9)															}
{——————————————————————————————————————————————————————————————————————————————————————}
{	Separator lines determine their orientation (horizontal or vertical) automatically	}
{	based on the relative height and width of their contrlRect.							}

CONST
																{  Visual separator proc IDs  }
	kControlSeparatorLineProc	= 144;


{——————————————————————————————————————————————————————————————————————————————————————}
{	• GROUP BOX (CDEF 10)																}
{——————————————————————————————————————————————————————————————————————————————————————}
{	The group box CDEF can be use in several ways. It can have no title, a text title, 	}
{	a check box as the title, or a popup button as a title. There are two versions of 	}
{	group boxes, primary and secondary, which look slightly different.					}
																{  Group Box proc IDs  }
	kControlGroupBoxTextTitleProc = 160;
	kControlGroupBoxCheckBoxProc = 161;
	kControlGroupBoxPopupButtonProc = 162;
	kControlGroupBoxSecondaryTextTitleProc = 164;
	kControlGroupBoxSecondaryCheckBoxProc = 165;
	kControlGroupBoxSecondaryPopupButtonProc = 166;

																{  Tagged data supported by group box  }
	kControlGroupBoxMenuHandleTag = 'mhan';						{  MenuHandle (popup title only) }
	kControlGroupBoxFontStyleTag = 'font';						{  ControlFontStyleRec }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• IMAGE WELL (CDEF 11)																}
{——————————————————————————————————————————————————————————————————————————————————————}
{	Image Wells allow you to control the content type (pict/icon/etc.) shown in the 	}
{	well.																				}
{																						}
{	This is made possible by overloading the Min and Value parameters for the control.	}
{																						}
{	Parameter					What Goes Here											}
{	———————————————————			——————————————————————————————————————————————————		}
{	Min							content type (see constants for bevel buttons)			}
{	Value						Resource ID of content type, if resource-based.			}
{																						}
{																						}
{	Handle-based Content																}
{	————————————————————																}
{	You can create your control and then set the content to an existing handle to an	}
{	icon suite, etc. using the macros below. Please keep in mind that resource-based	}
{	content is owned by the control, handle-based content is owned by you. The CDEF will}
{	not try to dispose of handle-based content. If you are changing the content type of	}
{	the button on the fly, you must make sure that if you are replacing a handle-		}
{	based content with a resource-based content to properly dispose of the handle,		}
{	else a memory leak will ensue.														}
{																						}
																{  Image Well proc IDs  }
	kControlImageWellProc		= 176;

																{  Tagged data supported by image wells  }
	kControlImageWellContentTag	= 'cont';						{  ButtonContentInfo }
	kControlImageWellTransformTag = 'tran';						{  IconTransformType }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• POPUP ARROW (CDEF 12)																}
{——————————————————————————————————————————————————————————————————————————————————————}
{	The popup arrow CDEF is used to draw the small arrow normally associated with a 	}
{	popup control. The arrow can point in four directions, and a small or large version }
{	can be used. This control is provided to allow clients to draw the arrow in a 		}
{	normalized fashion which will take advantage of themes automatically.				}
{																						}
																{  Popup Arrow proc IDs  }
	kControlPopupArrowEastProc	= 192;
	kControlPopupArrowWestProc	= 193;
	kControlPopupArrowNorthProc	= 194;
	kControlPopupArrowSouthProc	= 195;
	kControlPopupArrowSmallEastProc = 196;
	kControlPopupArrowSmallWestProc = 197;
	kControlPopupArrowSmallNorthProc = 198;
	kControlPopupArrowSmallSouthProc = 199;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• PLACARD (CDEF 14)																	}
{——————————————————————————————————————————————————————————————————————————————————————}
																{  Placard proc IDs  }
	kControlPlacardProc			= 224;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• CLOCK (CDEF 15)																	}
{——————————————————————————————————————————————————————————————————————————————————————}
{ 	NOTE:	You can specify more options in the Value paramter when creating the clock.	}
{			See below.																	}
																{  Clock proc IDs  }
	kControlClockTimeProc		= 240;
	kControlClockTimeSecondsProc = 241;
	kControlClockDateProc		= 242;
	kControlClockMonthYearProc	= 243;

{——————————————————————————————————————————————————————————————————————————————————————}
{ 	These flags can be passed into 'value' field on creation of the control.			}
{ 	Value is set to 0 after control is created.											}
{																						}
{	The kClockIsLive value tells the clock to automatically update on idle (clock will	}
{	have the current time). This flag is only valid when the kClockIsDisplayOnly flag	}
{	is set.																				}
{——————————————————————————————————————————————————————————————————————————————————————}
	kControlClockNoFlags		= 0;
	kControlClockIsDisplayOnly	= 1;
	kControlClockIsLive			= 2;

																{  Tagged data supported by clocks  }
	kControlClockLongDateTag	= 'date';						{  LongDateRec }
	kControlClockFontStyleTag	= 'font';						{  ControlFontStyleRec }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• USER PANE (CDEF 16)																}
{——————————————————————————————————————————————————————————————————————————————————————}
																{  User Pane proc IDs  }
	kControlUserPaneProc		= 256;

{ Tagged data supported by user panes }
{ Currently, they are all proc ptrs for doing things like drawing and hit testing, etc. }
	kControlUserItemDrawProcTag	= 'uidp';						{  UserItemUPP }
	kControlUserPaneDrawProcTag	= 'draw';						{  ControlUserPaneDrawingUPP }
	kControlUserPaneHitTestProcTag = 'hitt';					{  ControlUserPaneHitTestUPP }
	kControlUserPaneTrackingProcTag = 'trak';					{  ControlUserPaneTrackingUPP }
	kControlUserPaneIdleProcTag	= 'idle';						{  ControlUserPaneIdleUPP }
	kControlUserPaneKeyDownProcTag = 'keyd';					{  ControlUserPaneKeyDownUPP }
	kControlUserPaneActivateProcTag = 'acti';					{  ControlUserPaneActivateUPP }
	kControlUserPaneFocusProcTag = 'foci';						{  ControlUserPaneFocusUPP }
	kControlUserPaneBackgroundProcTag = 'back';					{  ControlUserPaneBackgroundUPP }


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneDrawProcPtr = PROCEDURE(control: ControlHandle; part: SInt16);
{$ELSEC}
	ControlUserPaneDrawProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneHitTestProcPtr = FUNCTION(control: ControlHandle; where: Point): ControlPartCode;
{$ELSEC}
	ControlUserPaneHitTestProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneTrackingProcPtr = FUNCTION(control: ControlHandle; startPt: Point; actionProc: ControlActionUPP): ControlPartCode;
{$ELSEC}
	ControlUserPaneTrackingProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneIdleProcPtr = PROCEDURE(control: ControlHandle);
{$ELSEC}
	ControlUserPaneIdleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneKeyDownProcPtr = FUNCTION(control: ControlHandle; keyCode: SInt16; charCode: SInt16; modifiers: SInt16): ControlPartCode;
{$ELSEC}
	ControlUserPaneKeyDownProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneActivateProcPtr = PROCEDURE(control: ControlHandle; activating: BOOLEAN);
{$ELSEC}
	ControlUserPaneActivateProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneFocusProcPtr = FUNCTION(control: ControlHandle; action: ControlFocusPart): ControlPartCode;
{$ELSEC}
	ControlUserPaneFocusProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ControlUserPaneBackgroundProcPtr = PROCEDURE(control: ControlHandle; info: ControlBackgroundPtr);
{$ELSEC}
	ControlUserPaneBackgroundProcPtr = ProcPtr;
{$ENDC}

	ControlUserPaneDrawUPP = UniversalProcPtr;
	ControlUserPaneHitTestUPP = UniversalProcPtr;
	ControlUserPaneTrackingUPP = UniversalProcPtr;
	ControlUserPaneIdleUPP = UniversalProcPtr;
	ControlUserPaneKeyDownUPP = UniversalProcPtr;
	ControlUserPaneActivateUPP = UniversalProcPtr;
	ControlUserPaneFocusUPP = UniversalProcPtr;
	ControlUserPaneBackgroundUPP = UniversalProcPtr;

CONST
	uppControlUserPaneDrawProcInfo = $000002C0;
	uppControlUserPaneHitTestProcInfo = $000003E0;
	uppControlUserPaneTrackingProcInfo = $00000FE0;
	uppControlUserPaneIdleProcInfo = $000000C0;
	uppControlUserPaneKeyDownProcInfo = $00002AE0;
	uppControlUserPaneActivateProcInfo = $000001C0;
	uppControlUserPaneFocusProcInfo = $000002E0;
	uppControlUserPaneBackgroundProcInfo = $000003C0;

FUNCTION NewControlUserPaneDrawProc(userRoutine: ControlUserPaneDrawProcPtr): ControlUserPaneDrawUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewControlUserPaneHitTestProc(userRoutine: ControlUserPaneHitTestProcPtr): ControlUserPaneHitTestUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewControlUserPaneTrackingProc(userRoutine: ControlUserPaneTrackingProcPtr): ControlUserPaneTrackingUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewControlUserPaneIdleProc(userRoutine: ControlUserPaneIdleProcPtr): ControlUserPaneIdleUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewControlUserPaneKeyDownProc(userRoutine: ControlUserPaneKeyDownProcPtr): ControlUserPaneKeyDownUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewControlUserPaneActivateProc(userRoutine: ControlUserPaneActivateProcPtr): ControlUserPaneActivateUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewControlUserPaneFocusProc(userRoutine: ControlUserPaneFocusProcPtr): ControlUserPaneFocusUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewControlUserPaneBackgroundProc(userRoutine: ControlUserPaneBackgroundProcPtr): ControlUserPaneBackgroundUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallControlUserPaneDrawProc(control: ControlHandle; part: SInt16; userRoutine: ControlUserPaneDrawUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallControlUserPaneHitTestProc(control: ControlHandle; where: Point; userRoutine: ControlUserPaneHitTestUPP): ControlPartCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallControlUserPaneTrackingProc(control: ControlHandle; startPt: Point; actionProc: ControlActionUPP; userRoutine: ControlUserPaneTrackingUPP): ControlPartCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallControlUserPaneIdleProc(control: ControlHandle; userRoutine: ControlUserPaneIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallControlUserPaneKeyDownProc(control: ControlHandle; keyCode: SInt16; charCode: SInt16; modifiers: SInt16; userRoutine: ControlUserPaneKeyDownUPP): ControlPartCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallControlUserPaneActivateProc(control: ControlHandle; activating: BOOLEAN; userRoutine: ControlUserPaneActivateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallControlUserPaneFocusProc(control: ControlHandle; action: ControlFocusPart; userRoutine: ControlUserPaneFocusUPP): ControlPartCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallControlUserPaneBackgroundProc(control: ControlHandle; info: ControlBackgroundPtr; userRoutine: ControlUserPaneBackgroundUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{
  ——————————————————————————————————————————————————————————————————————————————————————————
  	• EDIT TEXT (CDEF 17)
  ——————————————————————————————————————————————————————————————————————————————————————————
}

CONST
																{  Edit Text proc IDs  }
	kControlEditTextProc		= 272;
	kControlEditTextDialogProc	= 273;
	kControlEditTextPasswordProc = 274;
	kControlEditTextDialogPasswordProc = 275;

																{  Tagged data supported by edit text  }
	kControlEditTextStyleTag	= 'font';						{  ControlFontStyleRec }
	kControlEditTextTextTag		= 'text';						{  Buffer of chars - you supply the buffer }
	kControlEditTextTEHandleTag	= 'than';						{  The TEHandle of the text edit record }
	kControlEditTextKeyFilterTag = 'fltr';
	kControlEditTextSelectionTag = 'sele';						{  EditTextSelectionRec }
	kControlEditTextPasswordTag	= 'pass';						{  The clear text password text }


TYPE
	ControlEditTextSelectionRecPtr = ^ControlEditTextSelectionRec;
	ControlEditTextSelectionRec = RECORD
																		{  Structure for getting the edit text selection  }
		selStart:				SInt16;
		selEnd:					SInt16;
	END;

	ControlEditTextSelectionPtr			= ^ControlEditTextSelectionRec;
{——————————————————————————————————————————————————————————————————————————————————————}
{	• STATIC TEXT (CDEF 18)																}
{——————————————————————————————————————————————————————————————————————————————————————}
{ Static Text proc IDs }

CONST
	kControlStaticTextProc		= 288;

{ Tagged data supported by static text }
	kControlStaticTextStyleTag	= 'font';						{  ControlFontStyleRec }
	kControlStaticTextTextTag	= 'text';						{  Copy of text }
	kControlStaticTextTextHeightTag = 'thei';					{  SInt16 }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• PICTURE CONTROL (CDEF 19)															}
{——————————————————————————————————————————————————————————————————————————————————————}
{	Value parameter should contain the ID of the picture you wish to display when		}
{	creating controls of this type. If you don't want the control tracked at all, use 	}
{	the 'no track' variant.																}
																{  Picture control proc IDs  }
	kControlPictureProc			= 304;
	kControlPictureNoTrackProc	= 305;							{  immediately returns kControlPicturePart }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• ICON CONTROL (CDEF 20)															}
{——————————————————————————————————————————————————————————————————————————————————————}
{	Value parameter should contain the ID of the ICON or cicn you wish to display when	}
{	creating controls of this type. If you don't want the control tracked at all, use 	}
{	the 'no track' variant.																}
{ Icon control proc IDs }
	kControlIconProc			= 320;
	kControlIconNoTrackProc		= 321;							{  immediately returns kControlIconPart }
	kControlIconSuiteProc		= 322;
	kControlIconSuiteNoTrackProc = 323;							{  immediately returns kControlIconPart }

{ Tagged data supported by icon controls }
	kControlIconTransformTag	= 'trfm';						{  IconTransformType }
	kControlIconAlignmentTag	= 'algn';						{  IconAlignmentType }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• WINDOW HEADER (CDEF 21)															}
{——————————————————————————————————————————————————————————————————————————————————————}
																{  Window Header proc IDs  }
	kControlWindowHeaderProc	= 336;							{  normal header }
	kControlWindowListViewHeaderProc = 337;						{  variant for list views - no bottom line }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• LIST BOX (CDEF 22)																}
{——————————————————————————————————————————————————————————————————————————————————————}
{	Lists use an auxiliary resource to define their format. The resource type used is 	}
{	'ldes' and a definition for it can be found in Appearance.r. The resource ID for 	}
{	the ldes is passed in the 'value' parameter when creating the control. You may pass }
{	zero in value. This tells the List Box control to not use a resource. The list will }
{	be created with default values, and will use the standard LDEF (0). You can change	}
{	the list by getting the list handle. You can set the LDEF to use by using the tag	}
{	below (kControlListBoxLDEFTag)														}
																{  List Box proc IDs  }
	kControlListBoxProc			= 352;
	kControlListBoxAutoSizeProc	= 353;

																{  Tagged data supported by list box  }
	kControlListBoxListHandleTag = 'lhan';						{  ListHandle }
	kControlListBoxKeyFilterTag	= 'fltr';						{  ControlKeyFilterUPP }
	kControlListBoxFontStyleTag	= 'font';						{  ControlFontStyleRec }

{ New tags in 1.0.1 or later }
	kControlListBoxDoubleClickTag = 'dblc';						{  Boolean. Was last click a double-click? }
	kControlListBoxLDEFTag		= 'ldef';						{  SInt16. ID of LDEF to use.  }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• PUSH BUTTON (CDEF 23)																}
{——————————————————————————————————————————————————————————————————————————————————————}
{	The new standard checkbox and radio button controls support a "mixed" value that	}
{	indicates that the current setting contains a mixed set of on and off values. The 	}
{	control value used to display this indication is defined in Controls.h:				}
{																						}
{		kControlCheckBoxMixedValue = 2													}
{																						}
{	Two new variants of the standard pushbutton have been added to the standard control	}
{	suite that draw a color icon next to the control title. One variant draws the icon	}
{	on the left side, the other draws it on the right side (when the system justifica-	}
{	tion is right to left, these are reversed).											}
{																						}
{	When either of the icon pushbuttons are created, the contrlMax field of the control }
{	record is used to determine the ID of the 'cicn' resource drawn in the pushbutton.	}
{																						}
{	In addition, a push button can now be told to draw with a default outline using the	}
{	SetControlData routine with the kPushButtonDefaultTag below.						}
{																						}
																{  Theme Push Button/Check Box/Radio Button proc IDs  }
	kControlPushButtonProc		= 368;
	kControlCheckBoxProc		= 369;
	kControlRadioButtonProc		= 370;
	kControlPushButLeftIconProc	= 374;							{  Standard pushbutton with left-side icon }
	kControlPushButRightIconProc = 375;							{  Standard pushbutton with right-side icon }

																{  Tagged data supported by standard buttons  }
	kControlPushButtonDefaultTag = 'dflt';						{  default ring flag }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• SCROLL BAR (CDEF 24)																}
{——————————————————————————————————————————————————————————————————————————————————————}
{	This is the new Appearance scroll bar.												}
{																						}
																{  Theme Scroll Bar proc IDs  }
	kControlScrollBarProc		= 384;							{  normal scroll bar }
	kControlScrollBarLiveProc	= 386;							{  live scrolling variant }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• POPUP BUTTON (CDEF 25)															}
{——————————————————————————————————————————————————————————————————————————————————————}
{	This is the new Appearance Popup Button. It takes the same variants and does the 	}
{	same overloading as the previous popup menu control. There are some differences:	}
{																						}
{	Passing in a menu ID of -12345 causes the popup not to try and get the menu from a	}
{	resource. Instead, you can build the menu and later stuff the menuhandle field in 	}
{	the popup data information.															}
{																						}
{	You can pass -1 in the Max parameter to have the control calculate the width of the	}
{	title on its own instead of guessing and then tweaking to get it right. It adds the	}
{	appropriate amount of space between the title and the popup.						}
{																						}
																{  Theme Popup Button proc IDs  }
	kControlPopupButtonProc		= 400;
	kControlPopupFixedWidthVariant = $01;
	kControlPopupVariableWidthVariant = $02;
	kControlPopupUseAddResMenuVariant = $04;
	kControlPopupUseWFontVariant = $08;							{  kControlUsesOwningWindowsFontVariant }

{ These tags are available in 1.0.1 or later of Appearance }
	kControlPopupButtonMenuHandleTag = 'mhan';					{  MenuHandle }
	kControlPopupButtonMenuIDTag = 'mnid';						{  SInt16 }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• RADIO GROUP (CDEF 26)																}
{——————————————————————————————————————————————————————————————————————————————————————}
{	This control implements a radio group. It is an embedding control and can therefore	}
{ 	only be used when a control hierarchy is established for its owning window. You		}
{	should only embed radio buttons within it. As radio buttons are embedded into it,	}
{	the group sets up its value, min, and max to represent the number of embedded items.}
{	The current value of the control is the index of the sub-control that is the current}
{	'on' radio button. To get the current radio button control handle, you can use the	}
{	control manager call GetIndSubControl, passing in the value of the radio group.		}
{																						}
{	NOTE: This control is only available with Appearance 1.0.1.							}
	kControlRadioGroupProc		= 416;


{   —— end of stuff only available with Appearance 1.0 and later }


{——————————————————————————————————————————————————————————————————————————————————————}
{	• Control Variants																	}
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	ControlVariant						= SInt16;

CONST
	kControlNoVariant			= 0;							{  No variant }
	kControlUsesOwningWindowsFontVariant = $08;					{  Control uses owning windows font to display text }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• Control Part Codes																}
{——————————————————————————————————————————————————————————————————————————————————————}
	kControlNoPart				= 0;
	kControlLabelPart			= 1;
	kControlMenuPart			= 2;
	kControlTrianglePart		= 4;
	kControlEditTextPart		= 5;							{  Appearance 1.0 and later }
	kControlPicturePart			= 6;							{  Appearance 1.0 and later }
	kControlIconPart			= 7;							{  Appearance 1.0 and later }
	kControlClockPart			= 8;							{  Appearance 1.0 and later }
	kControlListBoxPart			= 24;							{  Appearance 1.0 and later }
	kControlListBoxDoubleClickPart = 25;						{  Appearance 1.0 and later }
	kControlImageWellPart		= 26;							{  Appearance 1.0 and later }
	kControlRadioGroupPart		= 27;							{  Appearance 1.1 and later }
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

{——————————————————————————————————————————————————————————————————————————————————————}
{	• Check Box Values																	}
{——————————————————————————————————————————————————————————————————————————————————————}
	kControlCheckBoxUncheckedValue = 0;
	kControlCheckBoxCheckedValue = 1;
	kControlCheckBoxMixedValue	= 2;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• Radio Button Values																}
{——————————————————————————————————————————————————————————————————————————————————————}
	kControlRadioButtonUncheckedValue = 0;
	kControlRadioButtonCheckedValue = 1;
	kControlRadioButtonMixedValue = 2;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• Pop-Up Menu Control Constants														}
{——————————————————————————————————————————————————————————————————————————————————————}
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

{——————————————————————————————————————————————————————————————————————————————————————}
{ 	• DragGrayRgn Constatns																}
{																						}
{   For DragGrayRgnUPP used in TrackControl() 											}
{——————————————————————————————————————————————————————————————————————————————————————}
	noConstraint				= 0;
	hAxisOnly					= 1;
	vAxisOnly					= 2;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• Control Creation/Deletion															}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION NewControl(owningWindow: WindowPtr; {CONST}VAR boundsRect: Rect; controlTitle: Str255; initiallyVisible: BOOLEAN; initialValue: SInt16; minimumValue: SInt16; maximumValue: SInt16; procID: SInt16; controlReference: SInt32): ControlHandle;
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
{——————————————————————————————————————————————————————————————————————————————————————}
{	• Control Visible State																}
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE HiliteControl(theControl: ControlHandle; hiliteState: ControlPartCode);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95D;
	{$ENDC}
PROCEDURE ShowControl(theControl: ControlHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A957;
	{$ENDC}
PROCEDURE HideControl(theControl: ControlHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A958;
	{$ENDC}

{  following state routines available only with Appearance 1.0 and later }
FUNCTION IsControlActive(inControl: ControlHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0005, $AA73;
	{$ENDC}
FUNCTION IsControlVisible(inControl: ControlHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0006, $AA73;
	{$ENDC}
FUNCTION ActivateControl(inControl: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0007, $AA73;
	{$ENDC}
FUNCTION DeactivateControl(inControl: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0008, $AA73;
	{$ENDC}
FUNCTION SetControlVisibility(inControl: ControlHandle; inIsVisible: BOOLEAN; inDoDraw: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001E, $AA73;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{	• Control Imaging																	}
{——————————————————————————————————————————————————————————————————————————————————————}
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

{  following imaging routines available only with Appearance 1.0 and later }
FUNCTION GetBestControlRect(inControl: ControlHandle; VAR outRect: Rect; VAR outBaseLineOffset: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001B, $AA73;
	{$ENDC}
FUNCTION SetControlFontStyle(inControl: ControlHandle; {CONST}VAR inStyle: ControlFontStyleRec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001C, $AA73;
	{$ENDC}
PROCEDURE DrawControlInCurrentPort(inControl: ControlHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0018, $AA73;
	{$ENDC}
FUNCTION SetUpControlBackground(inControl: ControlHandle; inDepth: SInt16; inIsColorDevice: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001D, $AA73;
	{$ENDC}
{  SetUpControlTextColor is available in Appearance 1.1 or later. }
FUNCTION SetUpControlTextColor(inControl: ControlHandle; inDepth: SInt16; inIsColorDevice: BOOLEAN): OSErr;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• Control Mousing																	}
{——————————————————————————————————————————————————————————————————————————————————————}
{
	NOTE ON CONTROL ACTION PROCS
	
	When using the TrackControl() call when tracking an indicator, the actionProc parameter
	(type ControlActionUPP) should be replaced by a parameter of type DragGrayRgnUPP
	(see Quickdraw.h).
	
	If, however, you are using the live feedback variants of scroll bars or sliders, you
	can pass a ControlActionUPP in when tracking the indicator as well. This functionality
	is available in Appearance 1.0 or later.
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
{ The following mousing routines available only with Appearance 1.0 and later	}
{																				}
{ FindControlUnderMouse is preferrable to TrackControl when running under		}
{ Appearance 1.0 as you can pass in modifiers, which some of the new controls	}
{ use, such as edit text and list boxes.										}
FUNCTION FindControlUnderMouse(inWhere: Point; inWindow: WindowPtr; VAR outPart: SInt16): ControlHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0009, $AA73;
	{$ENDC}
FUNCTION HandleControlClick(inControl: ControlHandle; inWhere: Point; inModifiers: SInt16; inAction: ControlActionUPP): SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000A, $AA73;
	{$ENDC}



{——————————————————————————————————————————————————————————————————————————————————————}
{	• Control Events (available only with Appearance 1.0 and later)						}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION HandleControlKey(inControl: ControlHandle; inKeyCode: SInt16; inCharCode: SInt16; inModifiers: SInt16): SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000B, $AA73;
	{$ENDC}
PROCEDURE IdleControls(inWindow: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000C, $AA73;
	{$ENDC}


{——————————————————————————————————————————————————————————————————————————————————————}
{	• Control Positioning																}
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE MoveControl(theControl: ControlHandle; h: SInt16; v: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A959;
	{$ENDC}
PROCEDURE SizeControl(theControl: ControlHandle; w: SInt16; h: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95C;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————}
{	• Control Title																		}
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE SetControlTitle(theControl: ControlHandle; title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95F;
	{$ENDC}
PROCEDURE GetControlTitle(theControl: ControlHandle; VAR title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A95E;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————}
{	• Control Value																		}
{——————————————————————————————————————————————————————————————————————————————————————}
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
{——————————————————————————————————————————————————————————————————————————————————————}
{	• Control Variant																	}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION GetControlVariant(theControl: ControlHandle): ControlVariant;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A809;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————}
{	• Control Action																	}
{——————————————————————————————————————————————————————————————————————————————————————}
PROCEDURE SetControlAction(theControl: ControlHandle; actionProc: ControlActionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A96B;
	{$ENDC}
FUNCTION GetControlAction(theControl: ControlHandle): ControlActionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A96A;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Control Accessors																	}
{——————————————————————————————————————————————————————————————————————————————————————}
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
{——————————————————————————————————————————————————————————————————————————————————————}
{	• HELPERS (available only with Appearance 1.0 and later)							}
{																						}
{ These routines are available only thru the shared library/glue						}
{ Bevel button routines																}
{——————————————————————————————————————————————————————————————————————————————————————}

FUNCTION GetBevelButtonMenuValue(inButton: ControlHandle; VAR outValue: SInt16): OSErr;
FUNCTION SetBevelButtonMenuValue(inButton: ControlHandle; inValue: SInt16): OSErr;
FUNCTION GetBevelButtonMenuHandle(inButton: ControlHandle; VAR outHandle: MenuHandle): OSErr;
FUNCTION GetBevelButtonContentInfo(inButton: ControlHandle; outContent: ControlButtonContentInfoPtr): OSErr;
FUNCTION SetBevelButtonContentInfo(inButton: ControlHandle; inContent: ControlButtonContentInfoPtr): OSErr;
FUNCTION SetBevelButtonTransform(inButton: ControlHandle; transform: IconTransformType): OSErr;
FUNCTION SetBevelButtonGraphicAlignment(inButton: ControlHandle; inAlign: ControlButtonGraphicAlignment; inHOffset: SInt16; inVOffset: SInt16): OSErr;
FUNCTION SetBevelButtonTextAlignment(inButton: ControlHandle; inAlign: ControlButtonTextAlignment; inHOffset: SInt16): OSErr;
FUNCTION SetBevelButtonTextPlacement(inButton: ControlHandle; inWhere: ControlButtonTextPlacement): OSErr;
{  Image well routines }

FUNCTION GetImageWellContentInfo(inButton: ControlHandle; outContent: ControlButtonContentInfoPtr): OSErr;
FUNCTION SetImageWellContentInfo(inButton: ControlHandle; inContent: ControlButtonContentInfoPtr): OSErr;
FUNCTION SetImageWellTransform(inButton: ControlHandle; inTransform: IconTransformType): OSErr;
{  Tab routines }

FUNCTION GetTabContentRect(inTabControl: ControlHandle; VAR outContentRect: Rect): OSErr;
FUNCTION SetTabEnabled(inTabControl: ControlHandle; inTabToHilite: SInt16; inEnabled: BOOLEAN): OSErr;
{  Disclosure triangles }

FUNCTION SetDisclosureTriangleLastValue(inTabControl: ControlHandle; inValue: SInt16): OSErr;
{——————————————————————————————————————————————————————————————————————————————————————}
{	• Control Hierarchy (Appearance 1.0 and later only)									}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION SendControlMessage(inControl: ControlHandle; inMessage: SInt16; inParam: SInt32): SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $FFFE, $AA73;
	{$ENDC}
FUNCTION DumpControlHierarchy(inWindow: WindowPtr; {CONST}VAR inDumpFile: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $FFFF, $AA73;
	{$ENDC}
FUNCTION CreateRootControl(inWindow: WindowPtr; VAR outControl: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0001, $AA73;
	{$ENDC}
FUNCTION GetRootControl(inWindow: WindowPtr; VAR outControl: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0002, $AA73;
	{$ENDC}
FUNCTION EmbedControl(inControl: ControlHandle; inContainer: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0003, $AA73;
	{$ENDC}
FUNCTION AutoEmbedControl(inControl: ControlHandle; inWindow: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0004, $AA73;
	{$ENDC}
FUNCTION GetSuperControl(inControl: ControlHandle; VAR outParent: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0015, $AA73;
	{$ENDC}
FUNCTION CountSubControls(inControl: ControlHandle; VAR outNumChildren: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0016, $AA73;
	{$ENDC}
FUNCTION GetIndexedSubControl(inControl: ControlHandle; inIndex: SInt16; VAR outSubControl: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0017, $AA73;
	{$ENDC}
FUNCTION SetControlSupervisor(inControl: ControlHandle; inBoss: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001A, $AA73;
	{$ENDC}


{——————————————————————————————————————————————————————————————————————————————————————}
{	• Keyboard Focus (available only with Appearance 1.0 and later)						}
{——————————————————————————————————————————————————————————————————————————————————————}
FUNCTION GetKeyboardFocus(inWindow: WindowPtr; VAR outControl: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000D, $AA73;
	{$ENDC}
FUNCTION SetKeyboardFocus(inWindow: WindowPtr; inControl: ControlHandle; inPart: ControlFocusPart): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000E, $AA73;
	{$ENDC}
FUNCTION AdvanceKeyboardFocus(inWindow: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000F, $AA73;
	{$ENDC}
FUNCTION ReverseKeyboardFocus(inWindow: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0010, $AA73;
	{$ENDC}
FUNCTION ClearKeyboardFocus(inWindow: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0019, $AA73;
	{$ENDC}


{——————————————————————————————————————————————————————————————————————————————————————}
{	• Control Data (available only with Appearance 1.0 and later)						}
{——————————————————————————————————————————————————————————————————————————————————————}

FUNCTION GetControlFeatures(inControl: ControlHandle; VAR outFeatures: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0011, $AA73;
	{$ENDC}
FUNCTION SetControlData(inControl: ControlHandle; inPart: ControlPartCode; inTagName: ResType; inSize: Size; inData: Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0012, $AA73;
	{$ENDC}
FUNCTION GetControlData(inControl: ControlHandle; inPart: ControlPartCode; inTagName: ResType; inBufferSize: Size; inBuffer: Ptr; VAR outActualSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0013, $AA73;
	{$ENDC}
FUNCTION GetControlDataSize(inControl: ControlHandle; inPart: ControlPartCode; inTagName: ResType; VAR outMaxSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0014, $AA73;
	{$ENDC}



{——————————————————————————————————————————————————————————————————————————————————————}
{	• ‘CDEF’ messages																	}
{——————————————————————————————————————————————————————————————————————————————————————}

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

{——————————————————————————————————————————————————————————————————————————————————————}
{	• ‘CDEF’ entrypoint																	}
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ControlDefProcPtr = FUNCTION(varCode: SInt16; theControl: ControlHandle; message: ControlDefProcMessage; param: SInt32): SInt32;
{$ELSEC}
	ControlDefProcPtr = ProcPtr;
{$ENDC}

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
{——————————————————————————————————————————————————————————————————————————————————————}
{	• Constants for drawCntl message (passed in param)									}
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	kDrawControlEntireControl	= 0;
	kDrawControlIndicatorOnly	= 129;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• Constants for dragCntl message (passed in param)									}
{——————————————————————————————————————————————————————————————————————————————————————}
	kDragControlEntireControl	= 0;
	kDragControlIndicator		= 1;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• Drag Constraint Structure for thumbCntl message (passed in param)					}
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	IndicatorDragConstraintPtr = ^IndicatorDragConstraint;
	IndicatorDragConstraint = RECORD
		limitRect:				Rect;
		slopRect:				Rect;
		axis:					DragConstraint;
	END;

	IndicatorDragConstraintHandle		= ^IndicatorDragConstraintPtr;


{$IFC NOT TARGET_OS_MAC }
{——————————————————————————————————————————————————————————————————————————————————————}
{	• QuickTime 3.0 Win32/unix notification	mechanism									}
{——————————————————————————————————————————————————————————————————————————————————————}
{  Proc used to notify window that something happened to the control }
{$IFC TYPED_FUNCTION_POINTERS}
	ControlNotificationProcPtr = PROCEDURE(theWindow: WindowPtr; theControl: ControlHandle; notification: ControlNotification; param1: LONGINT; param2: LONGINT); C;
{$ELSEC}
	ControlNotificationProcPtr = ProcPtr;
{$ENDC}

{
   Proc used to prefilter events before handled by control.  A client of a control calls
   CTRLSetPreFilterProc() to have the control call this proc before handling the event.
   If the proc returns TRUE, the control can go ahead and handle the event.
}
{$IFC TYPED_FUNCTION_POINTERS}
	PreFilterEventProc = FUNCTION(theControl: ControlHandle; VAR theEvent: EventRecord): BOOLEAN; C;
{$ELSEC}
	PreFilterEventProc = ProcPtr;
{$ENDC}

FUNCTION GetControlComponentInstance(theControl: ControlHandle): LONGINT; C;
FUNCTION GetControlHandleFromCookie(cookie: LONGINT): ControlHandle; C;
PROCEDURE SetControlDefProc(resID: INTEGER; proc: ControlDefProcPtr); C;
{$ENDC}

{$IFC OLDROUTINENAMES }
{——————————————————————————————————————————————————————————————————————————————————————}
{	• OLDROUTINENAMES																	}
{——————————————————————————————————————————————————————————————————————————————————————}
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
