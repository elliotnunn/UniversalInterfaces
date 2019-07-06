{
 	File:		Appearance.p
 
 	Contains:	Appearance Manager Interfaces.
 
 	Version:	Technology:	Allegro
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1994-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}
{$IFC UNDEFINED __QDOFFSCREEN__}
{$I QDOffscreen.p}
{$ENDC}
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
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

{ Gestalt selector for determining Appearance Manager version 	 }
{ If this selector does not exist, but gestaltAppearanceAttr	 }
{ does, it indicates that the 1.0 version is installed. This	 }
{ gestalt returns a BCD number representing the version of the	 }
{ Appearance Manager that is currently running, e.g. 0x0101 for }
{ version 1.0.1.												 }
	gestaltAppearanceVersion	= 'apvr';

{ Appearance Manager Apple Events (1.1 and later) 				}
	kAppearanceEventClass		= 'appr';						{  Event Class  }
	kAEAppearanceChanged		= 'thme';						{  Appearance changed (e.g. platinum to hi-tech)  }
	kAESystemFontChanged		= 'sysf';						{  system font changed  }
	kAESmallSystemFontChanged	= 'ssfn';						{  small system font changed  }
	kAEViewsFontChanged			= 'vfnt';						{  views font changed  }

{——————————————————————————————————————————————————————————————————————————————————}
{ Appearance Manager file types													}
{——————————————————————————————————————————————————————————————————————————————————}
	kThemeDataFileType			= 'thme';						{  file type for theme files  }
	kThemePlatinumFileType		= 'pltn';						{  file type for platinum appearance  }
	kThemeCustomThemesFileType	= 'scen';						{  file type for user themes  }
	kThemeSoundTrackFileType	= 'tsnd';

{ Appearance Manager Error Codes }
	themeInvalidBrushErr		= -30560;						{  pattern index invalid  }
	themeProcessRegisteredErr	= -30561;
	themeProcessNotRegisteredErr = -30562;
	themeBadTextColorErr		= -30563;
	themeHasNoAccentsErr		= -30564;
	themeBadCursorIndexErr		= -30565;
	themeScriptFontNotFoundErr	= -30566;						{  theme font requested for uninstalled script system  }
	themeMonitorDepthNotSupportedErr = -30567;					{  theme not supported at monitor depth  }

	kThemeBrushDialogBackgroundActive = 1;						{  Dialogs  }
	kThemeBrushDialogBackgroundInactive = 2;					{  Dialogs  }
	kThemeBrushAlertBackgroundActive = 3;
	kThemeBrushAlertBackgroundInactive = 4;
	kThemeBrushModelessDialogBackgroundActive = 5;
	kThemeBrushModelessDialogBackgroundInactive = 6;
	kThemeBrushUtilityWindowBackgroundActive = 7;				{  Miscellaneous  }
	kThemeBrushUtilityWindowBackgroundInactive = 8;				{  Miscellaneous  }
	kThemeBrushListViewSortColumnBackground = 9;				{  Finder  }
	kThemeBrushListViewBackground = 10;
	kThemeBrushIconLabelBackground = 11;
	kThemeBrushListViewSeparator = 12;
	kThemeBrushChasingArrows	= 13;
	kThemeBrushDragHilite		= 14;
	kThemeBrushDocumentWindowBackground = 15;
	kThemeBrushFinderWindowBackground = 16;

{ Brushes available in Appearance 1.1 or later }
	kThemeBrushScrollBarDelimiterActive = 17;
	kThemeBrushScrollBarDelimiterInactive = 18;
	kThemeBrushFocusHighlight	= 19;
	kThemeBrushPopupArrowActive	= 20;
	kThemeBrushPopupArrowPressed = 21;
	kThemeBrushPopupArrowInactive = 22;
	kThemeBrushAppleGuideCoachmark = 23;
	kThemeBrushIconLabelBackgroundSelected = 24;
	kThemeBrushStaticAreaFill	= 25;
	kThemeBrushActiveAreaFill	= 26;
	kThemeBrushButtonFrameActive = 27;
	kThemeBrushButtonFrameInactive = 28;
	kThemeBrushButtonFaceActive	= 29;
	kThemeBrushButtonFaceInactive = 30;
	kThemeBrushButtonFacePressed = 31;
	kThemeBrushButtonActiveDarkShadow = 32;
	kThemeBrushButtonActiveDarkHighlight = 33;
	kThemeBrushButtonActiveLightShadow = 34;
	kThemeBrushButtonActiveLightHighlight = 35;
	kThemeBrushButtonInactiveDarkShadow = 36;
	kThemeBrushButtonInactiveDarkHighlight = 37;
	kThemeBrushButtonInactiveLightShadow = 38;
	kThemeBrushButtonInactiveLightHighlight = 39;
	kThemeBrushButtonPressedDarkShadow = 40;
	kThemeBrushButtonPressedDarkHighlight = 41;
	kThemeBrushButtonPressedLightShadow = 42;
	kThemeBrushButtonPressedLightHighlight = 43;
	kThemeBrushBevelActiveLight	= 44;
	kThemeBrushBevelActiveDark	= 45;
	kThemeBrushBevelInactiveLight = 46;
	kThemeBrushBevelInactiveDark = 47;

{ These values are meta-brushes, specific colors that do not 		}
{ change from theme to theme. You can use them instead of using	}
{ direct RGB values. 												}
	kThemeBrushBlack			= -1;
	kThemeBrushWhite			= -2;


TYPE
	ThemeBrush							= SInt16;

CONST
	kThemeTextColorDialogActive	= 1;
	kThemeTextColorDialogInactive = 2;
	kThemeTextColorAlertActive	= 3;
	kThemeTextColorAlertInactive = 4;
	kThemeTextColorModelessDialogActive = 5;
	kThemeTextColorModelessDialogInactive = 6;
	kThemeTextColorWindowHeaderActive = 7;
	kThemeTextColorWindowHeaderInactive = 8;
	kThemeTextColorPlacardActive = 9;
	kThemeTextColorPlacardInactive = 10;
	kThemeTextColorPlacardPressed = 11;
	kThemeTextColorPushButtonActive = 12;
	kThemeTextColorPushButtonInactive = 13;
	kThemeTextColorPushButtonPressed = 14;
	kThemeTextColorBevelButtonActive = 15;
	kThemeTextColorBevelButtonInactive = 16;
	kThemeTextColorBevelButtonPressed = 17;
	kThemeTextColorPopupButtonActive = 18;
	kThemeTextColorPopupButtonInactive = 19;
	kThemeTextColorPopupButtonPressed = 20;
	kThemeTextColorIconLabel	= 21;
	kThemeTextColorListView		= 22;

{ Text Colors available in Appearance 1.0.1 or later }
	kThemeTextColorDocumentWindowTitleActive = 23;
	kThemeTextColorDocumentWindowTitleInactive = 24;
	kThemeTextColorMovableModalWindowTitleActive = 25;
	kThemeTextColorMovableModalWindowTitleInactive = 26;
	kThemeTextColorUtilityWindowTitleActive = 27;
	kThemeTextColorUtilityWindowTitleInactive = 28;
	kThemeTextColorPopupWindowTitleActive = 29;
	kThemeTextColorPopupWindowTitleInactive = 30;
	kThemeTextColorRootMenuActive = 31;
	kThemeTextColorRootMenuSelected = 32;
	kThemeTextColorRootMenuDisabled = 33;
	kThemeTextColorMenuItemActive = 34;
	kThemeTextColorMenuItemSelected = 35;
	kThemeTextColorMenuItemDisabled = 36;
	kThemeTextColorPopupLabelActive = 37;
	kThemeTextColorPopupLabelInactive = 38;


{ Text colors available in Appearance 1.1 or later }
	kThemeTextColorTabFrontActive = 39;
	kThemeTextColorTabNonFrontActive = 40;
	kThemeTextColorTabNonFrontPressed = 41;
	kThemeTextColorTabFrontInactive = 42;
	kThemeTextColorTabNonFrontInactive = 43;
	kThemeTextColorIconLabelSelected = 44;
	kThemeTextColorBevelButtonStickyActive = 45;
	kThemeTextColorBevelButtonStickyInactive = 46;

{ These values are specific colors that do not change from 			}
{ theme to theme. You can use them instead of using direct RGB values. }
	kThemeTextColorBlack		= -1;
	kThemeTextColorWhite		= -2;


TYPE
	ThemeTextColor						= SInt16;
{ States to draw primitives: disabled, active, and pressed (hilited) }

CONST
	kThemeStateInactive			= 0;
	kThemeStateActive			= 1;
	kThemeStatePressed			= 2;

{ obsolete name }
	kThemeStateDisabled			= 0;

	kThemeStatePressedUp		= 2;							{  draw with up pressed		(increment/decrement buttons)  }
	kThemeStatePressedDown		= 3;							{  draw with down pressed	(increment/decrement buttons)  }


TYPE
	ThemeDrawState						= UInt32;
{——————————————————————————————————————————————————————————————————————————————————}
{ Theme cursor selectors available in Appearance 1.1 or later						}
{——————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeArrowCursor			= 0;
	kThemeCopyArrowCursor		= 1;
	kThemeAliasArrowCursor		= 2;
	kThemeContextualMenuArrowCursor = 3;
	kThemeIBeamCursor			= 4;
	kThemeCrossCursor			= 5;
	kThemePlusCursor			= 6;
	kThemeWatchCursor			= 7;							{  Can Animate  }
	kThemeClosedHandCursor		= 8;
	kThemeOpenHandCursor		= 9;
	kThemePointingHandCursor	= 10;
	kThemeCountingUpHandCursor	= 11;							{  Can Animate  }
	kThemeCountingDownHandCursor = 12;							{  Can Animate  }
	kThemeCountingUpAndDownHandCursor = 13;						{  Can Animate  }
	kThemeSpinningCursor		= 14;							{  Can Animate  }
	kThemeResizeLeftCursor		= 15;
	kThemeResizeRightCursor		= 16;
	kThemeResizeLeftRightCursor	= 17;


TYPE
	ThemeCursor							= UInt32;
{——————————————————————————————————————————————————————————————————————————————————}
{ Theme menu bar drawing states													}
{——————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeMenuBarNormal			= 0;
	kThemeMenuBarSelected		= 1;


TYPE
	ThemeMenuBarState					= UInt16;
{ attributes }

CONST
	kThemeMenuSquareMenuBar		= $01;

{——————————————————————————————————————————————————————————————————————————————————}
{ Theme menu drawing states													    }
{——————————————————————————————————————————————————————————————————————————————————}
	kThemeMenuActive			= 0;
	kThemeMenuSelected			= 1;
	kThemeMenuInactive			= 3;

{ obsolete name }
	kThemeMenuDisabled			= 3;


TYPE
	ThemeMenuState						= UInt16;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ MenuType: add kThemeMenuTypeInactive to menu type for DrawThemeMenuBackground if entire 	}
{ menu is inactive																			}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeMenuTypePullDown		= 0;
	kThemeMenuTypePopUp			= 1;
	kThemeMenuTypeHierarchical	= 2;
	kThemeMenuTypeInactive		= $0100;


TYPE
	ThemeMenuType						= UInt16;

CONST
	kThemeMenuItemPlain			= 0;
	kThemeMenuItemHierarchical	= 1;							{  item has hierarchical arrow }
	kThemeMenuItemScrollUpArrow	= 2;							{  for scrollable menus, indicates item is scroller }
	kThemeMenuItemScrollDownArrow = 3;
	kThemeMenuItemAtTop			= $0100;						{  indicates item is being drawn at top of menu }
	kThemeMenuItemAtBottom		= $0200;						{  indicates item is being drawn at bottom of menu }
	kThemeMenuItemHierBackground = $0400;						{  item is within a hierarchical menu }
	kThemeMenuItemPopUpBackground = $0800;						{  item is within a popped up menu }
	kThemeMenuItemHasIcon		= $8000;						{  add into non-arrow type when icon present. }


TYPE
	ThemeMenuItemType					= UInt16;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Theme Backgrounds																		}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeBackgroundTabPane		= 1;
	kThemeBackgroundPlacard		= 2;
	kThemeBackgroundWindowHeader = 3;
	kThemeBackgroundListViewWindowHeader = 4;


TYPE
	ThemeBackgroundKind					= UInt32;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Theme Collection tags for Get/SetTheme													}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeNameTag				= 'name';						{  Str255 }
	kThemeAppearanceFileNameTag	= 'thme';						{  Str255 }
	kThemeVariantNameTag		= 'varn';						{  Str255 }
	kThemeSystemFontTag			= 'lgsf';						{  Str255 }
	kThemeSmallSystemFontTag	= 'smsf';						{  Str255 }
	kThemeViewsFontTag			= 'vfnt';						{  Str255 }
	kThemeViewsFontSizeTag		= 'vfsz';						{  SInt16 }
	kThemeDesktopPatternNameTag	= 'patn';						{  Str255 }
	kThemeDesktopPatternTag		= 'patt';						{  <variable-length data> (flattened pattern) }
	kThemeDesktopPictureNameTag	= 'dpnm';						{  Str255 }
	kThemeDesktopPictureAliasTag = 'dpal';						{  <alias handle> }
	kThemeDesktopPictureAlignmentTag = 'dpan';					{  UInt32 }
	kThemeHighlightColorNameTag	= 'hcnm';						{  Str255 }
	kThemeHighlightColorTag		= 'hcol';						{  RGBColor }
	kThemeExamplePictureIDTag	= 'epic';						{  SInt16 }
	kThemeSoundsEnabledTag		= 'snds';						{  Boolean }
	kThemeSoundTrackNameTag		= 'sndt';						{  Str255 }
	kThemeSoundMaskTag			= 'smsk';						{  UInt32 }
	kThemeUserDefinedTag		= 'user';						{  Boolean (this should _always_ be true if present - used by Control Panel). }
	kThemeScrollBarArrowStyleTag = 'sbar';						{  ThemeScrollBarArrowStyle }
	kThemeScrollBarThumbStyleTag = 'sbth';						{  ThemeScrollBarThumbStyle }
	kThemeSmoothFontEnabledTag	= 'smoo';						{  Boolean }
	kThemeSmoothFontMinSizeTag	= 'smos';						{  UInt16 (must be >= 12 and <= 24) }
	kThemeDblClickCollapseTag	= 'coll';						{  Boolean }

{——————————————————————————————————————————————————————————————————————————————————————————}
{ Theme Control Settings																	}
{——————————————————————————————————————————————————————————————————————————————————————————}
	kThemeCheckBoxClassicX		= 0;							{  check box with an 'X' }
	kThemeCheckBoxCheckMark		= 1;							{  check box with a real check mark }


TYPE
	ThemeCheckBoxStyle					= UInt16;

CONST
	kThemeScrollBarArrowsSingle	= 0;							{  single arrow on each end }
	kThemeScrollBarArrowsLowerRight = 1;						{  double arrows only on right or bottom }


TYPE
	ThemeScrollBarArrowStyle			= UInt16;

CONST
	kThemeScrollBarThumbNormal	= 0;							{  normal, classic thumb size }
	kThemeScrollBarThumbProportional = 1;						{  proportional thumbs }


TYPE
	ThemeScrollBarThumbStyle			= UInt16;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Font constants																			}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeSystemFont			= 0;
	kThemeSmallSystemFont		= 1;
	kThemeSmallEmphasizedSystemFont = 2;
	kThemeViewsFont				= 3;


TYPE
	ThemeFontID							= UInt16;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Tab constants																			}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeTabNonFront			= 0;
	kThemeTabNonFrontPressed	= 1;
	kThemeTabNonFrontInactive	= 2;
	kThemeTabFront				= 3;
	kThemeTabFrontInactive		= 4;


TYPE
	ThemeTabStyle						= UInt16;

CONST
	kThemeTabNorth				= 0;
	kThemeTabSouth				= 1;
	kThemeTabEast				= 2;
	kThemeTabWest				= 3;


TYPE
	ThemeTabDirection					= UInt16;
{ NOTE ON TAB HEIGHT																		}
{ Use the kThemeSmallTabHeightMax and kThemeLargeTabHeightMax when calculating the rects	}
{ to draw tabs into. This height includes the tab frame overlap. Tabs that are not in the	}
{ front are only drawn down to where they meet the frame, as if the height was just		}
{ kThemeLargeTabHeight, for example, as opposed to the ...Max constant. Remember that for	}
{ East and West tabs, the height referred to below is actually the width.					}

CONST
	kThemeSmallTabHeight		= 16;							{  amount small tabs protrude from frame. }
	kThemeLargeTabHeight		= 21;							{  amount large tabs protrude from frame. }
	kThemeTabPaneOverlap		= 3;							{  amount tabs overlap frame. }
	kThemeSmallTabHeightMax		= 19;							{  small tab height + overlap }
	kThemeLargeTabHeightMax		= 24;							{  large tab height + overlap }

{——————————————————————————————————————————————————————————————————————————————————————————}
{ Track kinds																				}
{——————————————————————————————————————————————————————————————————————————————————————————}
	kThemeScrollBar				= 0;
	kThemeSmallScrollBar		= 1;
	kThemeSlider				= 2;
	kThemeProgressBar			= 3;
	kThemeIndeterminateBar		= 4;


TYPE
	ThemeTrackKind						= UInt16;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Track enable states																		}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
																{  track states  }
	kThemeTrackActive			= 0;
	kThemeTrackDisabled			= 1;
	kThemeTrackNothingToScroll	= 2;


TYPE
	ThemeTrackEnableState				= UInt8;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Track pressed states																		}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
																{  press states (ignored unless track is active)  }
	kThemeLeftOutsideArrowPressed = $01;
	kThemeLeftInsideArrowPressed = $02;
	kThemeLeftTrackPressed		= $04;
	kThemeThumbPressed			= $08;
	kThemeRightTrackPressed		= $10;
	kThemeRightInsideArrowPressed = $20;
	kThemeRightOutsideArrowPressed = $40;
	kThemeTopOutsideArrowPressed = $01;
	kThemeTopInsideArrowPressed	= $02;
	kThemeTopTrackPressed		= $04;
	kThemeBottomTrackPressed	= $10;
	kThemeBottomInsideArrowPressed = $20;
	kThemeBottomOutsideArrowPressed = $40;


TYPE
	ThemeTrackPressState				= UInt8;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Thumb directions																			}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
																{  thumb direction  }
	kThemeThumbPlain			= 0;
	kThemeThumbUpward			= 1;
	kThemeThumbDownward			= 2;


TYPE
	ThemeThumbDirection					= UInt8;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Track attributes																			}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeTrackHorizontal		= $01;							{  track is drawn horizontally }
	kThemeTrackRightToLeft		= $02;							{  track progresses from right to left }
	kThemeTrackShowThumb		= $04;							{  track's thumb should be drawn }


TYPE
	ThemeTrackAttributes				= UInt16;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Track info block																			}
{——————————————————————————————————————————————————————————————————————————————————————————}
	ScrollBarTrackInfoPtr = ^ScrollBarTrackInfo;
	ScrollBarTrackInfo = RECORD
		viewsize:				SInt32;									{  current view range size  }
		pressState:				SInt8;									{  pressed parts state  }
	END;

	SliderTrackInfoPtr = ^SliderTrackInfo;
	SliderTrackInfo = RECORD
		thumbDir:				SInt8;									{  thumb direction  }
		pressState:				SInt8;									{  pressed parts state  }
	END;

	ProgressTrackInfoPtr = ^ProgressTrackInfo;
	ProgressTrackInfo = RECORD
		phase:					SInt8;									{  phase for indeterminate progress  }
	END;

	ThemeTrackDrawInfoPtr = ^ThemeTrackDrawInfo;
	ThemeTrackDrawInfo = RECORD
		kind:					ThemeTrackKind;							{  what kind of track this info is for  }
		bounds:					Rect;									{  track basis rectangle  }
		min:					SInt32;									{  min track value  }
		max:					SInt32;									{  max track value  }
		value:					SInt32;									{  current thumb value  }
		reserved:				UInt32;
		attributes:				ThemeTrackAttributes;					{  various track attributes  }
		enableState:			SInt8;									{  enable state  }
		filler1:				SInt8;
		CASE INTEGER OF
		0: (
			scrollbar:			ScrollBarTrackInfo;
			);
		1: (
			slider:				SliderTrackInfo;
			);
		2: (
			progress:			ProgressTrackInfo;
			);
	END;

{——————————————————————————————————————————————————————————————————————————————————————————}
{ ThemeWindowAttributes																	}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeWindowHasGrow			= $01;							{  can the size of the window be changed by the user?  }
	kThemeWindowHasHorizontalZoom = $08;						{  window can zoom only horizontally  }
	kThemeWindowHasVerticalZoom	= $10;							{  window can zoom only vertically  }
	kThemeWindowHasFullZoom		= $18;							{  window zooms in all directions  }
	kThemeWindowHasCloseBox		= $20;							{  window has a close box  }
	kThemeWindowHasCollapseBox	= $40;							{  window has a collapse box  }
	kThemeWindowHasTitleText	= $80;							{  window has a title/title icon  }
	kThemeWindowIsCollapsed		= $0100;						{  window is in the collapsed state  }


TYPE
	ThemeWindowAttributes				= UInt32;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Window Types Supported by the Appearance Manager											}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeDocumentWindow		= 0;
	kThemeDialogWindow			= 1;
	kThemeMovableDialogWindow	= 2;
	kThemeAlertWindow			= 3;
	kThemeMovableAlertWindow	= 4;
	kThemePlainDialogWindow		= 5;
	kThemeShadowDialogWindow	= 6;
	kThemePopupWindow			= 7;
	kThemeUtilityWindow			= 8;
	kThemeUtilitySideWindow		= 9;


TYPE
	ThemeWindowType						= UInt16;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Window Widgets Supported by the Appearance Manager										}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeWidgetCloseBox		= 0;
	kThemeWidgetZoomBox			= 1;
	kThemeWidgetCollapseBox		= 2;


TYPE
	ThemeTitleBarWidget					= UInt16;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Popup arrow orientations																	}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeArrowLeft				= 0;
	kThemeArrowDown				= 1;
	kThemeArrowRight			= 2;
	kThemeArrowUp				= 3;


TYPE
	ThemeArrowOrientation				= UInt16;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Popup arrow sizes																		}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeArrow3pt				= 0;
	kThemeArrow5pt				= 1;
	kThemeArrow7pt				= 2;
	kThemeArrow9pt				= 3;


TYPE
	ThemePopupArrowSize					= UInt16;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Grow box directions																		}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeGrowLeft				= $01;							{  can grow to the left  }
	kThemeGrowRight				= $02;							{  can grow to the right  }
	kThemeGrowUp				= $04;							{  can grow up  }
	kThemeGrowDown				= $08;							{  can grow down  }


TYPE
	ThemeGrowDirection					= UInt16;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Button kinds																				}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemePushButton			= 0;
	kThemeCheckBox				= 1;
	kThemeRadioButton			= 2;
	kThemeBevelButton			= 3;							{  bevel button (obsolete)  }
	kThemeArrowButton			= 4;							{  popup button without text  (no label)  }
	kThemePopupButton			= 5;							{  popup button  }
	kThemeDisclosureButton		= 6;
	kThemeIncDecButton			= 7;							{  increment/decrement buttons  (no label)  }
	kThemeSmallBevelButton		= 8;							{  small-shadow bevel button  }
	kThemeMediumBevelButton		= 3;							{  med-shadow bevel button  }
	kThemeLargeBevelButton		= 9;							{  large-shadow bevel button  }


TYPE
	ThemeButtonKind						= UInt16;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Common button values																		}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeButtonOff				= 0;
	kThemeButtonOn				= 1;
	kThemeButtonMixed			= 2;
	kThemeDisclosureRight		= 0;
	kThemeDisclosureDown		= 1;
	kThemeDisclosureLeft		= 2;


TYPE
	ThemeButtonValue					= UInt16;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Button adornment types																	}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeAdornmentNone			= 0;
	kThemeAdornmentDefault		= $01;							{  if set, draw default ornamentation ( push button only )  }
	kThemeAdornmentFocus		= $04;							{  if set, draw focus  }
	kThemeAdornmentRightToLeft	= $10;							{  if set, draw right to left label  }
	kThemeAdornmentDrawIndicatorOnly = $20;						{  if set, don't draw or erase label ( radio, check, disclosure )  }


TYPE
	ThemeButtonAdornment				= UInt16;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Button drawing info block																}
{——————————————————————————————————————————————————————————————————————————————————————————}
	ThemeButtonDrawInfoPtr = ^ThemeButtonDrawInfo;
	ThemeButtonDrawInfo = RECORD
		state:					ThemeDrawState;
		value:					ThemeButtonValue;
		adornment:				ThemeButtonAdornment;
	END;

{——————————————————————————————————————————————————————————————————————————————————————————}
{ Sound Support																			}
{——————————————————————————————————————————————————————————————————————————————————————————}
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Sound classes																			}
{																							}
{ You can use the constants below to set what sounds are active using the SetTheme API.	}
{ Use these with the kThemeSoundMask tag.													}
{——————————————————————————————————————————————————————————————————————————————————————————}

CONST
	kThemeNoSounds				= 0;
	kThemeWindowSoundsMask		= $01;
	kThemeMenuSoundsMask		= $02;
	kThemeControlSoundsMask		= $04;
	kThemeFinderSoundsMask		= $08;


{——————————————————————————————————————————————————————————————————————————————————————————}
{ Drag Sounds																				}
{																							}
{ Drag sounds are looped for the duration of the drag.										}
{																							}
{ Call BeginThemeDragSound at the start of the drag.										}
{ Call EndThemeDragSound when the drag has finished.										}
{																							}
{ Note that in order to maintain a consistent user experience, only one drag sound may 	}
{ occur at a time.  The sound should be attached to a mouse action, start after the 		}
{ mouse goes down and stop when the mouse is released.										}
{——————————————————————————————————————————————————————————————————————————————————————————}
	kThemeDragSoundNone			= 0;
	kThemeDragSoundMoveWindow	= 'wmov';
	kThemeDragSoundGrowWindow	= 'wgro';
	kThemeDragSoundMoveUtilWindow = 'umov';
	kThemeDragSoundGrowUtilWindow = 'ugro';
	kThemeDragSoundMoveDialog	= 'dmov';
	kThemeDragSoundMoveAlert	= 'amov';
	kThemeDragSoundMoveIcon		= 'imov';
	kThemeDragSoundSliderThumb	= 'slth';
	kThemeDragSoundSliderGhost	= 'slgh';
	kThemeDragSoundScrollBarThumb = 'sbth';
	kThemeDragSoundScrollBarGhost = 'sbgh';
	kThemeDragSoundScrollBarArrowDecreasing = 'sbad';
	kThemeDragSoundScrollBarArrowIncreasing = 'sbai';
	kThemeDragSoundDragging		= 'drag';


TYPE
	ThemeDragSoundKind					= OSType;
{——————————————————————————————————————————————————————————————————————————}
{ State-change sounds														}
{																			}
{ State-change sounds are played asynchonously as a one-shot.				}
{																			}
{ Call PlayThemeSound to play the sound.  The sound will play				}
{ asynchronously until complete, then stop automatically.					}
{——————————————————————————————————————————————————————————————————————————}

CONST
	kThemeSoundNone				= 0;
	kThemeSoundMenuOpen			= 'mnuo';						{  menu sounds  }
	kThemeSoundMenuClose		= 'mnuc';
	kThemeSoundMenuItemHilite	= 'mnui';
	kThemeSoundMenuItemRelease	= 'mnus';
	kThemeSoundWindowClosePress	= 'wclp';						{  window sounds  }
	kThemeSoundWindowCloseEnter	= 'wcle';
	kThemeSoundWindowCloseExit	= 'wclx';
	kThemeSoundWindowCloseRelease = 'wclr';
	kThemeSoundWindowZoomPress	= 'wzmp';
	kThemeSoundWindowZoomEnter	= 'wzme';
	kThemeSoundWindowZoomExit	= 'wzmx';
	kThemeSoundWindowZoomRelease = 'wzmr';
	kThemeSoundWindowCollapsePress = 'wcop';
	kThemeSoundWindowCollapseEnter = 'wcoe';
	kThemeSoundWindowCollapseExit = 'wcox';
	kThemeSoundWindowCollapseRelease = 'wcor';
	kThemeSoundWindowDragBoundary = 'wdbd';
	kThemeSoundUtilWinClosePress = 'uclp';						{  utility window sounds  }
	kThemeSoundUtilWinCloseEnter = 'ucle';
	kThemeSoundUtilWinCloseExit	= 'uclx';
	kThemeSoundUtilWinCloseRelease = 'uclr';
	kThemeSoundUtilWinZoomPress	= 'uzmp';
	kThemeSoundUtilWinZoomEnter	= 'uzme';
	kThemeSoundUtilWinZoomExit	= 'uzmx';
	kThemeSoundUtilWinZoomRelease = 'uzmr';
	kThemeSoundUtilWinCollapsePress = 'ucop';
	kThemeSoundUtilWinCollapseEnter = 'ucoe';
	kThemeSoundUtilWinCollapseExit = 'ucox';
	kThemeSoundUtilWinCollapseRelease = 'ucor';
	kThemeSoundUtilWinDragBoundary = 'udbd';
	kThemeSoundWindowOpen		= 'wopn';						{  window close and zoom action  }
	kThemeSoundWindowClose		= 'wcls';
	kThemeSoundWindowZoomIn		= 'wzmi';
	kThemeSoundWindowZoomOut	= 'wzmo';
	kThemeSoundWindowCollapseUp	= 'wcol';
	kThemeSoundWindowCollapseDown = 'wexp';
	kThemeSoundWindowActivate	= 'wact';
	kThemeSoundUtilWindowOpen	= 'uopn';
	kThemeSoundUtilWindowClose	= 'ucls';
	kThemeSoundUtilWindowZoomIn	= 'uzmi';
	kThemeSoundUtilWindowZoomOut = 'uzmo';
	kThemeSoundUtilWindowCollapseUp = 'ucol';
	kThemeSoundUtilWindowCollapseDown = 'uexp';
	kThemeSoundUtilWindowActivate = 'uact';
	kThemeSoundDialogOpen		= 'dopn';
	kThemeSoundDialogClose		= 'dlgc';
	kThemeSoundAlertOpen		= 'aopn';
	kThemeSoundAlertClose		= 'altc';
	kThemeSoundPopupWindowOpen	= 'pwop';
	kThemeSoundPopupWindowClose	= 'pwcl';
	kThemeSoundButtonPress		= 'btnp';						{  button  }
	kThemeSoundButtonEnter		= 'btne';
	kThemeSoundButtonExit		= 'btnx';
	kThemeSoundButtonRelease	= 'btnr';
	kThemeSoundDefaultButtonPress = 'dbtp';						{  default button  }
	kThemeSoundDefaultButtonEnter = 'dbte';
	kThemeSoundDefaultButtonExit = 'dbtx';
	kThemeSoundDefaultButtonRelease = 'dbtr';
	kThemeSoundCancelButtonPress = 'cbtp';						{  cancel button  }
	kThemeSoundCancelButtonEnter = 'cbte';
	kThemeSoundCancelButtonExit	= 'cbtx';
	kThemeSoundCancelButtonRelease = 'cbtr';
	kThemeSoundCheckboxPress	= 'chkp';						{  checkboxes  }
	kThemeSoundCheckboxEnter	= 'chke';
	kThemeSoundCheckboxExit		= 'chkx';
	kThemeSoundCheckboxRelease	= 'chkr';
	kThemeSoundRadioPress		= 'radp';						{  radio buttons  }
	kThemeSoundRadioEnter		= 'rade';
	kThemeSoundRadioExit		= 'radx';
	kThemeSoundRadioRelease		= 'radr';
	kThemeSoundScrollArrowPress	= 'sbap';						{  scroll bars  }
	kThemeSoundScrollArrowEnter	= 'sbae';
	kThemeSoundScrollArrowExit	= 'sbax';
	kThemeSoundScrollArrowRelease = 'sbar';
	kThemeSoundScrollEndOfTrack	= 'sbte';
	kThemeSoundScrollTrackPress	= 'sbtp';
	kThemeSoundSliderEndOfTrack	= 'slte';						{  sliders  }
	kThemeSoundSliderTrackPress	= 'sltp';
	kThemeSoundBalloonOpen		= 'blno';						{  help balloons  }
	kThemeSoundBalloonClose		= 'blnc';
	kThemeSoundBevelPress		= 'bevp';						{  Bevel buttons  }
	kThemeSoundBevelEnter		= 'beve';
	kThemeSoundBevelExit		= 'bevx';
	kThemeSoundBevelRelease		= 'bevr';
	kThemeSoundLittleArrowUpPress = 'laup';						{  Little Arrows  }
	kThemeSoundLittleArrowDnPress = 'ladp';
	kThemeSoundLittleArrowEnter	= 'lare';
	kThemeSoundLittleArrowExit	= 'larx';
	kThemeSoundLittleArrowUpRelease = 'laur';
	kThemeSoundLittleArrowDnRelease = 'ladr';
	kThemeSoundPopupPress		= 'popp';						{  Popup Buttons  }
	kThemeSoundPopupEnter		= 'pope';
	kThemeSoundPopupExit		= 'popx';
	kThemeSoundPopupRelease		= 'popr';
	kThemeSoundDisclosurePress	= 'dscp';						{  Disclosure Buttons  }
	kThemeSoundDisclosureEnter	= 'dsce';
	kThemeSoundDisclosureExit	= 'dscx';
	kThemeSoundDisclosureRelease = 'dscr';
	kThemeSoundTabPressed		= 'tabp';						{  Tabs  }
	kThemeSoundTabEnter			= 'tabe';
	kThemeSoundTabExit			= 'tabx';
	kThemeSoundTabRelease		= 'tabr';
	kThemeSoundDragTargetHilite	= 'dthi';						{  drag manager  }
	kThemeSoundDragTargetUnhilite = 'dtuh';
	kThemeSoundDragTargetDrop	= 'dtdr';
	kThemeSoundEmptyTrash		= 'ftrs';						{  finder  }
	kThemeSoundSelectItem		= 'fsel';
	kThemeSoundNewItem			= 'fnew';
	kThemeSoundReceiveDrop		= 'fdrp';
	kThemeSoundCopyDone			= 'fcpd';
	kThemeSoundResolveAlias		= 'fral';
	kThemeSoundLaunchApp		= 'flap';
	kThemeSoundDiskInsert		= 'dski';
	kThemeSoundDiskEject		= 'dske';
	kThemeSoundFinderDragOnIcon	= 'fdon';
	kThemeSoundFinderDragOffIcon = 'fdof';


TYPE
	ThemeSoundKind						= OSType;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Window Metrics																			}
{——————————————————————————————————————————————————————————————————————————————————————————}
{ 	Window metrics are used by the Appearance manager to fill in the blanks necessary to 	}
{ 	draw windows. If a value is not appropriate for the type of window, be sure to fill in	}
{ 	the slot in the structure with zero.	For the popupTabOffset parameter, you can pass a}
{ 	real value based on the left edge of the window. This value might be interpreted in a 	}
{ 	different manner when depending on the value of the popupTabPosition field. The values	}
{ 	you can pass into popupTabPosition are:													}
{																							}
{	kThemePopupTabNormalPosition															}
{		Starts the tab left edge at the position indicated by the popupTabOffset field.		}
{																							}
{	kThemePopupTabCenterOnWindow															}
{		tells us to ignore the offset field and instead simply center the width of the 		}
{		handle on the window.																}
{																							}
{	kThemePopupTabCenterOnOffset															}
{		tells us to center the width of the handle around the value passed in offset.		}
{																							}
{ 	The Appearance Manager will try its best to accomodate the requested placement, but may }
{ 	move the handle slightly to make it fit correctly.										}
{																							}

CONST
	kThemePopupTabNormalPosition = 0;
	kThemePopupTabCenterOnWindow = 1;
	kThemePopupTabCenterOnOffset = 2;


TYPE
	ThemeWindowMetricsPtr = ^ThemeWindowMetrics;
	ThemeWindowMetrics = RECORD
		metricSize:				UInt16;									{  should be always be sizeof( ThemeWindowMetrics ) }
		titleHeight:			SInt16;
		titleWidth:				SInt16;
		popupTabOffset:			SInt16;
		popupTabWidth:			SInt16;
		popupTabPosition:		UInt16;
	END;

{——————————————————————————————————————————————————————————————————————————————————————————}
{ Drawing State																			}
{——————————————————————————————————————————————————————————————————————————————————————————}
	ThemeDrawingState = ^LONGINT;
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Callback procs																			}
{——————————————————————————————————————————————————————————————————————————————————————————}
{$IFC TYPED_FUNCTION_POINTERS}
	ThemeTabTitleDrawProcPtr = PROCEDURE({CONST}VAR bounds: Rect; style: ThemeTabStyle; direction: ThemeTabDirection; depth: SInt16; isColorDev: BOOLEAN; userData: UInt32);
{$ELSEC}
	ThemeTabTitleDrawProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ThemeEraseProcPtr = PROCEDURE({CONST}VAR bounds: Rect; eraseData: UInt32; depth: SInt16; isColorDev: BOOLEAN);
{$ELSEC}
	ThemeEraseProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ThemeButtonDrawProcPtr = PROCEDURE({CONST}VAR bounds: Rect; kind: ThemeButtonKind; VAR info: ThemeButtonDrawInfo; userData: UInt32; depth: SInt16; isColorDev: BOOLEAN);
{$ELSEC}
	ThemeButtonDrawProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	WindowTitleDrawingProcPtr = PROCEDURE({CONST}VAR bounds: Rect; depth: SInt16; colorDevice: BOOLEAN; userData: UInt32);
{$ELSEC}
	WindowTitleDrawingProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ThemeIteratorProcPtr = FUNCTION(inFileName: Str255; resID: SInt16; inThemeSettings: Collection; inUserData: UNIV Ptr): BOOLEAN;
{$ELSEC}
	ThemeIteratorProcPtr = ProcPtr;
{$ENDC}

	ThemeTabTitleDrawUPP = UniversalProcPtr;
	ThemeEraseUPP = UniversalProcPtr;
	ThemeButtonDrawUPP = UniversalProcPtr;
	WindowTitleDrawingUPP = UniversalProcPtr;
	ThemeIteratorUPP = UniversalProcPtr;

CONST
	uppThemeTabTitleDrawProcInfo = $00036AC0;
	uppThemeEraseProcInfo = $00001BC0;
	uppThemeButtonDrawProcInfo = $0001BEC0;
	uppWindowTitleDrawingProcInfo = $000036C0;
	uppThemeIteratorProcInfo = $00003ED0;

FUNCTION NewThemeTabTitleDrawProc(userRoutine: ThemeTabTitleDrawProcPtr): ThemeTabTitleDrawUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewThemeEraseProc(userRoutine: ThemeEraseProcPtr): ThemeEraseUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewThemeButtonDrawProc(userRoutine: ThemeButtonDrawProcPtr): ThemeButtonDrawUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewWindowTitleDrawingProc(userRoutine: WindowTitleDrawingProcPtr): WindowTitleDrawingUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewThemeIteratorProc(userRoutine: ThemeIteratorProcPtr): ThemeIteratorUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallThemeTabTitleDrawProc({CONST}VAR bounds: Rect; style: ThemeTabStyle; direction: ThemeTabDirection; depth: SInt16; isColorDev: BOOLEAN; userData: UInt32; userRoutine: ThemeTabTitleDrawUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallThemeEraseProc({CONST}VAR bounds: Rect; eraseData: UInt32; depth: SInt16; isColorDev: BOOLEAN; userRoutine: ThemeEraseUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallThemeButtonDrawProc({CONST}VAR bounds: Rect; kind: ThemeButtonKind; VAR info: ThemeButtonDrawInfo; userData: UInt32; depth: SInt16; isColorDev: BOOLEAN; userRoutine: ThemeButtonDrawUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallWindowTitleDrawingProc({CONST}VAR bounds: Rect; depth: SInt16; colorDevice: BOOLEAN; userData: UInt32; userRoutine: WindowTitleDrawingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallThemeIteratorProc(inFileName: Str255; resID: SInt16; inThemeSettings: Collection; inUserData: UNIV Ptr; userRoutine: ThemeIteratorUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————}
{ Menu Drawing callbacks														    }
{——————————————————————————————————————————————————————————————————————————————————}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	MenuTitleDrawingProcPtr = PROCEDURE({CONST}VAR inBounds: Rect; inDepth: SInt16; inIsColorDevice: BOOLEAN; inUserData: SInt32);
{$ELSEC}
	MenuTitleDrawingProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MenuItemDrawingProcPtr = PROCEDURE({CONST}VAR inBounds: Rect; inDepth: SInt16; inIsColorDevice: BOOLEAN; inUserData: SInt32);
{$ELSEC}
	MenuItemDrawingProcPtr = ProcPtr;
{$ENDC}

	MenuTitleDrawingUPP = UniversalProcPtr;
	MenuItemDrawingUPP = UniversalProcPtr;

CONST
	uppMenuTitleDrawingProcInfo = $000036C0;
	uppMenuItemDrawingProcInfo = $000036C0;

FUNCTION NewMenuTitleDrawingProc(userRoutine: MenuTitleDrawingProcPtr): MenuTitleDrawingUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMenuItemDrawingProc(userRoutine: MenuItemDrawingProcPtr): MenuItemDrawingUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallMenuTitleDrawingProc({CONST}VAR inBounds: Rect; inDepth: SInt16; inIsColorDevice: BOOLEAN; inUserData: SInt32; userRoutine: MenuTitleDrawingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallMenuItemDrawingProc({CONST}VAR inBounds: Rect; inDepth: SInt16; inIsColorDevice: BOOLEAN; inUserData: SInt32; userRoutine: MenuItemDrawingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
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
FUNCTION IsAppearanceClient({CONST}VAR process: ProcessSerialNumber): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $FFFF, $AA74;
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

FUNCTION SetThemePen(inBrush: ThemeBrush; inDepth: SInt16; inIsColorDevice: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0001, $AA74;
	{$ENDC}
FUNCTION SetThemeBackground(inBrush: ThemeBrush; inDepth: SInt16; inIsColorDevice: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0002, $AA74;
	{$ENDC}
FUNCTION SetThemeTextColor(inColor: ThemeTextColor; inDepth: SInt16; inIsColorDevice: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0003, $AA74;
	{$ENDC}
FUNCTION SetThemeWindowBackground(inWindow: WindowPtr; inBrush: ThemeBrush; inUpdate: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0004, $AA74;
	{$ENDC}
{ Window Placards, Headers and Frames }
FUNCTION DrawThemeWindowHeader({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0005, $AA74;
	{$ENDC}
FUNCTION DrawThemeWindowListViewHeader({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0006, $AA74;
	{$ENDC}
FUNCTION DrawThemePlacard({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0007, $AA74;
	{$ENDC}
FUNCTION DrawThemeEditTextFrame({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0009, $AA74;
	{$ENDC}
FUNCTION DrawThemeListBoxFrame({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000A, $AA74;
	{$ENDC}
{ Keyboard Focus Drawing }
FUNCTION DrawThemeFocusRect({CONST}VAR inRect: Rect; inHasFocus: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000B, $AA74;
	{$ENDC}
{ Dialog Group Boxes and Separators }
FUNCTION DrawThemePrimaryGroup({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000C, $AA74;
	{$ENDC}
FUNCTION DrawThemeSecondaryGroup({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000D, $AA74;
	{$ENDC}
FUNCTION DrawThemeSeparator({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000E, $AA74;
	{$ENDC}
{—————————————————————————————— BEGIN APPEARANCE 1.0.1 ————————————————————————————————————————————}
{ The following Appearance Manager APIs are only available }
{ in Appearance 1.0.1 or later 							}
FUNCTION DrawThemeModelessDialogFrame({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0008, $AA74;
	{$ENDC}
FUNCTION DrawThemeGenericWell({CONST}VAR inRect: Rect; inState: ThemeDrawState; inFillCenter: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0022, $AA74;
	{$ENDC}
FUNCTION DrawThemeFocusRegion(inRegion: RgnHandle; inHasFocus: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0023, $AA74;
	{$ENDC}
FUNCTION IsThemeInColor(inDepth: SInt16; inIsColorDevice: BOOLEAN): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0024, $AA74;
	{$ENDC}
{ IMPORTANT: GetThemeAccentColors will only work in the platinum theme. Any other theme will }
{ most likely return an error }
FUNCTION GetThemeAccentColors(VAR outColors: CTabHandle): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0025, $AA74;
	{$ENDC}
FUNCTION DrawThemeMenuBarBackground({CONST}VAR inBounds: Rect; inState: ThemeMenuBarState; inAttributes: UInt32): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0018, $AA74;
	{$ENDC}
FUNCTION DrawThemeMenuTitle({CONST}VAR inMenuBarRect: Rect; {CONST}VAR inTitleRect: Rect; inState: ThemeMenuState; inAttributes: UInt32; inTitleProc: MenuTitleDrawingUPP; inTitleData: UInt32): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0019, $AA74;
	{$ENDC}
FUNCTION GetThemeMenuBarHeight(VAR outHeight: SInt16): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001A, $AA74;
	{$ENDC}
FUNCTION DrawThemeMenuBackground({CONST}VAR inMenuRect: Rect; inMenuType: ThemeMenuType): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001B, $AA74;
	{$ENDC}
FUNCTION GetThemeMenuBackgroundRegion({CONST}VAR inMenuRect: Rect; menuType: ThemeMenuType; region: RgnHandle): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001C, $AA74;
	{$ENDC}
FUNCTION DrawThemeMenuItem({CONST}VAR inMenuRect: Rect; {CONST}VAR inItemRect: Rect; inVirtualMenuTop: SInt16; inVirtualMenuBottom: SInt16; inState: ThemeMenuState; inItemType: ThemeMenuItemType; inDrawProc: MenuItemDrawingUPP; inUserData: UInt32): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001D, $AA74;
	{$ENDC}
FUNCTION DrawThemeMenuSeparator({CONST}VAR inItemRect: Rect): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001E, $AA74;
	{$ENDC}
FUNCTION GetThemeMenuSeparatorHeight(VAR outHeight: SInt16): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001F, $AA74;
	{$ENDC}
FUNCTION GetThemeMenuItemExtra(inItemType: ThemeMenuItemType; VAR outHeight: SInt16; VAR outWidth: SInt16): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0020, $AA74;
	{$ENDC}
FUNCTION GetThemeMenuTitleExtra(VAR outWidth: SInt16; inIsSquished: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0021, $AA74;
	{$ENDC}
{——————————————————————————————— BEGIN APPEARANCE 1.1 —————————————————————————————————————————————}
{—————————————————————————————————— THEME SWITCHING ———————————————————————————————————————————————}
FUNCTION GetTheme(ioCollection: Collection): OSStatus;
FUNCTION SetTheme(ioCollection: Collection): OSStatus;
FUNCTION IterateThemes(inProc: ThemeIteratorUPP; inUserData: UNIV Ptr): OSStatus;
{———————————————————————————————————————— TABS ————————————————————————————————————————————————————}
FUNCTION DrawThemeTabPane({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
FUNCTION DrawThemeTab({CONST}VAR inRect: Rect; inStyle: ThemeTabStyle; inDirection: ThemeTabDirection; labelProc: ThemeTabTitleDrawUPP; userData: UInt32): OSStatus;
FUNCTION GetThemeTabRegion({CONST}VAR inRect: Rect; inStyle: ThemeTabStyle; inDirection: ThemeTabDirection; ioRgn: RgnHandle): OSStatus;
{——————————————————————————————————————— CURSORS ——————————————————————————————————————————————————}
FUNCTION SetThemeCursor(inCursor: ThemeCursor): OSStatus;
FUNCTION SetAnimatedThemeCursor(inCursor: ThemeCursor; inAnimationStep: UInt32): OSStatus;
{———————————————————————————————— CONTROL STYLE SETTINGS ——————————————————————————————————————————}
FUNCTION GetThemeScrollBarThumbStyle(VAR outStyle: ThemeScrollBarThumbStyle): OSStatus;
FUNCTION GetThemeScrollBarArrowStyle(VAR outStyle: ThemeScrollBarArrowStyle): OSStatus;
FUNCTION GetThemeCheckBoxStyle(VAR outStyle: ThemeCheckBoxStyle): OSStatus;
{———————————————————————————————————————— FONTS ———————————————————————————————————————————————————}
FUNCTION UseThemeFont(inFontID: ThemeFontID; inScript: ScriptCode): OSStatus;
FUNCTION GetThemeFont(inFontID: ThemeFontID; inScript: ScriptCode; outFontName: StringPtr; VAR outFontSize: SInt16; VAR outStyle: Style): OSStatus;
{———————————————————————————————————————— TRACKS ——————————————————————————————————————————————————}
FUNCTION DrawThemeTrack({CONST}VAR drawInfo: ThemeTrackDrawInfo; rgnGhost: RgnHandle; eraseProc: ThemeEraseUPP; eraseData: UInt32): OSStatus;
FUNCTION HitTestThemeTrack({CONST}VAR drawInfo: ThemeTrackDrawInfo; mousePoint: Point; VAR partHit: ControlPartCode): BOOLEAN;
FUNCTION GetThemeTrackBounds({CONST}VAR drawInfo: ThemeTrackDrawInfo; VAR bounds: Rect): OSStatus;
FUNCTION GetThemeTrackThumbRgn({CONST}VAR drawInfo: ThemeTrackDrawInfo; thumbRgn: RgnHandle): OSStatus;
FUNCTION GetThemeTrackDragRect({CONST}VAR drawInfo: ThemeTrackDrawInfo; VAR dragRect: Rect): OSStatus;
FUNCTION DrawThemeTrackTickMarks({CONST}VAR drawInfo: ThemeTrackDrawInfo; numTicks: ItemCount; eraseProc: ThemeEraseUPP; eraseData: UInt32): OSStatus;
FUNCTION GetThemeTrackThumbPositionFromOffset({CONST}VAR drawInfo: ThemeTrackDrawInfo; thumbOffset: Point; VAR relativePosition: SInt32): OSStatus;
FUNCTION GetThemeTrackThumbPositionFromRegion({CONST}VAR drawInfo: ThemeTrackDrawInfo; thumbRgn: RgnHandle; VAR relativePosition: SInt32): OSStatus;
FUNCTION GetThemeTrackLiveValue({CONST}VAR drawInfo: ThemeTrackDrawInfo; relativePosition: SInt32; VAR value: SInt32): OSStatus;
{——————————————————————————————————— SCROLLBAR ARROWS —————————————————————————————————————————————}
FUNCTION DrawThemeScrollBarArrows({CONST}VAR bounds: Rect; enableState: ByteParameter; pressState: ByteParameter; isHoriz: BOOLEAN; VAR trackBounds: Rect): OSStatus;
FUNCTION GetThemeScrollBarTrackRect({CONST}VAR bounds: Rect; enableState: ByteParameter; pressState: ByteParameter; isHoriz: BOOLEAN; VAR trackBounds: Rect): OSStatus;
FUNCTION HitTestThemeScrollBarArrows({CONST}VAR scrollBarBounds: Rect; enableState: ByteParameter; pressState: ByteParameter; isHoriz: BOOLEAN; ptHit: Point; VAR trackBounds: Rect; VAR partcode: ControlPartCode): BOOLEAN;
{———————————————————————————————————————— WINDOWS —————————————————————————————————————————————————}
FUNCTION GetThemeWindowRegion(flavor: ThemeWindowType; {CONST}VAR contRect: Rect; state: ThemeDrawState; {CONST}VAR metrics: ThemeWindowMetrics; attributes: ThemeWindowAttributes; winRegion: WindowRegionCode; rgn: RgnHandle): OSStatus;
FUNCTION DrawThemeWindowFrame(flavor: ThemeWindowType; {CONST}VAR contRect: Rect; state: ThemeDrawState; {CONST}VAR metrics: ThemeWindowMetrics; attributes: ThemeWindowAttributes; titleProc: WindowTitleDrawingUPP; titleData: UInt32): OSStatus;
FUNCTION DrawThemeTitleBarWidget(flavor: ThemeWindowType; {CONST}VAR contRect: Rect; state: ThemeDrawState; {CONST}VAR metrics: ThemeWindowMetrics; attributes: ThemeWindowAttributes; widget: ThemeTitleBarWidget): OSStatus;
FUNCTION GetThemeWindowRegionHit(flavor: ThemeWindowType; {CONST}VAR inContRect: Rect; state: ThemeDrawState; {CONST}VAR metrics: ThemeWindowMetrics; inAttributes: ThemeWindowAttributes; inPoint: Point; VAR outRegionHit: WindowRegionCode): BOOLEAN;
FUNCTION DrawThemeScrollBarDelimiters(flavor: ThemeWindowType; {CONST}VAR inContRect: Rect; state: ThemeDrawState; attributes: ThemeWindowAttributes): OSStatus;
{———————————————————————————————————————— BUTTONS —————————————————————————————————————————————————}
FUNCTION DrawThemeButton({CONST}VAR inBounds: Rect; inKind: ThemeButtonKind; {CONST}VAR inNewInfo: ThemeButtonDrawInfo; {CONST}VAR inPrevInfo: ThemeButtonDrawInfo; inEraseProc: ThemeEraseUPP; inLabelProc: ThemeButtonDrawUPP; inUserData: UInt32): OSStatus;
FUNCTION GetThemeButtonRegion({CONST}VAR inBounds: Rect; inKind: ThemeButtonKind; {CONST}VAR inNewInfo: ThemeButtonDrawInfo; outRegion: RgnHandle): OSStatus;
FUNCTION GetThemeButtonContentBounds({CONST}VAR inBounds: Rect; inKind: ThemeButtonKind; {CONST}VAR inDrawInfo: ThemeButtonDrawInfo; VAR outBounds: Rect): OSStatus;
FUNCTION GetThemeButtonBackgroundBounds({CONST}VAR inBounds: Rect; inKind: ThemeButtonKind; {CONST}VAR inDrawInfo: ThemeButtonDrawInfo; VAR outBounds: Rect): OSStatus;

{————————————————————————————————————— INTERFACE SOUNDS ———————————————————————————————————————————}
FUNCTION PlayThemeSound(kind: ThemeSoundKind): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0026, $AA74;
	{$ENDC}
FUNCTION BeginThemeDragSound(kind: ThemeDragSoundKind): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0027, $AA74;
	{$ENDC}
FUNCTION EndThemeDragSound: OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0028, $AA74;
	{$ENDC}
{—————————————————————————————————————— PRIMITIVES ————————————————————————————————————————————————}
FUNCTION DrawThemeTickMark({CONST}VAR bounds: Rect; state: ThemeDrawState): OSStatus;
FUNCTION DrawThemeChasingArrows({CONST}VAR bounds: Rect; index: UInt32; state: ThemeDrawState; eraseProc: ThemeEraseUPP; eraseData: UInt32): OSStatus;
FUNCTION DrawThemePopupArrow({CONST}VAR bounds: Rect; orientation: ThemeArrowOrientation; size: ThemePopupArrowSize; state: ThemeDrawState; eraseProc: ThemeEraseUPP; eraseData: UInt32): OSStatus;
FUNCTION DrawThemeStandaloneGrowBox(origin: Point; growDirection: ThemeGrowDirection; isSmall: BOOLEAN; state: ThemeDrawState): OSStatus;
FUNCTION DrawThemeStandaloneNoGrowBox(origin: Point; growDirection: ThemeGrowDirection; isSmall: BOOLEAN; state: ThemeDrawState): OSStatus;
FUNCTION GetThemeStandaloneGrowBoxBounds(origin: Point; growDirection: ThemeGrowDirection; isSmall: BOOLEAN; VAR bounds: Rect): OSStatus;
{————————————————————————————————————— DRAWING STATE ——————————————————————————————————————————————}
{ The following routines help you save and restore the drawing state in a theme-savvy manner. With	}
{ these weapons in your arsenal, there is no grafport you cannot tame.	Use ThemeGetDrawingState to	}
{ get the current drawing settings for the current port. It will return an opaque object for you 	}
{ to pass into ThemeSetDrawingState later on. When you are finished with the state, call the		}
{ ThemeDisposeDrawingState routine. You can alternatively pass true into the inDisposeNow 			}
{ parameter of the ThemeSetDrawingState routine.  You can use this routine to copy the drawing		}
{ state from one port to another as well.															}
FUNCTION NormalizeThemeDrawingState: OSStatus;
FUNCTION GetThemeDrawingState(VAR outState: ThemeDrawingState): OSStatus;
FUNCTION SetThemeDrawingState(inState: ThemeDrawingState; inDisposeNow: BOOLEAN): OSStatus;
FUNCTION DisposeThemeDrawingState(inState: ThemeDrawingState): OSStatus;
{————————————————————————————————————— MISCELLANEOUS ——————————————————————————————————————————————}
{ ApplyThemeBackground is used to set up the background for embedded controls 	}
{ It is normally called by controls that are embedders. The standard controls	}
{ call this API to ensure a correct background for the current theme. You pass }
{ in the same rectangle you would if you were calling the drawing primitive.	}
FUNCTION ApplyThemeBackground(inKind: ThemeBackgroundKind; {CONST}VAR bounds: Rect; inState: ThemeDrawState; inDepth: SInt16; inColorDev: BOOLEAN): OSStatus;
FUNCTION SetThemeTextColorForWindow(window: WindowPtr; isActive: BOOLEAN; depth: SInt16; isColorDev: BOOLEAN): OSStatus;
FUNCTION IsValidAppearanceFileType(fileType: OSType): BOOLEAN;
FUNCTION GetThemeBrushAsColor(inBrush: ThemeBrush; inDepth: SInt16; inColorDev: BOOLEAN; VAR outColor: RGBColor): OSStatus;
FUNCTION GetThemeTextColor(inColor: ThemeTextColor; inDepth: SInt16; inColorDev: BOOLEAN; VAR outColor: RGBColor): OSStatus;
{——————————————————————————————————————————————————————————————————————————————————————————————————}
{ Obsolete symbolic names																			}
{——————————————————————————————————————————————————————————————————————————————————————————————————}
{ Obsolete error codes - use the new ones, s'il vous plait / kudasai }

CONST
	appearanceBadBrushIndexErr	= -30560;						{  pattern index invalid  }
	appearanceProcessRegisteredErr = -30561;
	appearanceProcessNotRegisteredErr = -30562;
	appearanceBadTextColorIndexErr = -30563;
	appearanceThemeHasNoAccents	= -30564;
	appearanceBadCursorIndexErr	= -30565;

	kThemeActiveDialogBackgroundBrush = 1;
	kThemeInactiveDialogBackgroundBrush = 2;
	kThemeActiveAlertBackgroundBrush = 3;
	kThemeInactiveAlertBackgroundBrush = 4;
	kThemeActiveModelessDialogBackgroundBrush = 5;
	kThemeInactiveModelessDialogBackgroundBrush = 6;
	kThemeActiveUtilityWindowBackgroundBrush = 7;
	kThemeInactiveUtilityWindowBackgroundBrush = 8;
	kThemeListViewSortColumnBackgroundBrush = 9;
	kThemeListViewBackgroundBrush = 10;
	kThemeIconLabelBackgroundBrush = 11;
	kThemeListViewSeparatorBrush = 12;
	kThemeChasingArrowsBrush	= 13;
	kThemeDragHiliteBrush		= 14;
	kThemeDocumentWindowBackgroundBrush = 15;
	kThemeFinderWindowBackgroundBrush = 16;

	kThemeActiveScrollBarDelimiterBrush = 17;
	kThemeInactiveScrollBarDelimiterBrush = 18;
	kThemeFocusHighlightBrush	= 19;
	kThemeActivePopupArrowBrush	= 20;
	kThemePressedPopupArrowBrush = 21;
	kThemeInactivePopupArrowBrush = 22;
	kThemeAppleGuideCoachmarkBrush = 23;

	kThemeActiveDialogTextColor	= 1;
	kThemeInactiveDialogTextColor = 2;
	kThemeActiveAlertTextColor	= 3;
	kThemeInactiveAlertTextColor = 4;
	kThemeActiveModelessDialogTextColor = 5;
	kThemeInactiveModelessDialogTextColor = 6;
	kThemeActiveWindowHeaderTextColor = 7;
	kThemeInactiveWindowHeaderTextColor = 8;
	kThemeActivePlacardTextColor = 9;
	kThemeInactivePlacardTextColor = 10;
	kThemePressedPlacardTextColor = 11;
	kThemeActivePushButtonTextColor = 12;
	kThemeInactivePushButtonTextColor = 13;
	kThemePressedPushButtonTextColor = 14;
	kThemeActiveBevelButtonTextColor = 15;
	kThemeInactiveBevelButtonTextColor = 16;
	kThemePressedBevelButtonTextColor = 17;
	kThemeActivePopupButtonTextColor = 18;
	kThemeInactivePopupButtonTextColor = 19;
	kThemePressedPopupButtonTextColor = 20;
	kThemeIconLabelTextColor	= 21;
	kThemeListViewTextColor		= 22;

	kThemeActiveDocumentWindowTitleTextColor = 23;
	kThemeInactiveDocumentWindowTitleTextColor = 24;
	kThemeActiveMovableModalWindowTitleTextColor = 25;
	kThemeInactiveMovableModalWindowTitleTextColor = 26;
	kThemeActiveUtilityWindowTitleTextColor = 27;
	kThemeInactiveUtilityWindowTitleTextColor = 28;
	kThemeActivePopupWindowTitleColor = 29;
	kThemeInactivePopupWindowTitleColor = 30;
	kThemeActiveRootMenuTextColor = 31;
	kThemeSelectedRootMenuTextColor = 32;
	kThemeDisabledRootMenuTextColor = 33;
	kThemeActiveMenuItemTextColor = 34;
	kThemeSelectedMenuItemTextColor = 35;
	kThemeDisabledMenuItemTextColor = 36;
	kThemeActivePopupLabelTextColor = 37;
	kThemeInactivePopupLabelTextColor = 38;

	kAEThemeSwitch				= 'thme';						{  Event ID's: Theme Switched  }

	kThemeNoAdornment			= 0;
	kThemeDefaultAdornment		= $01;
	kThemeFocusAdornment		= $04;
	kThemeRightToLeftAdornment	= $10;
	kThemeDrawIndicatorOnly		= $20;

	kThemeBrushPassiveAreaFill	= 25;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AppearanceIncludes}

{$ENDC} {__APPEARANCE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
