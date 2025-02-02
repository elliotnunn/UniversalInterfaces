/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple Input/Output Window
#
#	SIOW
#
#	Copyright:	© 1989-1993 by Apple Computer, Inc., all rights reserved.
#
------------------------------------------------------------------------------*/

#include "systypes.r"
#include "types.r"

#include "SIOW.h"

#ifndef CREATOR
	#define CREATOR 'siow'
#endif

#ifndef FCREATOR
	#define FCREATOR 'MPS '
#endif

#ifndef WINDOW_HEIGTH
	#define WINDOW_HEIGTH 286
#endif

#ifndef WINDOW_WIDTH
	#define WINDOW_WIDTH 480
#endif


type 'pzza' {
	literal longint;
};

resource 'pzza' (128, purgeable) {
	FCREATOR;
};

/* we use an MBAR resource to conveniently load all the menus */

resource 'MBAR' (__rMenuBar, preload) {
	{ __mApple, __mFile, __mEdit, __mFont /*, __mSize */};		/* five menus */
};


resource 'MENU' (__mApple, preload) {
	__mApple, textMenuProc,
	0b1111111111111111111111111111101,	/* disable dashed line, enable About and DAs */
	enabled, apple,
	{
		"About S I O W\311",
			noicon, nokey, nomark, plain;
		"-",
			noicon, nokey, nomark, plain
	}
};

resource 'MENU' (__mFile, preload) {
	__mFile, textMenuProc,
	0b000000000000000000000000000000,	/* enable Quit only, program enables others */
	enabled, "File",
	{
		"New",
			noicon, "N", nomark, plain;
		"Open",
			noicon, "O", nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Close",
			noicon, "W", nomark, plain;
		"Save",
			noicon, "S", nomark, plain;
		"Save As\311",
			noicon, nokey, nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Page Setup\311",
			noicon, nokey, nomark, plain;
// 12/13/93 - Added Command-P equivalent to Print item
		"Print\311",
			noicon, "P", nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Quit",
			noicon, "Q", nomark, plain
	}
};

resource 'MENU' (__mEdit, preload) {
	__mEdit, textMenuProc,
	0b0000000000000000000000000000000,	/* disable everything, program does the enabling */
	enabled, "Edit",
	 {
		"Undo",
			noicon, "Z", nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Cut",
			noicon, "X", nomark, plain;
		"Copy",
			noicon, "C", nomark, plain;
		"Paste",
			noicon, "V", nomark, plain;
		"Clear",
			noicon, nokey, nomark, plain
	}
};

resource 'MENU' (__mFont, preload) {
	__mFont, textMenuProc,
	0b1111111111111111111111111111111,	/* enable everything */
	enabled, "Font",
	 {
	 }
};

/* this ALRT and DITL are used as an About screen */

resource 'ALRT' (__rAboutAlert, purgeable) {
// 12/13/93 - GAB: support for native PowerPC version
#ifdef APPNAME	// taller dialog for PowerPC version
	{66, 58, 354, 396},
#else
	{66, 58, 344, 396},
#endif
	 __rAboutAlert, {
		OK, visible, silent;
		OK, visible, silent;
		OK, visible, silent;
		OK, visible, silent
	}
	/*	The following are window positioning options ,usable in 7.0	*/
#if SystemSevenOrLater
	, centerParentWindowScreen
#endif
	;
};

resource 'DITL' (__rAboutAlert, purgeable) {
	{	/* array DITLarray: 10 elements */
		/* [1] */
// 12/13/93 - GAB: support for native PowerPC version
#ifdef APPNAME	// taller dialog for PowerPC version
		{260, 129, 280, 209},
#else
		{233, 144, 253, 224},
#endif
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{8, 72, 23, 264},
		StaticText {
			disabled,
			"Simple Input/Output Window"
		},
		/* [3] */
		{56, 24, 71, 337},
		StaticText {
			disabled,
			$$Format("Copyright ©Apple Computer, Inc. 1989-%d ", $$Year)
		},
		/* [4] */
		{80, 108, 96, 244},
		StaticText {
			disabled,
			"Brought to you by..."
		},
		/* [5] */
		{109, 132, 134, 229},
		StaticText {
			disabled,
			"\"PZZA SLT\""
		},
		/* [6] */
		{152, 24, 170, 212},
		StaticText {
			disabled,
			"Special Thanks to..."
		},
		/* [7] */
		{176, 56, 194, 289},
		StaticText {
			disabled,
			"Roger, Russ, Landon, Ira & Munch"
		},
// 12/13/93 - GAB: support for native PowerPC version
#ifdef APPNAME	// for native PowerPC build only
		/* [8] */
		{200, 24, 218, 212},
		StaticText {
			disabled,
			"PowerPC port by…"
		},
		/* [9] */
		{224, 56, 242, 289},
		StaticText {
			disabled,
			"Greg Branche"
		},
#endif
		/* [10] */
		{32, 152, 47, 200},
		StaticText {
			disabled,
			"(SIOW)"
		}
	}
};

/* this ALRT and DITL are used as an error screen */

resource 'ALRT' (__rUserAlert, purgeable) {
	{40, 20, 150, 260},
	__rUserAlert,
	{ /* array: 4 elements */
		/* [1] */
		OK, visible, silent,
		/* [2] */
		OK, visible, silent,
		/* [3] */
		OK, visible, silent,
		/* [4] */
		OK, visible, silent
	}
#if SystemSevenOrLater
	, alertPositionParentWindowScreen
#endif
};


resource 'DITL' (__rUserAlert, purgeable) {
	{ /* array DITLarray: 3 elements */
		/* [1] */
		{80, 150, 100, 230},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{10, 60, 60, 230},
		StaticText {
			disabled,
			"Error. ^0."
		},
		/* [3] */
		{8, 8, 40, 40},
		Icon {
			disabled,
			2
		}
	}
};


resource 'WIND' (__rDocWindow, preload, purgeable) {
	{0, 0, WINDOW_HEIGTH, WINDOW_WIDTH},
	zoomDocProc, invisible, noGoAway, 0x0, "untitled"
	/*	The following are window positioning options ,usable in 7.0	*/
#if SystemSevenOrLater
	, noAutoCenter
#endif
};

resource 'CNTL' (__rVScroll, preload, purgeable) {
	{-1, WINDOW_WIDTH-15, WINDOW_HEIGTH-14, WINDOW_WIDTH+1},
	0, invisible, 0, 0, scrollBarProc, 0, ""
};

resource 'CNTL' (__rHScroll, preload, purgeable) {
	{WINDOW_HEIGTH-15, -1, WINDOW_HEIGTH+1, WINDOW_WIDTH-14},
	0, invisible, 0, 0, scrollBarProc, 0, ""
};

resource 'STR#' (__kErrStrings, purgeable) {
	{
	"You must run on 512Ke or later";
	"Application Memory Size is too small";
	"Not enough memory to run SIOW";
	"Not enough memory to do Cut";
	"Cannot do Cut";
	"Cannot do Copy";
	"Cannot exceed 32,000 characters with Paste";
	"Not enough memory to do Paste";
	"Cannot create window";
	"Cannot exceed 32,000 characters";
	"Cannot do Paste";
	"Font not found";
	"Cannot exceed request count during input - text truncated"
	}
};

/* here is the quintessential MultiFinder friendliness device, the SIZE resource */

resource 'SIZE' (-1) {
	dontSaveScreen,
	acceptSuspendResumeEvents,
	enableOptionSwitch,
	canBackground,				/* we can background; we don't currently, but our sleep value */
								/* guarantees we don't hog the Mac while we are in the background */
	multiFinderAware,			/* this says we do our own activate/deactivate; don't fake us out */
	backgroundAndForeground,	/* this is definitely not a background-only application! */
	dontGetFrontClicks,			/* change this is if you want "do first click" behavior like the Finder */
	ignoreChildDiedEvents,		/* essentially, I'm not a debugger (sub-launching) */
	is32BitCompatible,			/* this app should not be run in 32-bit address space */
	reserved,
	reserved,
	reserved,
	reserved,
	reserved,
	reserved,
	reserved,
	__kPrefSize * 1024,
	__kMinSize * 1024	
};


type CREATOR as 'STR ';


resource CREATOR (0) {
	"MultiFinder-Aware Simple Input/Output Window (SIOW)"
};


resource 'BNDL' (128) {
	CREATOR,
	0,
	{
		'ICN#',
		{
			0, 128
		},
		'FREF',
		{
			0, 128
		}
	}
};


resource 'FREF' (128) {
	'APPL',
	0,
	""
};


resource 'ICN#' (128) {
	{	/* array: 2 elements */
		/* [1] */
		$"0000 0000 0000 0000 0010 4100 0010 2200"
		$"0020 2200 0020 2100 0020 4100 0010 4200"
		$"0010 4200 0010 2200 0020 2100 0020 0100"
		$"00FF FF00 03FF FFE0 0791 03F0 0ED1 0E7C"
		$"1C31 321C 380D C10E 3FFF FFFE 3003 C106"
		$"380D 300E 1E31 0E3C 1FC1 01F8 07FF FFE0"
		$"00FF FE00",
		/* [2] */
		$"0000 0000 0000 0000 0010 4100 0010 2200"
		$"0020 2200 0020 2100 0020 4100 0010 4200"
		$"0010 4200 0010 2200 0020 2100 0020 0100"
		$"00FF FF00 03FF FFE0 07FF FFF0 0FFF FFFC"
		$"1FFF FFFC 3FFF FFFE 3FFF FFFE 3FFF FFFE"
		$"3FFF FFFE 1FFF FFFC 1FFF FFF8 07FF FFE0"
		$"00FF FE00"
	}
};

resource 'ALRT' (__rSaveAlert, preload) {
	{72, 64, 212, 372},
	__rSaveAlert,
	{	/* array: 4 elements */
		/* [1] */
		OK, visible, silent,
		/* [2] */
		OK, visible, silent,
		/* [3] */
		OK, visible, silent,
		/* [4] */
		OK, visible, silent
	}
	/*	The following are window positioning options ,usable in 7.0	*/
#if SystemSevenOrLater
	, alertPositionParentWindowScreen
#endif
	;
};

resource 'DITL' (__rSaveAlert, preload) {
	{	/* array DITLarray: 4 elements */
		/* [1] */
		{58, 25, 76, 99},
		Button {
			enabled,
			"Yes"
		},
		/* [2] */
		{86, 25, 104, 99},
		Button {
			enabled,
			"No"
		},
		/* [3] */
		{12, 20, 45, 277},
		StaticText {
			disabled,
			"Save changes before closing?"
		},
		/* [4] */
		{86, 195, 104, 269},
		Button {
			enabled,
			"Cancel"
		}
	}
};


// 12/13/93 - GAB: Support for native PowerPC version

#ifdef APPNAME	// only include 'cfrg' in native PowerPC apps

#include "CodeFragmentTypes.r"

resource 'cfrg' (0) {
	{
		kPowerPC,
		kFullLib,
		kNoVersionNum,kNoVersionNum,
		0,0,
		kIsApp,kOnDiskFlat,kZeroOffset,kWholeFork,
		APPNAME	// must be defined on Rez command line with -d option
	}
};

#endif
