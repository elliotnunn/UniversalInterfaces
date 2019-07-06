{
 	File:		ControlDefinitions.p
 
 	Contains:	Definitions of controls used by Control Mgr
 
 	Version:	Technology:	Sonata
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ControlDefinitions;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CONTROLDEFINITIONS__}
{$SETC __CONTROLDEFINITIONS__ := 1}

{$I+}
{$SETC ControlDefinitionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __APPEARANCE__}
{$I Appearance.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}
{$IFC UNDEFINED __LISTS__}
{$I Lists.p}
{$ENDC}
{$IFC UNDEFINED __MACHELP__}
{$I MacHelp.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}

{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• Resource Types																					}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}


CONST
	kControlTabListResType		= 'tab#';						{  used for tab control (Appearance 1.0 and later) }
	kControlListDescResType		= 'ldes';						{  used for list box control (Appearance 1.0 and later) }

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

{  Menu label styles for the System 7 pop-up menu }
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

{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• PopUp Menu Private Data Structure																	}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }

TYPE
	PopupPrivateDataPtr = ^PopupPrivateData;
	PopupPrivateData = RECORD
		mHandle:				MenuHandle;
		mID:					SInt16;
	END;

	PopupPrivateDataHandle				= ^PopupPrivateDataPtr;
{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• Control Definition ID’s																			}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{  Standard System 7 procIDs }


CONST
	pushButProc					= 0;
	checkBoxProc				= 1;
	radioButProc				= 2;
	scrollBarProc				= 16;
	popupMenuProc				= 1008;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• Control Part Codes																}
{——————————————————————————————————————————————————————————————————————————————————————}
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
	kControlRadioGroupPart		= 27;							{  Appearance 1.0.2 and later }
	kControlButtonPart			= 10;
	kControlCheckBoxPart		= 11;
	kControlRadioButtonPart		= 11;
	kControlUpButtonPart		= 20;
	kControlDownButtonPart		= 21;
	kControlPageUpPart			= 22;
	kControlPageDownPart		= 23;
	kControlClockHourDayPart	= 9;							{  Appearance 1.1 and later }
	kControlClockMinuteMonthPart = 10;							{  Appearance 1.1 and later }
	kControlClockSecondYearPart	= 11;							{  Appearance 1.1 and later }
	kControlClockAMPMPart		= 12;							{  Appearance 1.1 and later }
	kControlDataBrowserPart		= 24;							{  CarbonLib 1.0 and later }
	kControlDataBrowserDraggedPart = 25;						{  CarbonLib 1.0 and later }



{——————————————————————————————————————————————————————————————————————————————————————————————————————}
{	• Control Types and ID’s available only with Appearance 1.0 and later								}
{——————————————————————————————————————————————————————————————————————————————————————————————————————}
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
{ Bevel Button Proc IDs }
	kControlBevelButtonSmallBevelProc = 32;
	kControlBevelButtonNormalBevelProc = 33;
	kControlBevelButtonLargeBevelProc = 34;

{ Add these variant codes to kBevelButtonSmallBevelProc to change the type of button }
	kControlBevelButtonSmallBevelVariant = 0;
	kControlBevelButtonNormalBevelVariant = $01;
	kControlBevelButtonLargeBevelVariant = $02;
	kControlBevelButtonMenuOnRightVariant = $04;

{ Bevel Thicknesses }
	kControlBevelButtonSmallBevel = 0;
	kControlBevelButtonNormalBevel = 1;
	kControlBevelButtonLargeBevel = 2;


TYPE
	ControlBevelThickness				= UInt16;
{ Behaviors of bevel buttons. These are set up so you can add	}
{ them together with the content types.						}

CONST
	kControlBehaviorPushbutton	= 0;
	kControlBehaviorToggles		= $0100;
	kControlBehaviorSticky		= $0200;
	kControlBehaviorSingleValueMenu = 0;
	kControlBehaviorMultiValueMenu = $4000;						{  only makes sense when a menu is attached. }
	kControlBehaviorOffsetContents = $8000;

{ Behaviors for 1.0.1 or later }
	kControlBehaviorCommandMenu	= $2000;						{  menu holds commands, not choices. Overrides multi-value bit. }


TYPE
	ControlBevelButtonBehavior			= UInt16;
	ControlBevelButtonMenuBehavior		= UInt16;
{ Bevel Button Menu Placements }

CONST
	kControlBevelButtonMenuOnBottom = 0;
	kControlBevelButtonMenuOnRight = $04;


TYPE
	ControlBevelButtonMenuPlacement		= UInt16;
{ Graphic Alignments }

CONST
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
{ Text Alignments }

CONST
	kControlBevelButtonAlignTextSysDirection = 0;
	kControlBevelButtonAlignTextCenter = 1;
	kControlBevelButtonAlignTextFlushRight = -1;
	kControlBevelButtonAlignTextFlushLeft = -2;


TYPE
	ControlButtonTextAlignment			= SInt16;
{ Text Placements }

CONST
	kControlBevelButtonPlaceSysDirection = -1;					{  if graphic on right, then on left }
	kControlBevelButtonPlaceNormally = 0;
	kControlBevelButtonPlaceToRightOfGraphic = 1;
	kControlBevelButtonPlaceToLeftOfGraphic = 2;
	kControlBevelButtonPlaceBelowGraphic = 3;
	kControlBevelButtonPlaceAboveGraphic = 4;


TYPE
	ControlButtonTextPlacement			= SInt16;
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

{ tags available with Appearance 1.1 or later }
																{  Boolean: True = if an icon of the ideal size for }
																{  the button isn't available, scale a larger or }
																{  smaller icon to the ideal size. False = don't }
																{  scale; draw a smaller icon or clip a larger icon. }
																{  Default is false. Only applies to IconSuites and }
	kControlBevelButtonScaleIconTag = 'scal';					{  IconRefs. }

{ Helper routines are available only thru the shared library/glue. }
FUNCTION GetBevelButtonMenuValue(inButton: ControlHandle; VAR outValue: SInt16): OSErr;
FUNCTION SetBevelButtonMenuValue(inButton: ControlHandle; inValue: SInt16): OSErr;
FUNCTION GetBevelButtonMenuHandle(inButton: ControlHandle; VAR outHandle: MenuHandle): OSErr;
FUNCTION GetBevelButtonContentInfo(inButton: ControlHandle; outContent: ControlButtonContentInfoPtr): OSErr;
FUNCTION SetBevelButtonContentInfo(inButton: ControlHandle; inContent: ControlButtonContentInfoPtr): OSErr;
FUNCTION SetBevelButtonTransform(inButton: ControlHandle; transform: IconTransformType): OSErr;
FUNCTION SetBevelButtonGraphicAlignment(inButton: ControlHandle; inAlign: ControlButtonGraphicAlignment; inHOffset: SInt16; inVOffset: SInt16): OSErr;
FUNCTION SetBevelButtonTextAlignment(inButton: ControlHandle; inAlign: ControlButtonTextAlignment; inHOffset: SInt16): OSErr;
FUNCTION SetBevelButtonTextPlacement(inButton: ControlHandle; inWhere: ControlButtonTextPlacement): OSErr;

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
{ Slider proc ID and variants }

CONST
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
{ Triangle proc IDs }
	kControlTriangleProc		= 64;
	kControlTriangleLeftFacingProc = 65;
	kControlTriangleAutoToggleProc = 66;
	kControlTriangleLeftFacingAutoToggleProc = 67;

{ Tagged data supported by disclosure triangles }
	kControlTriangleLastValueTag = 'last';						{  SInt16 }

{ Helper routines are available only thru the shared library/glue. }
FUNCTION SetDisclosureTriangleLastValue(inTabControl: ControlHandle; inValue: SInt16): OSErr;
{——————————————————————————————————————————————————————————————————————————————————————}
{	• PROGRESS INDICATOR (CDEF 5)														}
{——————————————————————————————————————————————————————————————————————————————————————}
{	This CDEF implements both determinate and indeterminate progress bars. To switch, 	}
{	just use SetControlData to set the indeterminate flag to make it indeterminate call	}
{	IdleControls to step thru the animation. IdleControls should be called at least		}
{	once during your event loop.														}
{																						}
{ Progress Bar proc IDs }

CONST
	kControlProgressBarProc		= 80;

{ Tagged data supported by progress bars }
	kControlProgressBarIndeterminateTag = 'inde';				{  Boolean }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• LITTLE ARROWS (CDEF 6)															}
{——————————————————————————————————————————————————————————————————————————————————————}
{ 	This control implements the little up and down arrows you'd see in the Memory		}
{	control panel for adjusting the cache size. 										}
{ Little Arrows proc IDs }
	kControlLittleArrowsProc	= 96;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• CHASING ARROWS (CDEF 7)															}
{——————————————————————————————————————————————————————————————————————————————————————}
{	To animate this control, make sure to call IdleControls repeatedly.					}
{																						}
{ Chasing Arrows proc IDs }
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
{ Tabs proc IDs }
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

{ Tagged data supported by tabs }
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

{ Helper routines are available only thru the shared library/glue. }
FUNCTION GetTabContentRect(inTabControl: ControlHandle; VAR outContentRect: Rect): OSErr;
FUNCTION SetTabEnabled(inTabControl: ControlHandle; inTabToHilite: SInt16; inEnabled: BOOLEAN): OSErr;
{——————————————————————————————————————————————————————————————————————————————————————}
{	• VISUAL SEPARATOR (CDEF 9)															}
{——————————————————————————————————————————————————————————————————————————————————————}
{	Separator lines determine their orientation (horizontal or vertical) automatically	}
{	based on the relative height and width of their contrlRect.							}
{ Visual separator proc IDs }

CONST
	kControlSeparatorLineProc	= 144;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• GROUP BOX (CDEF 10)																}
{——————————————————————————————————————————————————————————————————————————————————————}
{	The group box CDEF can be use in several ways. It can have no title, a text title, 	}
{	a check box as the title, or a popup button as a title. There are two versions of 	}
{	group boxes, primary and secondary, which look slightly different.					}
{ Group Box proc IDs }
	kControlGroupBoxTextTitleProc = 160;
	kControlGroupBoxCheckBoxProc = 161;
	kControlGroupBoxPopupButtonProc = 162;
	kControlGroupBoxSecondaryTextTitleProc = 164;
	kControlGroupBoxSecondaryCheckBoxProc = 165;
	kControlGroupBoxSecondaryPopupButtonProc = 166;

{ Tagged data supported by group box }
	kControlGroupBoxMenuHandleTag = 'mhan';						{  MenuHandle (popup title only) }
	kControlGroupBoxFontStyleTag = 'font';						{  ControlFontStyleRec }

{ tags available with Appearance 1.1 or later }
	kControlGroupBoxTitleRectTag = 'trec';						{  Rect. Rectangle that the title text/control is drawn in. (get only) }

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
{ Image Well proc IDs }
	kControlImageWellProc		= 176;

{ Tagged data supported by image wells }
	kControlImageWellContentTag	= 'cont';						{  ButtonContentInfo }
	kControlImageWellTransformTag = 'tran';						{  IconTransformType }

{ Helper routines are available only thru the shared library/glue. }
FUNCTION GetImageWellContentInfo(inButton: ControlHandle; outContent: ControlButtonContentInfoPtr): OSErr;
FUNCTION SetImageWellContentInfo(inButton: ControlHandle; inContent: ControlButtonContentInfoPtr): OSErr;
FUNCTION SetImageWellTransform(inButton: ControlHandle; inTransform: IconTransformType): OSErr;
{——————————————————————————————————————————————————————————————————————————————————————}
{	• POPUP ARROW (CDEF 12)																}
{——————————————————————————————————————————————————————————————————————————————————————}
{	The popup arrow CDEF is used to draw the small arrow normally associated with a 	}
{	popup control. The arrow can point in four directions, and a small or large version }
{	can be used. This control is provided to allow clients to draw the arrow in a 		}
{	normalized fashion which will take advantage of themes automatically.				}
{																						}
{ Popup Arrow proc IDs }

CONST
	kControlPopupArrowEastProc	= 192;
	kControlPopupArrowWestProc	= 193;
	kControlPopupArrowNorthProc	= 194;
	kControlPopupArrowSouthProc	= 195;
	kControlPopupArrowSmallEastProc = 196;
	kControlPopupArrowSmallWestProc = 197;
	kControlPopupArrowSmallNorthProc = 198;
	kControlPopupArrowSmallSouthProc = 199;

{ Popup Arrow Orientations }
	kControlPopupArrowOrientationEast = 0;
	kControlPopupArrowOrientationWest = 1;
	kControlPopupArrowOrientationNorth = 2;
	kControlPopupArrowOrientationSouth = 3;


TYPE
	ControlPopupArrowOrientation		= UInt16;
{——————————————————————————————————————————————————————————————————————————————————————}
{	• PLACARD (CDEF 14)																	}
{——————————————————————————————————————————————————————————————————————————————————————}
{ Placard proc IDs }

CONST
	kControlPlacardProc			= 224;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• CLOCK (CDEF 15)																	}
{——————————————————————————————————————————————————————————————————————————————————————}
{ 	NOTE:	You can specify more options in the Value paramter when creating the clock.	}
{			See below.																	}
{																						}
{	NOTE:	Under Appearance 1.1, the clock control knows and returns more part codes.	}
{			The new clock-specific part codes are defined with the other control parts.	}
{			Besides these clock-specific parts, we also return kControlUpButtonPart		}
{			and kControlDownButtonPart when they hit the up and down arrows.			}
{			The new part codes give you more flexibility for focusing and hit testing.	}
{																						}
{			The original kControlClockPart is still valid. When hit testing, it means	}
{			that some non-editable area of the clock's whitespace has been clicked.		}
{			When focusing a currently unfocused clock, it changes the focus to the		}
{			first part; it is the same as passing kControlFocusNextPart. When			}
{			re-focusing a focused clock, it will not change the focus at all.			}
{ Clock proc IDs }
	kControlClockTimeProc		= 240;
	kControlClockTimeSecondsProc = 241;
	kControlClockDateProc		= 242;
	kControlClockMonthYearProc	= 243;

{ Clock Types }
	kControlClockTypeHourMinute	= 0;
	kControlClockTypeHourMinuteSecond = 1;
	kControlClockTypeMonthDay	= 2;
	kControlClockTypeMonthDayYear = 3;


TYPE
	ControlClockType					= UInt16;
{ Clock Flags }
{ 	These flags can be passed into 'value' field on creation of the control.			}
{ 	Value is set to 0 after control is created.											}

CONST
	kControlClockFlagStandard	= 0;							{  editable, non-live }
	kControlClockNoFlags		= 0;
	kControlClockFlagDisplayOnly = 1;							{  add this to become non-editable }
	kControlClockIsDisplayOnly	= 1;
	kControlClockFlagLive		= 2;							{  automatically shows current time on idle. only valid with display only. }
	kControlClockIsLive			= 2;


TYPE
	ControlClockFlags					= UInt32;
{ Tagged data supported by clocks }

CONST
	kControlClockLongDateTag	= 'date';						{  LongDateRec }
	kControlClockFontStyleTag	= 'font';						{  ControlFontStyleRec }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• USER PANE (CDEF 16)																}
{——————————————————————————————————————————————————————————————————————————————————————}
{ User Pane proc IDs }
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

FUNCTION NewControlUserPaneDrawUPP(userRoutine: ControlUserPaneDrawProcPtr): ControlUserPaneDrawUPP; { old name was NewControlUserPaneDrawProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewControlUserPaneHitTestUPP(userRoutine: ControlUserPaneHitTestProcPtr): ControlUserPaneHitTestUPP; { old name was NewControlUserPaneHitTestProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewControlUserPaneTrackingUPP(userRoutine: ControlUserPaneTrackingProcPtr): ControlUserPaneTrackingUPP; { old name was NewControlUserPaneTrackingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewControlUserPaneIdleUPP(userRoutine: ControlUserPaneIdleProcPtr): ControlUserPaneIdleUPP; { old name was NewControlUserPaneIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewControlUserPaneKeyDownUPP(userRoutine: ControlUserPaneKeyDownProcPtr): ControlUserPaneKeyDownUPP; { old name was NewControlUserPaneKeyDownProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewControlUserPaneActivateUPP(userRoutine: ControlUserPaneActivateProcPtr): ControlUserPaneActivateUPP; { old name was NewControlUserPaneActivateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewControlUserPaneFocusUPP(userRoutine: ControlUserPaneFocusProcPtr): ControlUserPaneFocusUPP; { old name was NewControlUserPaneFocusProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewControlUserPaneBackgroundUPP(userRoutine: ControlUserPaneBackgroundProcPtr): ControlUserPaneBackgroundUPP; { old name was NewControlUserPaneBackgroundProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeControlUserPaneDrawUPP(userUPP: ControlUserPaneDrawUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeControlUserPaneHitTestUPP(userUPP: ControlUserPaneHitTestUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeControlUserPaneTrackingUPP(userUPP: ControlUserPaneTrackingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeControlUserPaneIdleUPP(userUPP: ControlUserPaneIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeControlUserPaneKeyDownUPP(userUPP: ControlUserPaneKeyDownUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeControlUserPaneActivateUPP(userUPP: ControlUserPaneActivateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeControlUserPaneFocusUPP(userUPP: ControlUserPaneFocusUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeControlUserPaneBackgroundUPP(userUPP: ControlUserPaneBackgroundUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeControlUserPaneDrawUPP(control: ControlHandle; part: SInt16; userRoutine: ControlUserPaneDrawUPP); { old name was CallControlUserPaneDrawProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeControlUserPaneHitTestUPP(control: ControlHandle; where: Point; userRoutine: ControlUserPaneHitTestUPP): ControlPartCode; { old name was CallControlUserPaneHitTestProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeControlUserPaneTrackingUPP(control: ControlHandle; startPt: Point; actionProc: ControlActionUPP; userRoutine: ControlUserPaneTrackingUPP): ControlPartCode; { old name was CallControlUserPaneTrackingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeControlUserPaneIdleUPP(control: ControlHandle; userRoutine: ControlUserPaneIdleUPP); { old name was CallControlUserPaneIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeControlUserPaneKeyDownUPP(control: ControlHandle; keyCode: SInt16; charCode: SInt16; modifiers: SInt16; userRoutine: ControlUserPaneKeyDownUPP): ControlPartCode; { old name was CallControlUserPaneKeyDownProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeControlUserPaneActivateUPP(control: ControlHandle; activating: BOOLEAN; userRoutine: ControlUserPaneActivateUPP); { old name was CallControlUserPaneActivateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeControlUserPaneFocusUPP(control: ControlHandle; action: ControlFocusPart; userRoutine: ControlUserPaneFocusUPP): ControlPartCode; { old name was CallControlUserPaneFocusProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeControlUserPaneBackgroundUPP(control: ControlHandle; info: ControlBackgroundPtr; userRoutine: ControlUserPaneBackgroundUPP); { old name was CallControlUserPaneBackgroundProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{
  ——————————————————————————————————————————————————————————————————————————————————————————
  	• EDIT TEXT (CDEF 17)
  ——————————————————————————————————————————————————————————————————————————————————————————
}
{ Edit Text proc IDs }

CONST
	kControlEditTextProc		= 272;
	kControlEditTextPasswordProc = 274;

{ proc IDs available with Appearance 1.1 or later }
	kControlEditTextInlineInputProc = 276;						{  Can't combine with the other variants }

{ Tagged data supported by edit text }
	kControlEditTextStyleTag	= 'font';						{  ControlFontStyleRec }
	kControlEditTextTextTag		= 'text';						{  Buffer of chars - you supply the buffer }
	kControlEditTextTEHandleTag	= 'than';						{  The TEHandle of the text edit record }
	kControlEditTextKeyFilterTag = 'fltr';
	kControlEditTextSelectionTag = 'sele';						{  EditTextSelectionRec }
	kControlEditTextPasswordTag	= 'pass';						{  The clear text password text }

{ tags available with Appearance 1.1 or later }
	kControlEditTextKeyScriptBehaviorTag = 'kscr';				{  ControlKeyScriptBehavior. Defaults to "PrefersRoman" for password fields, }
																{ 		or "AllowAnyScript" for non-password fields. }
	kControlEditTextLockedTag	= 'lock';						{  Boolean. Locking disables editability. }
	kControlEditTextFixedTextTag = 'ftxt';						{  Like the normal text tag, but fixes inline input first }
	kControlEditTextValidationProcTag = 'vali';					{  ControlEditTextValidationUPP. Called when a key filter can't be: after cut, paste, etc. }
	kControlEditTextInlinePreUpdateProcTag = 'prup';			{  TSMTEPreUpdateUPP and TSMTEPostUpdateUpp. For use with inline input variant... }
	kControlEditTextInlinePostUpdateProcTag = 'poup';			{  ...The refCon parameter will contain the ControlHandle. }

{ Structure for getting the edit text selection }

TYPE
	ControlEditTextSelectionRecPtr = ^ControlEditTextSelectionRec;
	ControlEditTextSelectionRec = RECORD
		selStart:				SInt16;
		selEnd:					SInt16;
	END;

	ControlEditTextSelectionPtr			= ^ControlEditTextSelectionRec;
{$IFC TYPED_FUNCTION_POINTERS}
	ControlEditTextValidationProcPtr = PROCEDURE(control: ControlHandle);
{$ELSEC}
	ControlEditTextValidationProcPtr = ProcPtr;
{$ENDC}

	ControlEditTextValidationUPP = UniversalProcPtr;

CONST
	uppControlEditTextValidationProcInfo = $000000C0;

FUNCTION NewControlEditTextValidationUPP(userRoutine: ControlEditTextValidationProcPtr): ControlEditTextValidationUPP; { old name was NewControlEditTextValidationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeControlEditTextValidationUPP(userUPP: ControlEditTextValidationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeControlEditTextValidationUPP(control: ControlHandle; userRoutine: ControlEditTextValidationUPP); { old name was CallControlEditTextValidationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
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

{ Tags available with appearance 1.1 or later }
	kControlStaticTextTruncTag	= 'trun';						{  TruncCode (-1 means no truncation) }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• PICTURE CONTROL (CDEF 19)															}
{——————————————————————————————————————————————————————————————————————————————————————}
{	Value parameter should contain the ID of the picture you wish to display when		}
{	creating controls of this type. If you don't want the control tracked at all, use 	}
{	the 'no track' variant.																}
{ Picture control proc IDs }
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

																{  icon ref controls may have either an icon, color icon, icon suite, or icon ref. }
																{  for data other than icon, you must set the data by passing a }
																{  ControlButtonContentInfo to SetControlData }
	kControlIconRefProc			= 324;
	kControlIconRefNoTrackProc	= 325;							{  immediately returns kControlIconPart }

{ Tagged data supported by icon controls }
	kControlIconTransformTag	= 'trfm';						{  IconTransformType }
	kControlIconAlignmentTag	= 'algn';						{  IconAlignmentType }

{ Tags available with appearance 1.1 or later }
	kControlIconResourceIDTag	= 'ires';						{  SInt16 resource ID of icon to use }
	kControlIconContentTag		= 'cont';						{  accepts a ControlButtonContentInfo }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• WINDOW HEADER (CDEF 21)															}
{——————————————————————————————————————————————————————————————————————————————————————}
{ Window Header proc IDs }
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
{ List Box proc IDs }
	kControlListBoxProc			= 352;
	kControlListBoxAutoSizeProc	= 353;

{ Tagged data supported by list box }
	kControlListBoxListHandleTag = 'lhan';						{  ListHandle }
	kControlListBoxKeyFilterTag	= 'fltr';						{  ControlKeyFilterUPP }
	kControlListBoxFontStyleTag	= 'font';						{  ControlFontStyleRec }

{ New tags in 1.0.1 or later }
	kControlListBoxDoubleClickTag = 'dblc';						{  Boolean. Was last click a double-click? }
	kControlListBoxLDEFTag		= 'ldef';						{  SInt16. ID of LDEF to use. }

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
{	A push button may also be marked using the kControlPushButtonCancelTag. This has	}
{	no visible representation, but does cause the button to play the CancelButton theme	}
{	sound instead of the regular pushbutton theme sound when pressed.					}
{																						}
{ Theme Push Button/Check Box/Radio Button proc IDs }
	kControlPushButtonProc		= 368;
	kControlCheckBoxProc		= 369;
	kControlRadioButtonProc		= 370;
	kControlPushButLeftIconProc	= 374;							{  Standard pushbutton with left-side icon }
	kControlPushButRightIconProc = 375;							{  Standard pushbutton with right-side icon }

{ Variants with Appearance 1.1 or later }
	kControlCheckBoxAutoToggleProc = 371;
	kControlRadioButtonAutoToggleProc = 372;

{ Tagged data supported by standard buttons }
	kControlPushButtonDefaultTag = 'dflt';						{  default ring flag }
	kControlPushButtonCancelTag	= 'cncl';						{  cancel button flag (1.1 and later) }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• SCROLL BAR (CDEF 24)																}
{——————————————————————————————————————————————————————————————————————————————————————}
{	This is the new Appearance scroll bar.												}
{																						}
{ Theme Scroll Bar proc IDs }
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
{ Theme Popup Button proc IDs }
	kControlPopupButtonProc		= 400;
	kControlPopupFixedWidthVariant = $01;
	kControlPopupVariableWidthVariant = $02;
	kControlPopupUseAddResMenuVariant = $04;
	kControlPopupUseWFontVariant = $08;

{ These tags are available in 1.0.1 or later of Appearance }
	kControlPopupButtonMenuHandleTag = 'mhan';					{  MenuHandle }
	kControlPopupButtonMenuIDTag = 'mnid';						{  SInt16 }

{ These tags are available in 1.1 or later of Appearance }
	kControlPopupButtonExtraHeightTag = 'exht';					{  SInt16 extra vertical whitespace within the button }


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
{ Radio Group Proc ID }
	kControlRadioGroupProc		= 416;

{——————————————————————————————————————————————————————————————————————————————————————}
{	• SCROLL TEXT BOX (CDEF 27)															}
{——————————————————————————————————————————————————————————————————————————————————————}
{	This control implements a scrolling box of (non-editable) text.	This is useful for	}
{	credits in about boxes, etc.														}
{	The standard version of this control has a scroll bar, but the autoscrolling		}
{	variant does not. The autoscrolling variant needs two pieces of information to		}
{	work: delay (in ticks) before the scrolling starts, and time (in ticks) between		}
{	scrolls. It will scroll one pixel at a time, unless changed via SetControlData.		}
{																						}
{	Parameter					What Goes Here											}
{	———————————————————			————————————————————————————————————————————————————	}
{	Value						Resource ID of 'TEXT'/'styl' content.					}
{	Min							Scroll start delay (in ticks)						.	}
{	Max							Delay (in ticks) between scrolls.						}
{																						}
{	NOTE: This control is only available with Appearance 1.1.							}
{ Scroll Text Box Proc IDs }
	kControlScrollTextBoxProc	= 432;
	kControlScrollTextBoxAutoScrollProc = 433;

{ Tagged data supported by Scroll Text Box }
	kControlScrollTextBoxDelayBeforeAutoScrollTag = 'stdl';		{  UInt32 (ticks until autoscrolling starts) }
	kControlScrollTextBoxDelayBetweenAutoScrollTag = 'scdl';	{  UInt32 (ticks between scrolls) }
	kControlScrollTextBoxAutoScrollAmountTag = 'samt';			{  UInt16 (pixels per scroll) -- defaults to 1 }
	kControlScrollTextBoxContentsTag = 'tres';					{  SInt16 (resource ID of 'TEXT'/'styl') -- write only! }

{——————————————————————————————————————————————————————————————————————————————————————}
{	• Debugging																			}
{——————————————————————————————————————————————————————————————————————————————————————}
{$IFC TARGET_CARBON }
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE GDBShowControlHierarchy(inWindow: WindowRef);
PROCEDURE GDBShowControlInfo(inControl: ControlRef);
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_CARBON}

{$IFC OLDROUTINENAMES }
{——————————————————————————————————————————————————————————————————————————————————————}
{	• OLDROUTINENAMES																	}
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	inLabel						= 1;
	inMenu						= 2;
	inTriangle					= 4;
	inButton					= 10;
	inCheckBox					= 11;
	inUpButton					= 20;
	inDownButton				= 21;
	inPageUp					= 22;
	inPageDown					= 23;

	kInLabelControlPart			= 1;
	kInMenuControlPart			= 2;
	kInTriangleControlPart		= 4;
	kInButtonControlPart		= 10;
	kInCheckBoxControlPart		= 11;
	kInUpButtonControlPart		= 20;
	kInDownButtonControlPart	= 21;
	kInPageUpControlPart		= 22;
	kInPageDownControlPart		= 23;


{$ENDC}  {OLDROUTINENAMES}




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ControlDefinitionsIncludes}

{$ENDC} {__CONTROLDEFINITIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
