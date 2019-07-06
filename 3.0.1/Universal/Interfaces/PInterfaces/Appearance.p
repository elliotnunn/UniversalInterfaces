{
 	File:		Appearance.p
 
 	Contains:	Appearance Manager & SDK Interfaces.
 
 	Version:	Technology:	Appearance 1.0
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1994-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Appearance;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __APPEARANCE__}
{$SETC __APPEARANCE__ := 1}

{$I+}
{$SETC AppearanceIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __ICONS__}
{$I Icons.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}
{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}
{$IFC UNDEFINED __QDOFFSCREEN__}
{$I QDOffscreen.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————}
{ Appearance Manager constants, etc.												}
{——————————————————————————————————————————————————————————————————————————————————}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  Appearance Trap Number  }
	_AppearanceDispatch			= $AA74;

{ Gestalt selector and values for the Appearance Manager }
	gestaltAppearanceAttr		= 'appr';
	gestaltAppearanceExists		= 0;
	gestaltAppearanceCompatMode	= 1;

{ Appearance Manager Error Codes }
	appearanceBadBrushIndexErr	= -30560;						{  pattern index invalid  }
	appearanceProcessRegisteredErr = -30561;
	appearanceProcessNotRegisteredErr = -30562;
	appearanceBadTextColorIndexErr = -30563;

	kThemeActiveDialogBackgroundBrush = 1;						{  Dialogs  }
	kThemeInactiveDialogBackgroundBrush = 2;					{  Dialogs  }
	kThemeActiveAlertBackgroundBrush = 3;
	kThemeInactiveAlertBackgroundBrush = 4;
	kThemeActiveModelessDialogBackgroundBrush = 5;
	kThemeInactiveModelessDialogBackgroundBrush = 6;
	kThemeActiveUtilityWindowBackgroundBrush = 7;				{  Miscellaneous  }
	kThemeInactiveUtilityWindowBackgroundBrush = 8;				{  Miscellaneous  }
	kThemeListViewSortColumnBackgroundBrush = 9;				{  Finder  }
	kThemeListViewBackgroundBrush = 10;
	kThemeIconLabelBackgroundBrush = 11;
	kThemeListViewSeparatorBrush = 12;
	kThemeChasingArrowsBrush	= 13;
	kThemeDragHiliteBrush		= 14;
	kThemeDocumentWindowBackgroundBrush = 15;
	kThemeFinderWindowBackgroundBrush = 16;


TYPE
	ThemeBrush							= SInt16;

CONST
	kThemeActiveDialogTextColor	= 1;							{  Dialogs  }
	kThemeInactiveDialogTextColor = 2;
	kThemeActiveAlertTextColor	= 3;
	kThemeInactiveAlertTextColor = 4;
	kThemeActiveModelessDialogTextColor = 5;
	kThemeInactiveModelessDialogTextColor = 6;
	kThemeActiveWindowHeaderTextColor = 7;						{  Primitives  }
	kThemeInactiveWindowHeaderTextColor = 8;
	kThemeActivePlacardTextColor = 9;							{  Primitives  }
	kThemeInactivePlacardTextColor = 10;
	kThemePressedPlacardTextColor = 11;
	kThemeActivePushButtonTextColor = 12;						{  Primitives  }
	kThemeInactivePushButtonTextColor = 13;
	kThemePressedPushButtonTextColor = 14;
	kThemeActiveBevelButtonTextColor = 15;						{  Primitives  }
	kThemeInactiveBevelButtonTextColor = 16;
	kThemePressedBevelButtonTextColor = 17;
	kThemeActivePopupButtonTextColor = 18;						{  Primitives  }
	kThemeInactivePopupButtonTextColor = 19;
	kThemePressedPopupButtonTextColor = 20;
	kThemeIconLabelTextColor	= 21;							{  Finder  }
	kThemeListViewTextColor		= 22;


TYPE
	ThemeTextColor						= SInt16;
{ States to draw primitives: disabled, active, and pressed (hilited) }

CONST
	kThemeStateDisabled			= 0;
	kThemeStateActive			= 1;
	kThemeStatePressed			= 2;


TYPE
	ThemeDrawState						= UInt32;
{——————————————————————————————————————————————————————————————————————————————————}
{ Window Manager constants, etc.													}
{——————————————————————————————————————————————————————————————————————————————————}

CONST
																{  Resource IDs for new window defprocs  }
	kWindowDocumentDefProcResID	= 64;
	kWindowDialogDefProcResID	= 65;
	kWindowUtilityDefProcResID	= 66;
	kWindowUtilitySideTitleDefProcResID = 67;

																{  Proc IDs for theme-savvy windows  }
	kWindowDocumentProc			= 1024;
	kWindowGrowDocumentProc		= 1025;
	kWindowHorizZoomDocumentProc = 1026;
	kWindowHorizZoomGrowDocumentProc = 1027;
	kWindowVertZoomDocumentProc	= 1028;
	kWindowVertZoomGrowDocumentProc = 1029;
	kWindowFullZoomDocumentProc	= 1030;
	kWindowFullZoomGrowDocumentProc = 1031;

																{  Proc IDs for theme-savvy dialogs  }
	kWindowPlainDialogProc		= 1040;
	kWindowShadowDialogProc		= 1041;
	kWindowModalDialogProc		= 1042;
	kWindowMovableModalDialogProc = 1043;
	kWindowAlertProc			= 1044;
	kWindowMovableAlertProc		= 1045;

																{  Proc IDs for top title bar theme-savvy floating windows  }
	kWindowFloatProc			= 1057;
	kWindowFloatGrowProc		= 1059;
	kWindowFloatHorizZoomProc	= 1061;
	kWindowFloatHorizZoomGrowProc = 1063;
	kWindowFloatVertZoomProc	= 1065;
	kWindowFloatVertZoomGrowProc = 1067;
	kWindowFloatFullZoomProc	= 1069;
	kWindowFloatFullZoomGrowProc = 1071;

																{  Proc IDs for side title bar theme-savvy floating windows  }
	kWindowFloatSideProc		= 1073;
	kWindowFloatSideGrowProc	= 1075;
	kWindowFloatSideHorizZoomProc = 1077;
	kWindowFloatSideHorizZoomGrowProc = 1079;
	kWindowFloatSideVertZoomProc = 1081;
	kWindowFloatSideVertZoomGrowProc = 1083;
	kWindowFloatSideFullZoomProc = 1085;
	kWindowFloatSideFullZoomGrowProc = 1087;

																{  Region values to pass into GetWindowRegion  }
	kWindowTitleBarRgn			= 0;
	kWindowTitleTextRgn			= 1;
	kWindowCloseBoxRgn			= 2;
	kWindowZoomBoxRgn			= 3;
	kWindowDragRgn				= 5;
	kWindowGrowRgn				= 6;
	kWindowCollapseBoxRgn		= 7;
	kWindowStructureRgn			= 32;
	kWindowContentRgn			= 33;


TYPE
	WindowRegionCode					= UInt16;

CONST
																{  Window Features returned by GetWindowFeatures  }
	kWindowCanGrow				= $01;
	kWindowCanZoom				= $02;
	kWindowCanCollapse			= $04;
	kWindowIsModal				= $08;
	kWindowCanGetWindowRegion	= $10;
	kWindowIsAlert				= $20;
	kWindowHasTitleBar			= $40;

																{  New window messages  }
	kWindowMsgGetFeatures		= 7;
	kWindowMsgGetRegion			= 8;

																{  New Window part codes  }
	inCollapseBox				= 11;

																{  Window Definition hit test result codes ("WindowPart") }
	wInCollapseBox				= 9;

{ Window positioning constants }
	kWindowDefaultPosition		= $0000;
	kWindowCenterMainScreen		= $280A;
	kWindowAlertPositionMainScreen = $300A;
	kWindowStaggerMainScreen	= $380A;
	kWindowCenterParentWindow	= $A80A;
	kWindowAlertPositionParentWindow = $B00A;
	kWindowStaggerParentWindow	= $B80A;
	kWindowCenterParentWindowScreen = $680A;
	kWindowAlertPositionParentWindowScreen = $700A;
	kWindowStaggerParentWindowScreen = $780A;

{ GetWindowRegionRec - used for WDEF calls with kWindowMsgGetRegion }

TYPE
	GetWindowRegionRecPtr = ^GetWindowRegionRec;
	GetWindowRegionRec = RECORD
		winRgn:					RgnHandle;
		regionCode:				WindowRegionCode;
	END;

	GetWindowRegionPtr					= ^GetWindowRegionRec;
{——————————————————————————————————————————————————————————————————————————————————}
{ Dialog Manager constants, etc.													}
{——————————————————————————————————————————————————————————————————————————————————}

CONST
																{  Alert types to pass into StandardAlert  }
	kAlertStopAlert				= 0;
	kAlertNoteAlert				= 1;
	kAlertCautionAlert			= 2;
	kAlertPlainAlert			= 3;


TYPE
	AlertType							= SInt16;

CONST
	kAlertDefaultOKText			= -1;							{  "OK" }
	kAlertDefaultCancelText		= -1;							{  "Cancel" }
	kAlertDefaultOtherText		= -1;							{  "Don't Save" }

{ StandardAlert alert button numbers }
	kAlertStdAlertOKButton		= 1;
	kAlertStdAlertCancelButton	= 2;
	kAlertStdAlertOtherButton	= 3;
	kAlertStdAlertHelpButton	= 4;

																{  Dialog Flags for use in NewFeaturesDialog or dlgx resource  }
	kDialogFlagsUseThemeBackground = $01;
	kDialogFlagsUseControlHierarchy = $02;
	kDialogFlagsHandleMovableModal = $04;
	kDialogFlagsUseThemeControls = $08;

																{  Alert Flags for use in alrx resource  }
	kAlertFlagsUseThemeBackground = $01;
	kAlertFlagsUseControlHierarchy = $02;
	kAlertFlagsAlertIsMovable	= $04;
	kAlertFlagsUseThemeControls	= $08;

{ For dftb resource }
	kDialogFontNoFontStyle		= 0;
	kDialogFontUseFontMask		= $0001;
	kDialogFontUseFaceMask		= $0002;
	kDialogFontUseSizeMask		= $0004;
	kDialogFontUseForeColorMask	= $0008;
	kDialogFontUseBackColorMask	= $0010;
	kDialogFontUseModeMask		= $0020;
	kDialogFontUseJustMask		= $0040;
	kDialogFontUseAllMask		= $00FF;
	kDialogFontAddFontSizeMask	= $0100;
	kDialogFontUseFontMaskMask	= $0200;


TYPE
	AlertStdAlertParamRecPtr = ^AlertStdAlertParamRec;
	AlertStdAlertParamRec = RECORD
		movable:				BOOLEAN;								{  Make alert movable modal  }
		helpButton:				BOOLEAN;								{  Is there a help button?  }
		filterProc:				ModalFilterUPP;							{  Event filter  }
		defaultText:			StringPtr;								{  Text for button in OK position  }
		cancelText:				StringPtr;								{  Text for button in cancel position  }
		otherText:				StringPtr;								{  Text for button in left position  }
		defaultButton:			SInt16;									{  Which button behaves as the default  }
		cancelButton:			SInt16;									{  Which one behaves as cancel (can be 0)  }
		position:				UInt16;									{  Position (kWindowDefaultPosition in this case  }
																		{  equals kWindowAlertPositionParentWindowScreen)  }
	END;

	AlertStdAlertParamPtr				= ^AlertStdAlertParamRec;
{——————————————————————————————————————————————————————————————————————————————————}
{ Control Manager constants, etc.													}
{——————————————————————————————————————————————————————————————————————————————————}

CONST
	_ControlDispatch			= $AA73;

																{  resource types for new controls  }
	kControlTabListResType		= 'tab#';						{  used for tab control only }
	kControlListDescResType		= 'ldes';						{  used for list box control only }

																{  new part codes for new controls  }
	kControlEditTextPart		= 5;
	kControlPicturePart			= 6;
	kControlIconPart			= 7;
	kControlClockPart			= 8;
	kControlListBoxPart			= 24;
	kControlListBoxDoubleClickPart = 25;

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
{——————————————————————————————————————————————————————————————————————————————————————}
{ Common data tags for Get/SetControlData												}
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	kControlFontStyleTag		= 'font';
	kControlKeyFilterTag		= 'fltr';

{——————————————————————————————————————————————————————————————————————————————————————}
{ Errors are in the range -30580 .. -30599												}
{——————————————————————————————————————————————————————————————————————————————————————}
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

																{  Control Messages  }
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
	kControlMsgCalcValue		= 24;
	kControlMsgSubControlHit	= 25;
	kControlMsgCalcValueFromPos	= 26;
	kControlMsgTestNewMsgSupport = 27;							{  See if this control supports new messaging }

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
{	Key Filter																			}
{																						}
{ Definition of a key filter for intercepting and possibly changing keystrokes			}
{ which are destined for a control														}
{——————————————————————————————————————————————————————————————————————————————————————}
	ControlKeyFilterProcPtr = ProcPtr;  { FUNCTION ControlKeyFilter(theControl: ControlHandle; VAR keyCode: SInt16; VAR charCode: SInt16; VAR modifiers: SInt16): ControlKeyFilterResult; }

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
{
/*		kSliderReverseDirection	Slider thumb points in opposite direction than normal.	}
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
																{  Tabs proc IDs  }
	kControlTabLargeProc		= 128;							{  Large tab size	 }
	kControlTabSmallProc		= 129;							{  Small tab size	 }

																{  Tagged data supported by progress bars  }
	kControlTabContentRectTag	= 'rect';						{  Rect }
	kControlTabEnabledFlagTag	= 'enab';						{  Boolean }
	kControlTabFontStyleTag		= 'font';						{  ControlFontStyleRec }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• VISUAL SEPARATOR (CDEF 9)															}
{——————————————————————————————————————————————————————————————————————————————————————}
{	Separator lines determine their orientation (horizontal or vertical) automatically	}
{	based on the relative height and width of their contrlRect.							}
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
{	Checked State																		}
{	—————————————																		}
{	The checked state is enabled by setting the value of the control to 1, just like a 	}
{	check box.																			}
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
{																						}
{	AutoTracking																		}
{	————————————																		}
{	Image Wells are capable of autotracking. The current autotracking feature sets the 	}
{	value itself, so that the control remains hilited. It behaves as a sort of palette 	}
{	type object where clicking selects it, it cannot be delected by clicking it again, 	}
{	clicking on another object should cause the focus to change (as in Get Info windows)}
{	and the application should then set the value to 0 to take away the checked border.	}
{																						}
																{  Image Well proc IDs  }
	kControlImageWellProc		= 176;
	kControlImageWellAutoTrackProc = 177;

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
	ControlUserPaneDrawProcPtr = ProcPtr;  { PROCEDURE ControlUserPaneDraw(control: ControlHandle; part: SInt16); }

	ControlUserPaneHitTestProcPtr = ProcPtr;  { FUNCTION ControlUserPaneHitTest(control: ControlHandle; where: Point): ControlPartCode; }

	ControlUserPaneTrackingProcPtr = ProcPtr;  { FUNCTION ControlUserPaneTracking(control: ControlHandle; startPt: Point; actionProc: ControlActionUPP): ControlPartCode; }

	ControlUserPaneIdleProcPtr = ProcPtr;  { PROCEDURE ControlUserPaneIdle(control: ControlHandle); }

	ControlUserPaneKeyDownProcPtr = ProcPtr;  { FUNCTION ControlUserPaneKeyDown(control: ControlHandle; keyCode: SInt16; charCode: SInt16; modifiers: SInt16): ControlPartCode; }

	ControlUserPaneActivateProcPtr = ProcPtr;  { PROCEDURE ControlUserPaneActivate(control: ControlHandle; activating: BOOLEAN); }

	ControlUserPaneFocusProcPtr = ProcPtr;  { FUNCTION ControlUserPaneFocus(control: ControlHandle; action: ControlFocusPart): ControlPartCode; }

	ControlUserPaneBackgroundProcPtr = ProcPtr;  { PROCEDURE ControlUserPaneBackground(control: ControlHandle; info: ControlBackgroundPtr); }

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
{	the ldes is passed in the 'value' parameter when creating the control.				}
																{  List Box proc IDs  }
	kControlListBoxProc			= 352;
	kControlListBoxAutoSizeProc	= 353;

																{  Tagged data supported by list box  }
	kControlListBoxListHandleTag = 'lhan';						{  ListHandle }
	kControlListBoxKeyFilterTag	= 'fltr';						{  ControlKeyFilterUPP }
	kControlListBoxFontStyleTag	= 'font';						{  ControlFontStyleRec }

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
	kControlPopupUseWFontVariant = $08;

{——————————————————————————————————————————————————————————————————————————————————}
{ Menu Manager constants, etc.														}
{——————————————————————————————————————————————————————————————————————————————————}
	kMenuStdMenuProc			= 63;
	kMenuStdMenuBarProc			= 63;

	kMenuNoModifiers			= 0;							{  Mask for no modifiers }
	kMenuShiftModifier			= $01;							{  Mask for shift key modifier }
	kMenuOptionModifier			= $02;							{  Mask for option key modifier }
	kMenuControlModifier		= $04;							{  Mask for control key modifier }
	kMenuNoCommandModifier		= $08;							{  Mask for no command key modifier }

	kMenuNoIcon					= 0;							{  No icon }
	kMenuIconType				= 1;							{  Type for ICON }
	kMenuShrinkIconType			= 2;							{  Type for ICON plotted 16 x 16 }
	kMenuSmallIconType			= 3;							{  Type for SICN }
	kMenuColorIconType			= 4;							{  Type for cicn }
	kMenuIconSuiteType			= 5;							{  Type for Icon Suite }
	kMenuIconRefType			= 6;							{  Type for Icon Ref }

{——————————————————————————————————————————————————————————————————————————————————}
{	Appearance Manager APIs															}
{——————————————————————————————————————————————————————————————————————————————————}
{ Registering Appearance-Savvy Applications }
FUNCTION RegisterAppearanceClient: OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0015, $AA74;
	{$ENDC}
FUNCTION UnregisterAppearanceClient: OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0016, $AA74;
	{$ENDC}
{****************************************************************************
	NOTES ON THEME BRUSHES
	Theme brushes can be either colors or patterns, depending on the theme.
	Because of this, you should be prepared to handle the case where a brush
	is a pattern and save and restore the pnPixPat and bkPixPat fields of
	your GrafPorts when saving the fore and back colors. Also, since patterns
	in bkPixPat override the background color of the window, you should use
	BackPat to set your background pattern to a normal white pattern. This
	will ensure that you can use RGBBackColor to set your back color to white,
	call EraseRect and get the expected results.
****************************************************************************}

FUNCTION SetThemePen(brush: ThemeBrush; depth: SInt16; colorDevice: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0001, $AA74;
	{$ENDC}
FUNCTION SetThemeBackground(brush: ThemeBrush; depth: SInt16; colorDevice: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0002, $AA74;
	{$ENDC}
FUNCTION SetThemeTextColor(color: ThemeTextColor; depth: SInt16; colorDevice: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0003, $AA74;
	{$ENDC}
FUNCTION SetThemeWindowBackground(window: WindowPtr; brush: ThemeBrush; update: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0004, $AA74;
	{$ENDC}

{ Window Placards, Headers and Frames }
FUNCTION DrawThemeWindowHeader({CONST}VAR rect: Rect; state: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0005, $AA74;
	{$ENDC}
FUNCTION DrawThemeWindowListViewHeader({CONST}VAR rect: Rect; state: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0006, $AA74;
	{$ENDC}
FUNCTION DrawThemePlacard({CONST}VAR rect: Rect; state: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0007, $AA74;
	{$ENDC}
FUNCTION DrawThemeEditTextFrame({CONST}VAR rect: Rect; state: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0009, $AA74;
	{$ENDC}
FUNCTION DrawThemeListBoxFrame({CONST}VAR rect: Rect; state: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000A, $AA74;
	{$ENDC}
{ Keyboard Focus Drawing }
FUNCTION DrawThemeFocusRect({CONST}VAR rect: Rect; hasFocus: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000B, $AA74;
	{$ENDC}
{ Dialog Group Boxes and Separators }
FUNCTION DrawThemePrimaryGroup({CONST}VAR rect: Rect; state: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000C, $AA74;
	{$ENDC}
FUNCTION DrawThemeSecondaryGroup({CONST}VAR rect: Rect; state: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000D, $AA74;
	{$ENDC}
FUNCTION DrawThemeSeparator({CONST}VAR rect: Rect; state: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000E, $AA74;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————}
{	Window Manager APIs																}
{——————————————————————————————————————————————————————————————————————————————————}
FUNCTION GetWindowFeatures(window: WindowPtr; VAR features: UInt32): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0013, $AA74;
	{$ENDC}
FUNCTION IsWindowCollapsable(window: WindowPtr): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000F, $AA74;
	{$ENDC}
FUNCTION IsWindowCollapsed(window: WindowPtr): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0010, $AA74;
	{$ENDC}
FUNCTION CollapseWindow(window: WindowPtr; collapseIt: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0011, $AA74;
	{$ENDC}
FUNCTION CollapseAllWindows(collapseEm: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0012, $AA74;
	{$ENDC}
FUNCTION GetWindowRegion(window: WindowPtr; regionCode: WindowRegionCode; winRgn: RgnHandle): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0014, $AA74;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————}
{	Dialog Manager APIs																}
{——————————————————————————————————————————————————————————————————————————————————}
FUNCTION NewFeaturesDialog(wStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: ConstStr255Param; visible: BOOLEAN; procID: SInt16; behind: WindowPtr; goAwayFlag: BOOLEAN; refCon: SInt32; itmLstHndl: Handle; flags: UInt32): DialogPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $110C, $AA68;
	{$ENDC}
FUNCTION AutoSizeDialog(dialog: DialogPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020D, $AA68;
	{$ENDC}
FUNCTION StandardAlert(alertType: AlertType; error: StringPtr; explanation: StringPtr; alertParam: AlertStdAlertParamPtr; VAR itemHit: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $090E, $AA68;
	{$ENDC}
FUNCTION GetDialogItemAsControl(dialog: DialogPtr; itemNo: SInt16; VAR control: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050F, $AA68;
	{$ENDC}
FUNCTION MoveDialogItem(dialog: DialogPtr; itemNo: SInt16; horiz: SInt16; vert: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0510, $AA68;
	{$ENDC}
FUNCTION SizeDialogItem(dialog: DialogPtr; itemNo: SInt16; height: SInt16; width: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0511, $AA68;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————}
{	Control Manager APIs															}
{——————————————————————————————————————————————————————————————————————————————————}
{
   These routines are available only thru the shared library/glue
   Bevel button routines
}

FUNCTION GetBevelButtonMenuValue(button: ControlHandle; VAR value: SInt16): OSErr;
FUNCTION SetBevelButtonMenuValue(button: ControlHandle; value: SInt16): OSErr;
FUNCTION GetBevelButtonMenuHandle(button: ControlHandle; VAR handle: MenuHandle): OSErr;
FUNCTION GetBevelButtonContentInfo(button: ControlHandle; content: ControlButtonContentInfoPtr): OSErr;
FUNCTION SetBevelButtonContentInfo(button: ControlHandle; content: ControlButtonContentInfoPtr): OSErr;
FUNCTION SetBevelButtonTransform(button: ControlHandle; transform: IconTransformType): OSErr;
FUNCTION SetBevelButtonGraphicAlignment(button: ControlHandle; align: ControlButtonGraphicAlignment; hOffset: SInt16; vOffset: SInt16): OSErr;
FUNCTION SetBevelButtonTextAlignment(button: ControlHandle; align: ControlButtonTextAlignment; hOffset: SInt16): OSErr;
FUNCTION SetBevelButtonTextPlacement(button: ControlHandle; where: ControlButtonTextPlacement): OSErr;
{  Image well routines }

FUNCTION GetImageWellContentInfo(button: ControlHandle; content: ControlButtonContentInfoPtr): OSErr;
FUNCTION SetImageWellContentInfo(button: ControlHandle; content: ControlButtonContentInfoPtr): OSErr;
FUNCTION SetImageWellTransform(button: ControlHandle; transform: IconTransformType): OSErr;
{  Tab routines }

FUNCTION GetTabContentRect(tabControl: ControlHandle; VAR contentRect: Rect): OSErr;
FUNCTION SetTabEnabled(tabControl: ControlHandle; tabToHilite: SInt16; enabled: BOOLEAN): OSErr;
{  Disclosure triangles }

FUNCTION SetDisclosureTriangleLastValue(tabControl: ControlHandle; value: SInt16): OSErr;
{  Trap-based routines }

FUNCTION SendControlMessage(theControl: ControlHandle; message: SInt16; param: SInt32): SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $FFFE, $AA73;
	{$ENDC}
FUNCTION DumpControlHierarchy(window: WindowPtr; {CONST}VAR outFile: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $FFFF, $AA73;
	{$ENDC}
FUNCTION CreateRootControl(window: WindowPtr; VAR control: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0001, $AA73;
	{$ENDC}
FUNCTION GetRootControl(window: WindowPtr; VAR control: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0002, $AA73;
	{$ENDC}
FUNCTION EmbedControl(control: ControlHandle; container: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0003, $AA73;
	{$ENDC}
FUNCTION AutoEmbedControl(control: ControlHandle; window: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0004, $AA73;
	{$ENDC}
FUNCTION IsControlActive(control: ControlHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0005, $AA73;
	{$ENDC}
FUNCTION IsControlVisible(control: ControlHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0006, $AA73;
	{$ENDC}
FUNCTION ActivateControl(control: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0007, $AA73;
	{$ENDC}
FUNCTION DeactivateControl(control: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0008, $AA73;
	{$ENDC}
FUNCTION FindControlUnderMouse(where: Point; window: WindowPtr; VAR part: SInt16): ControlHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0009, $AA73;
	{$ENDC}
FUNCTION HandleControlClick(control: ControlHandle; where: Point; modifiers: SInt16; action: ControlActionUPP): SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000A, $AA73;
	{$ENDC}
FUNCTION HandleControlKey(control: ControlHandle; keyCode: SInt16; charCode: SInt16; modifiers: SInt16): SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000B, $AA73;
	{$ENDC}
PROCEDURE IdleControls(window: WindowPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000C, $AA73;
	{$ENDC}
FUNCTION GetKeyboardFocus(window: WindowPtr; VAR control: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000D, $AA73;
	{$ENDC}
FUNCTION SetKeyboardFocus(window: WindowPtr; control: ControlHandle; part: ControlFocusPart): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000E, $AA73;
	{$ENDC}
FUNCTION AdvanceKeyboardFocus(window: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000F, $AA73;
	{$ENDC}
FUNCTION ReverseKeyboardFocus(window: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0010, $AA73;
	{$ENDC}
FUNCTION GetControlFeatures(control: ControlHandle; VAR features: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0011, $AA73;
	{$ENDC}
FUNCTION SetControlData(control: ControlHandle; part: ControlPartCode; tagName: ResType; size: Size; data: Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0012, $AA73;
	{$ENDC}
FUNCTION GetControlData(control: ControlHandle; part: ControlPartCode; tagName: ResType; bufferSize: Size; buffer: Ptr; VAR actualSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0013, $AA73;
	{$ENDC}
FUNCTION GetControlDataSize(control: ControlHandle; part: ControlPartCode; tagName: ResType; VAR maxSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0014, $AA73;
	{$ENDC}
FUNCTION GetSuperControl(control: ControlHandle; VAR parent: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0015, $AA73;
	{$ENDC}
FUNCTION CountSubControls(control: ControlHandle; VAR numChildren: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0016, $AA73;
	{$ENDC}
FUNCTION GetIndexedSubControl(control: ControlHandle; index: SInt16; VAR subControl: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0017, $AA73;
	{$ENDC}
PROCEDURE DrawControlInCurrentPort(theControl: ControlHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0018, $AA73;
	{$ENDC}
FUNCTION ClearKeyboardFocus(window: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0019, $AA73;
	{$ENDC}
FUNCTION SetControlSupervisor(control: ControlHandle; boss: ControlHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001A, $AA73;
	{$ENDC}
FUNCTION GetBestControlRect(control: ControlHandle; VAR rect: Rect; VAR baseLineOffset: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001B, $AA73;
	{$ENDC}
FUNCTION SetControlFontStyle(control: ControlHandle; VAR style: ControlFontStyleRec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001C, $AA73;
	{$ENDC}
FUNCTION SetUpControlBackground(control: ControlHandle; depth: SInt16; colorDevice: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001D, $AA73;
	{$ENDC}
FUNCTION SetControlVisibility(control: ControlHandle; isVisible: BOOLEAN; draw: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001E, $AA73;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————}
{	Menu Manager APIs																}
{——————————————————————————————————————————————————————————————————————————————————}
FUNCTION MenuEvent({CONST}VAR event: EventRecord): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020C, $A825;
	{$ENDC}
FUNCTION SetMenuItemCommandID(menu: MenuHandle; item: SInt16; commandID: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0502, $A825;
	{$ENDC}
FUNCTION GetMenuItemCommandID(menu: MenuHandle; item: SInt16; VAR commandID: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0503, $A825;
	{$ENDC}
FUNCTION SetMenuItemModifiers(menu: MenuHandle; item: SInt16; modifiers: ByteParameter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0404, $A825;
	{$ENDC}
FUNCTION GetMenuItemModifiers(menu: MenuHandle; item: SInt16; VAR modifiers: UInt8): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0505, $A825;
	{$ENDC}
FUNCTION SetMenuItemIconHandle(menu: MenuHandle; item: SInt16; iconType: ByteParameter; icon: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0606, $A825;
	{$ENDC}
FUNCTION GetMenuItemIconHandle(menu: MenuHandle; item: SInt16; VAR iconType: UInt8; VAR icon: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0707, $A825;
	{$ENDC}
FUNCTION SetMenuItemTextEncoding(menu: MenuHandle; item: SInt16; scriptID: TextEncoding): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0408, $A825;
	{$ENDC}
FUNCTION GetMenuItemTextEncoding(menu: MenuHandle; item: SInt16; VAR scriptID: TextEncoding): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0509, $A825;
	{$ENDC}
FUNCTION SetMenuItemHierarchicalID(menu: MenuHandle; item: SInt16; hierID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040D, $A825;
	{$ENDC}
FUNCTION GetMenuItemHierarchicalID(menu: MenuHandle; item: SInt16; VAR hierID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050E, $A825;
	{$ENDC}
FUNCTION SetMenuItemFontID(menu: MenuHandle; item: SInt16; fontID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040F, $A825;
	{$ENDC}
FUNCTION GetMenuItemFontID(menu: MenuHandle; item: SInt16; VAR fontID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0510, $A825;
	{$ENDC}
FUNCTION SetMenuItemRefCon(menu: MenuHandle; item: SInt16; refCon: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050A, $A825;
	{$ENDC}
FUNCTION GetMenuItemRefCon(menu: MenuHandle; item: SInt16; VAR refCon: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050B, $A825;
	{$ENDC}
FUNCTION SetMenuItemRefCon2(menu: MenuHandle; item: SInt16; refCon2: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0511, $A825;
	{$ENDC}
FUNCTION GetMenuItemRefCon2(menu: MenuHandle; item: SInt16; VAR refCon2: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0512, $A825;
	{$ENDC}
FUNCTION SetMenuItemKeyGlyph(menu: MenuHandle; item: SInt16; glyph: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0513, $A825;
	{$ENDC}
FUNCTION GetMenuItemKeyGlyph(menu: MenuHandle; item: SInt16; VAR glyph: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0514, $A825;
	{$ENDC}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AppearanceIncludes}

{$ENDC} {__APPEARANCE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
