/*
 	File:		Appearance.r
 
 	Contains:	Appearance Manager & SDK Interfaces.
 
 	Version:	Technology:	Appearance 1.0
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1994-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/

#ifndef __APPEARANCE_R__
#define __APPEARANCE_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

															/*  Appearance Trap Number  */
#define _AppearanceDispatch 			0xAA74
#define gestaltAppearanceAttr 			'appr'
#define gestaltAppearanceExists 		0
#define gestaltAppearanceCompatMode 	1

#define appearanceBadBrushIndexErr 		(-30560)			/*  pattern index invalid  */
#define appearanceProcessRegisteredErr 	(-30561)
#define appearanceProcessNotRegisteredErr  (-30562)
#define appearanceBadTextColorIndexErr 	(-30563)

#define kThemeActiveDialogBackgroundBrush  1				/*  Dialogs  */
#define kThemeInactiveDialogBackgroundBrush  2				/*  Dialogs  */
#define kThemeActiveAlertBackgroundBrush  3
#define kThemeInactiveAlertBackgroundBrush  4
#define kThemeActiveModelessDialogBackgroundBrush  5
#define kThemeInactiveModelessDialogBackgroundBrush  6
#define kThemeActiveUtilityWindowBackgroundBrush  7			/*  Miscellaneous  */
#define kThemeInactiveUtilityWindowBackgroundBrush  8		/*  Miscellaneous  */
#define kThemeListViewSortColumnBackgroundBrush  9			/*  Finder  */
#define kThemeListViewBackgroundBrush 	10
#define kThemeIconLabelBackgroundBrush 	11
#define kThemeListViewSeparatorBrush 	12
#define kThemeChasingArrowsBrush 		13
#define kThemeDragHiliteBrush 			14
#define kThemeDocumentWindowBackgroundBrush  15
#define kThemeFinderWindowBackgroundBrush  16

#define kThemeActiveDialogTextColor 	1					/*  Dialogs  */
#define kThemeInactiveDialogTextColor 	2
#define kThemeActiveAlertTextColor 		3
#define kThemeInactiveAlertTextColor 	4
#define kThemeActiveModelessDialogTextColor  5
#define kThemeInactiveModelessDialogTextColor  6
#define kThemeActiveWindowHeaderTextColor  7				/*  Primitives  */
#define kThemeInactiveWindowHeaderTextColor  8
#define kThemeActivePlacardTextColor 	9					/*  Primitives  */
#define kThemeInactivePlacardTextColor 	10
#define kThemePressedPlacardTextColor 	11
#define kThemeActivePushButtonTextColor  12					/*  Primitives  */
#define kThemeInactivePushButtonTextColor  13
#define kThemePressedPushButtonTextColor  14
#define kThemeActiveBevelButtonTextColor  15				/*  Primitives  */
#define kThemeInactiveBevelButtonTextColor  16
#define kThemePressedBevelButtonTextColor  17
#define kThemeActivePopupButtonTextColor  18				/*  Primitives  */
#define kThemeInactivePopupButtonTextColor  19
#define kThemePressedPopupButtonTextColor  20
#define kThemeIconLabelTextColor 		21					/*  Finder  */
#define kThemeListViewTextColor 		22

#define kThemeStateDisabled 			0
#define kThemeStateActive 				1
#define kThemeStatePressed 				2

															/*  Resource IDs for new window defprocs  */
#define kWindowDocumentDefProcResID 	64
#define kWindowDialogDefProcResID 		65
#define kWindowUtilityDefProcResID 		66
#define kWindowUtilitySideTitleDefProcResID  67

															/*  Proc IDs for theme-savvy windows  */
#define kWindowDocumentProc 			1024
#define kWindowGrowDocumentProc 		1025
#define kWindowHorizZoomDocumentProc 	1026
#define kWindowHorizZoomGrowDocumentProc  1027
#define kWindowVertZoomDocumentProc 	1028
#define kWindowVertZoomGrowDocumentProc  1029
#define kWindowFullZoomDocumentProc 	1030
#define kWindowFullZoomGrowDocumentProc  1031

															/*  Proc IDs for theme-savvy dialogs  */
#define kWindowPlainDialogProc 			1040
#define kWindowShadowDialogProc 		1041
#define kWindowModalDialogProc 			1042
#define kWindowMovableModalDialogProc 	1043
#define kWindowAlertProc 				1044
#define kWindowMovableAlertProc 		1045

															/*  Proc IDs for top title bar theme-savvy floating windows  */
#define kWindowFloatProc 				1057
#define kWindowFloatGrowProc 			1059
#define kWindowFloatHorizZoomProc 		1061
#define kWindowFloatHorizZoomGrowProc 	1063
#define kWindowFloatVertZoomProc 		1065
#define kWindowFloatVertZoomGrowProc 	1067
#define kWindowFloatFullZoomProc 		1069
#define kWindowFloatFullZoomGrowProc 	1071

															/*  Proc IDs for side title bar theme-savvy floating windows  */
#define kWindowFloatSideProc 			1073
#define kWindowFloatSideGrowProc 		1075
#define kWindowFloatSideHorizZoomProc 	1077
#define kWindowFloatSideHorizZoomGrowProc  1079
#define kWindowFloatSideVertZoomProc 	1081
#define kWindowFloatSideVertZoomGrowProc  1083
#define kWindowFloatSideFullZoomProc 	1085
#define kWindowFloatSideFullZoomGrowProc  1087

															/*  Region values to pass into GetWindowRegion  */
#define kWindowTitleBarRgn 				0
#define kWindowTitleTextRgn 			1
#define kWindowCloseBoxRgn 				2
#define kWindowZoomBoxRgn 				3
#define kWindowDragRgn 					5
#define kWindowGrowRgn 					6
#define kWindowCollapseBoxRgn 			7
#define kWindowStructureRgn 			32
#define kWindowContentRgn 				33

															/*  Window Features returned by GetWindowFeatures  */
#define kWindowCanGrow 					0x01
#define kWindowCanZoom 					0x02
#define kWindowCanCollapse 				0x04
#define kWindowIsModal 					0x08
#define kWindowCanGetWindowRegion 		0x10
#define kWindowIsAlert 					0x20
#define kWindowHasTitleBar 				0x40

															/*  New window messages  */
#define kWindowMsgGetFeatures 			7
#define kWindowMsgGetRegion 			8

															/*  New Window part codes  */
#define inCollapseBox 					11
															/*  Window Definition hit test result codes ("WindowPart") */
#define wInCollapseBox 					9
#define kWindowDefaultPosition 			0x0000
#define kWindowCenterMainScreen 		0x280A
#define kWindowAlertPositionMainScreen 	0x300A
#define kWindowStaggerMainScreen 		0x380A
#define kWindowCenterParentWindow 		0xA80A
#define kWindowAlertPositionParentWindow  0xB00A
#define kWindowStaggerParentWindow 		0xB80A
#define kWindowCenterParentWindowScreen  0x680A
#define kWindowAlertPositionParentWindowScreen  0x700A
#define kWindowStaggerParentWindowScreen  0x780A

															/*  Alert types to pass into StandardAlert  */
#define kAlertStopAlert 				0
#define kAlertNoteAlert 				1
#define kAlertCautionAlert 				2
#define kAlertPlainAlert 				3

#define kAlertDefaultOKText 			(-1)				/*  "OK" */
#define kAlertDefaultCancelText 		(-1)				/*  "Cancel" */
#define kAlertDefaultOtherText 			(-1)				/*  "Don't Save" */

#define kAlertStdAlertOKButton 			1
#define kAlertStdAlertCancelButton 		2
#define kAlertStdAlertOtherButton 		3
#define kAlertStdAlertHelpButton 		4

															/*  Dialog Flags for use in NewFeaturesDialog or dlgx resource  */
#define kDialogFlagsUseThemeBackground 	0x01
#define kDialogFlagsUseControlHierarchy  0x02
#define kDialogFlagsHandleMovableModal 	0x04
#define kDialogFlagsUseThemeControls 	0x08

															/*  Alert Flags for use in alrx resource  */
#define kAlertFlagsUseThemeBackground 	0x01
#define kAlertFlagsUseControlHierarchy 	0x02
#define kAlertFlagsAlertIsMovable 		0x04
#define kAlertFlagsUseThemeControls 	0x08

#define kDialogFontNoFontStyle 			0
#define kDialogFontUseFontMask 			0x0001
#define kDialogFontUseFaceMask 			0x0002
#define kDialogFontUseSizeMask 			0x0004
#define kDialogFontUseForeColorMask 	0x0008
#define kDialogFontUseBackColorMask 	0x0010
#define kDialogFontUseModeMask 			0x0020
#define kDialogFontUseJustMask 			0x0040
#define kDialogFontUseAllMask 			0x00FF
#define kDialogFontAddFontSizeMask 		0x0100
#define kDialogFontUseFontMaskMask 		0x0200

#define _ControlDispatch 				0xAA73
															/*  resource types for new controls  */
#define kControlTabListResType 			'tab#'				/*  used for tab control only */
#define kControlListDescResType 		'ldes'				/*  used for list box control only */

															/*  new part codes for new controls  */
#define kControlEditTextPart 			5
#define kControlPicturePart 			6
#define kControlIconPart 				7
#define kControlClockPart 				8
#define kControlListBoxPart 			24
#define kControlListBoxDoubleClickPart 	25

#define kControlSupportsNewMessages 	' ok '				/*  CDEF should return as result of kControlMsgTestNewMsgSupport */
#define kControlFocusNoPart 			0					/*  tells control to clear its focus */
#define kControlFocusNextPart 			(-1)				/*  tells control to focus on the next part */
#define kControlFocusPrevPart 			(-2)				/*  tells control to focus on the previous part */

#define kControlKeyFilterBlockKey 		0
#define kControlKeyFilterPassKey 		1

															/*  Meta-font numbering - see not above  */
#define kControlFontBigSystemFont 		(-1)				/*  force to big system font */
#define kControlFontSmallSystemFont 	(-2)				/*  force to small system font */
#define kControlFontSmallBoldSystemFont  (-3)				/*  force to small bold system font */

#define kControlUseFontMask 			0x0001
#define kControlUseFaceMask 			0x0002
#define kControlUseSizeMask 			0x0004
#define kControlUseForeColorMask 		0x0008
#define kControlUseBackColorMask 		0x0010
#define kControlUseModeMask 			0x0020
#define kControlUseJustMask 			0x0040
#define kControlUseAllMask 				0x00FF
#define kControlAddFontSizeMask 		0x0100

#define kControlFontStyleTag 			'font'
#define kControlKeyFilterTag 			'fltr'

#define errMessageNotSupported 			(-30580)
#define errDataNotSupported 			(-30581)
#define errControlDoesntSupportFocus 	(-30582)
#define errWindowDoesntSupportFocus 	(-30583)
#define errUnknownControl 				(-30584)
#define errCouldntSetFocus 				(-30585)
#define errNoRootControl 				(-30586)
#define errRootAlreadyExists 			(-30587)
#define errInvalidPartCode 				(-30588)
#define errControlsAlreadyExist 		(-30589)
#define errControlIsNotEmbedder 		(-30590)
#define errDataSizeMismatch 			(-30591)
#define errControlHiddenOrDisabled 		(-30592)
#define errWindowRegionCodeInvalid 		(-30593)
#define errCantEmbedIntoSelf 			(-30594)
#define errCantEmbedRoot 				(-30595)
#define errItemNotControl 				(-30596)

															/*  Control feature bits - returned by GetControlFeatures  */
#define kControlSupportsGhosting 		0x01
#define kControlSupportsEmbedding 		0x02
#define kControlSupportsFocus 			0x04
#define kControlWantsIdle 				0x08
#define kControlWantsActivate 			0x10
#define kControlHandlesTracking 		0x20
#define kControlSupportsDataAccess 		0x40
#define kControlHasSpecialBackground 	0x80
#define kControlGetsFocusOnClick 		0x0100
#define kControlSupportsCalcBestRect 	0x0200
#define kControlSupportsLiveFeedback 	0x0400

															/*  Control Messages  */
#define kControlMsgDrawGhost 			13
#define kControlMsgCalcBestRect 		14					/*  Calculate best fitting rectangle for control */
#define kControlMsgHandleTracking 		15
#define kControlMsgFocus 				16					/*  param indicates action. */
#define kControlMsgKeyDown 				17
#define kControlMsgIdle 				18
#define kControlMsgGetFeatures 			19
#define kControlMsgSetData 				20
#define kControlMsgGetData 				21
#define kControlMsgActivate 			22
#define kControlMsgSetUpBackground 		23
#define kControlMsgCalcValue 			24
#define kControlMsgSubControlHit 		25
#define kControlMsgCalcValueFromPos 	26
#define kControlMsgTestNewMsgSupport 	27					/*  See if this control supports new messaging */

															/*  Bevel Button Proc IDs  */
#define kControlBevelButtonSmallBevelProc  32
#define kControlBevelButtonNormalBevelProc  33
#define kControlBevelButtonLargeBevelProc  34

															/*  Bevel button graphic alignment values  */
#define kControlBevelButtonAlignSysDirection  (-1)			/*  only left or right */
#define kControlBevelButtonAlignCenter 	0
#define kControlBevelButtonAlignLeft 	1
#define kControlBevelButtonAlignRight 	2
#define kControlBevelButtonAlignTop 	3
#define kControlBevelButtonAlignBottom 	4
#define kControlBevelButtonAlignTopLeft  5
#define kControlBevelButtonAlignBottomLeft  6
#define kControlBevelButtonAlignTopRight  7
#define kControlBevelButtonAlignBottomRight  8

															/*  Bevel button text alignment values  */
#define kControlBevelButtonAlignTextSysDirection  0
#define kControlBevelButtonAlignTextCenter  1
#define kControlBevelButtonAlignTextFlushRight  (-1)
#define kControlBevelButtonAlignTextFlushLeft  (-2)

															/*  Bevel button text placement values  */
#define kControlBevelButtonPlaceSysDirection  (-1)			/*  if graphic on right, then on left */
#define kControlBevelButtonPlaceNormally  0
#define kControlBevelButtonPlaceToRightOfGraphic  1
#define kControlBevelButtonPlaceToLeftOfGraphic  2
#define kControlBevelButtonPlaceBelowGraphic  3
#define kControlBevelButtonPlaceAboveGraphic  4

#define kControlBevelButtonSmallBevelVariant  0
#define kControlBevelButtonNormalBevelVariant  0x01
#define kControlBevelButtonLargeBevelVariant  0x02
#define kControlBevelButtonMenuOnRight 	0x04

#define kControlBehaviorPushbutton 		0
#define kControlBehaviorToggles 		0x0100
#define kControlBehaviorSticky 			0x0200
#define kControlBehaviorMultiValueMenu 	0x4000				/*  only makes sense when a menu is attached. */
#define kControlBehaviorOffsetContents 	0x8000

#define kControlContentTextOnly 		0
#define kControlContentIconSuiteRes 	1
#define kControlContentCIconRes 		2
#define kControlContentPictRes 			3
#define kControlContentIconSuiteHandle 	129
#define kControlContentCIconHandle 		130
#define kControlContentPictHandle 		131
#define kControlContentIconRef 			132

#define kControlBevelButtonContentTag 	'cont'				/*  ButtonContentInfo */
#define kControlBevelButtonTransformTag  'tran'				/*  IconTransformType */
#define kControlBevelButtonTextAlignTag  'tali'				/*  ButtonTextAlignment */
#define kControlBevelButtonTextOffsetTag  'toff'			/*  SInt16 */
#define kControlBevelButtonGraphicAlignTag  'gali'			/*  ButtonGraphicAlignment */
#define kControlBevelButtonGraphicOffsetTag  'goff'			/*  Point */
#define kControlBevelButtonTextPlaceTag  'tplc'				/*  ButtonTextPlacement */
#define kControlBevelButtonMenuValueTag  'mval'				/*  SInt16 */
#define kControlBevelButtonMenuHandleTag  'mhnd'			/*  MenuHandle */

															/*  Slider proc IDs  */
#define kControlSliderProc 				48
#define kControlSliderLiveFeedback 		0x01
#define kControlSliderHasTickMarks 		0x02
#define kControlSliderReverseDirection 	0x04
#define kControlSliderNonDirectional 	0x08

															/*  Triangle proc IDs  */
#define kControlTriangleProc 			64
#define kControlTriangleLeftFacingProc 	65
#define kControlTriangleAutoToggleProc 	66
#define kControlTriangleLeftFacingAutoToggleProc  67

															/*  Tagged data supported by disclosure triangles  */
#define kControlTriangleLastValueTag 	'last'				/*  SInt16 */
															/*  Progress Bar proc IDs  */
#define kControlProgressBarProc 		80
															/*  Tagged data supported by progress bars  */
#define kControlProgressBarIndeterminateTag  'inde'			/*  Boolean */
															/*  Little Arrows proc IDs  */
#define kControlLittleArrowsProc 		96
															/*  Chasing Arrows proc IDs  */
#define kControlChasingArrowsProc 		112
															/*  Tabs proc IDs  */
#define kControlTabLargeProc 			128					/*  Large tab size	 */
#define kControlTabSmallProc 			129					/*  Small tab size	 */

															/*  Tagged data supported by progress bars  */
#define kControlTabContentRectTag 		'rect'				/*  Rect */
#define kControlTabEnabledFlagTag 		'enab'				/*  Boolean */
#define kControlTabFontStyleTag 		'font'				/*  ControlFontStyleRec */

															/*  Visual separator proc IDs  */
#define kControlSeparatorLineProc 		144
															/*  Group Box proc IDs  */
#define kControlGroupBoxTextTitleProc 	160
#define kControlGroupBoxCheckBoxProc 	161
#define kControlGroupBoxPopupButtonProc  162
#define kControlGroupBoxSecondaryTextTitleProc  164
#define kControlGroupBoxSecondaryCheckBoxProc  165
#define kControlGroupBoxSecondaryPopupButtonProc  166

															/*  Tagged data supported by group box  */
#define kControlGroupBoxMenuHandleTag 	'mhan'				/*  MenuHandle (popup title only) */
#define kControlGroupBoxFontStyleTag 	'font'				/*  ControlFontStyleRec */

															/*  Image Well proc IDs  */
#define kControlImageWellProc 			176
#define kControlImageWellAutoTrackProc 	177

															/*  Tagged data supported by image wells  */
#define kControlImageWellContentTag 	'cont'				/*  ButtonContentInfo */
#define kControlImageWellTransformTag 	'tran'				/*  IconTransformType */

															/*  Popup Arrow proc IDs  */
#define kControlPopupArrowEastProc 		192
#define kControlPopupArrowWestProc 		193
#define kControlPopupArrowNorthProc 	194
#define kControlPopupArrowSouthProc 	195
#define kControlPopupArrowSmallEastProc  196
#define kControlPopupArrowSmallWestProc  197
#define kControlPopupArrowSmallNorthProc  198
#define kControlPopupArrowSmallSouthProc  199

															/*  Placard proc IDs  */
#define kControlPlacardProc 			224
															/*  Clock proc IDs  */
#define kControlClockTimeProc 			240
#define kControlClockTimeSecondsProc 	241
#define kControlClockDateProc 			242
#define kControlClockMonthYearProc 		243

#define kControlClockNoFlags 			0
#define kControlClockIsDisplayOnly 		1
#define kControlClockIsLive 			2

															/*  Tagged data supported by clocks  */
#define kControlClockLongDateTag 		'date'				/*  LongDateRec */
#define kControlClockFontStyleTag 		'font'				/*  ControlFontStyleRec */

															/*  User Pane proc IDs  */
#define kControlUserPaneProc 			256
#define kControlUserItemDrawProcTag 	'uidp'				/*  UserItemUPP */
#define kControlUserPaneDrawProcTag 	'draw'				/*  ControlUserPaneDrawingUPP */
#define kControlUserPaneHitTestProcTag 	'hitt'				/*  ControlUserPaneHitTestUPP */
#define kControlUserPaneTrackingProcTag  'trak'				/*  ControlUserPaneTrackingUPP */
#define kControlUserPaneIdleProcTag 	'idle'				/*  ControlUserPaneIdleUPP */
#define kControlUserPaneKeyDownProcTag 	'keyd'				/*  ControlUserPaneKeyDownUPP */
#define kControlUserPaneActivateProcTag  'acti'				/*  ControlUserPaneActivateUPP */
#define kControlUserPaneFocusProcTag 	'foci'				/*  ControlUserPaneFocusUPP */
#define kControlUserPaneBackgroundProcTag  'back'			/*  ControlUserPaneBackgroundUPP */

															/*  Edit Text proc IDs  */
#define kControlEditTextProc 			272
#define kControlEditTextDialogProc 		273
#define kControlEditTextPasswordProc 	274

															/*  Tagged data supported by edit text  */
#define kControlEditTextStyleTag 		'font'				/*  ControlFontStyleRec */
#define kControlEditTextTextTag 		'text'				/*  Buffer of chars - you supply the buffer */
#define kControlEditTextTEHandleTag 	'than'				/*  The TEHandle of the text edit record */
#define kControlEditTextKeyFilterTag 	'fltr'
#define kControlEditTextSelectionTag 	'sele'				/*  EditTextSelectionRec */
#define kControlEditTextPasswordTag 	'pass'				/*  The clear text password text */

#define kControlStaticTextProc 			288
#define kControlStaticTextStyleTag 		'font'				/*  ControlFontStyleRec */
#define kControlStaticTextTextTag 		'text'				/*  Copy of text */
#define kControlStaticTextTextHeightTag  'thei'				/*  SInt16 */

															/*  Picture control proc IDs  */
#define kControlPictureProc 			304
#define kControlPictureNoTrackProc 		305					/*  immediately returns kControlPicturePart */

#define kControlIconProc 				320
#define kControlIconNoTrackProc 		321					/*  immediately returns kControlIconPart */
#define kControlIconSuiteProc 			322
#define kControlIconSuiteNoTrackProc 	323					/*  immediately returns kControlIconPart */

#define kControlIconTransformTag 		'trfm'				/*  IconTransformType */
#define kControlIconAlignmentTag 		'algn'				/*  IconAlignmentType */

															/*  Window Header proc IDs  */
#define kControlWindowHeaderProc 		336					/*  normal header */
#define kControlWindowListViewHeaderProc  337				/*  variant for list views - no bottom line */

															/*  List Box proc IDs  */
#define kControlListBoxProc 			352
#define kControlListBoxAutoSizeProc 	353

															/*  Tagged data supported by list box  */
#define kControlListBoxListHandleTag 	'lhan'				/*  ListHandle */
#define kControlListBoxKeyFilterTag 	'fltr'				/*  ControlKeyFilterUPP */
#define kControlListBoxFontStyleTag 	'font'				/*  ControlFontStyleRec */

															/*  Theme Push Button/Check Box/Radio Button proc IDs  */
#define kControlPushButtonProc 			368
#define kControlCheckBoxProc 			369
#define kControlRadioButtonProc 		370
#define kControlPushButLeftIconProc 	374					/*  Standard pushbutton with left-side icon */
#define kControlPushButRightIconProc 	375					/*  Standard pushbutton with right-side icon */

															/*  Tagged data supported by standard buttons  */
#define kControlPushButtonDefaultTag 	'dflt'				/*  default ring flag */
															/*  Theme Scroll Bar proc IDs  */
#define kControlScrollBarProc 			384					/*  normal scroll bar */
#define kControlScrollBarLiveProc 		386					/*  live scrolling variant */

															/*  Theme Popup Button proc IDs  */
#define kControlPopupButtonProc 		400
#define kControlPopupFixedWidthVariant 	0x01
#define kControlPopupVariableWidthVariant  0x02
#define kControlPopupUseAddResMenuVariant  0x04
#define kControlPopupUseWFontVariant 	0x08

#define kMenuStdMenuProc 				63
#define kMenuStdMenuBarProc 			63

#define kMenuNoModifiers 				0					/*  Mask for no modifiers */
#define kMenuShiftModifier 				0x01				/*  Mask for shift key modifier */
#define kMenuOptionModifier 			0x02				/*  Mask for option key modifier */
#define kMenuControlModifier 			0x04				/*  Mask for control key modifier */
#define kMenuNoCommandModifier 			0x08				/*  Mask for no command key modifier */

#define kMenuNoIcon 					0					/*  No icon */
#define kMenuIconType 					1					/*  Type for ICON */
#define kMenuShrinkIconType 			2					/*  Type for ICON plotted 16 x 16 */
#define kMenuSmallIconType 				3					/*  Type for SICN */
#define kMenuColorIconType 				4					/*  Type for cicn */
#define kMenuIconSuiteType 				5					/*  Type for Icon Suite */
#define kMenuIconRefType 				6					/*  Type for Icon Ref */

/*----------------------------alrx • Extended Alert Template---------------------------*/
type 'alrx'
{
	switch
	{
		case latestVersion:
			key integer=0;

			unsigned longint;				/* flags */
			longint;						/* refCon */
			byte		kUseClassicWindow,
						kUseThemeWindow;	/* Window type */
			fill byte;						/* filler */
			pstring;						/* title (movable only) */
	};
};

/*----------------------------dlgx • Extended Dialog Template---------------------------*/
type 'dlgx'
{
	switch
	{
		case latestVersion:
			key integer=0;

			unsigned longint;				/* flags */
	};
};

/*--------------------------ldes • List Box Description Template------------------------*/
/*	Used in conjunction with the list box control.									  */

type 'ldes'
{
	switch
	{
		case latestVersion:
			key integer = 0;	/* version */

			integer;												/* Rows					*/
			integer;												/* Columns				*/
			integer; 												/* Cell Height			*/
			integer;												/* Cell Width			*/
			byte			noVertScroll, hasVertScroll;			/* Vert Scroll			*/
			fill byte;												/* Filler Byte			*/
			byte			noHorizScroll, hasHorizScroll;			/* Horiz Scroll			*/
			fill byte;												/* Filler Byte			*/
			integer;												/* LDEF Res ID			*/
			byte			noGrowSpace, hasGrowSpace;				/* HasGrow?				*/
			fill byte;
	};
};

/*-------------------------------tab# • Tab Control Template-----------------------------*/
type 'tab#'
{
	switch
	{
		case latestVersion:
			key integer = 0;	/* version */

			integer = $$Countof(TabInfo);
			array TabInfo
			{
				integer;											/* Icon Suite ID		*/
				pstring;											/* Tab Name				*/
				fill long;											/* Reserved				*/
				fill word;											/* Reserved				*/
			};
	};
};

/*-----------------------------dftb • Dialog Control Font Table--------------------------*/
type 'dftb'
{
	switch
	{
		case latestVersion:
			key integer = 0;	/* version */

			integer = $$Countof(FontStyle);
			array FontStyle
			{
				switch
				{
					case skipItem:
						key integer=0;
						
					case dataItem:
						key integer=1;integer;								/* Flags		*/
						integer;											/* Font ID		*/
						integer;											/* Font Size	*/
						integer;											/* Font Style	*/
						integer;											/* Text Mode	*/
						integer;											/* Justification */

						unsigned integer;									/* ForeColor:	red		*/
						unsigned integer;									/*				green	*/
						unsigned integer;									/*				blue	*/

						unsigned integer;									/* BackColor:	red		*/
						unsigned integer;									/*				green	*/
						unsigned integer;									/*				blue	*/

						pstring;											/* Font Name */
				};
			};
	};
};

/*-------------------------------xmnu • Extended menu resource---------------------------*/
type 'xmnu'
{
	switch
	{
		case latestVersion:
			key integer = 0;	/* version */

			integer = $$Countof(ItemExtensions);
			array ItemExtensions
			{
				switch
				{
					case skipItem:
						key integer=0;
						
					case dataItem:
						key integer=1;
						unsigned longint;						/* Command ID */
						unsigned hex byte;						/* modifiers */
						fill byte;								/* icon type placeholder */
						fill long;								/* icon handle placeholder */
						unsigned longint sysScript=-1,			/* text encoding */
										 currScript=-2;			/* 	(use currScript for default)*/
						unsigned longint;						/* refCon */
						unsigned longint;						/* refCon2 */
						unsigned integer noHierID=0;			/* hierarchical menu ID */
						unsigned integer sysFont=0;				/* font ID */
						integer naturalGlyph=0;					/* keyboard glyph */
				};
			};
	};
};

#endif /* __APPEARANCE_R__ */

