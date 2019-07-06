/*
 	File:		MacWindows.r
 
 	Contains:	Window Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/

#ifndef __MACWINDOWS_R__
#define __MACWINDOWS_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif


/*--------------------------wctb • Window Color Lookup Table--------------------------*/
/*
	wctb_RezTemplateVersion:
		0 - original 
		1 - more color parts and implicit header	<-- default
		2 - addition index table at end
*/
#ifndef wctb_RezTemplateVersion
	#ifdef oldTemp							/* grandfather in use of “oldTemp” */
		#define wctb_RezTemplateVersion 0
	#elif defined(evenNewerTemp)			/* grandfather in use of “evenNewerTemp” */
		#define wctb_RezTemplateVersion 2
	#else
		#define wctb_RezTemplateVersion 1
	#endif
#endif


type 'wctb' {
#if wctb_RezTemplateVersion == 0
			unsigned hex longint;									/* ctSeed				*/
			integer;												/* ctFlags				*/
#elif wctb_RezTemplateVersion == 1
			unsigned hex longint = 0;								/* ctSeed				*/
			integer = 0;											/* ctFlags				*/
#elif wctb_RezTemplateVersion == 2
			unsigned hex longint = 0;								/* ctSeed				*/
			integer = 1;											/* ctFlags				*/
#endif
			integer = $$Countof(ColorSpec) - 1;						/* ctSize				*/
			wide array ColorSpec {
					integer		wContentColor,						/* value				*/
								wFrameColor,
								wTextColor,
								wHiliteColor,
								wTitleBarColor,
								wHiliteLight,
								wHiliteDark,
								wTitleBarLight,
								wTitleBarDark,
								wDialogLight,
								wDialogDark,
								wTingeLight,
								wTingeDark;
					unsigned integer;								/* RGB:	red				*/
					unsigned integer;								/*		green			*/
					unsigned integer;								/*		blue			*/
			};
#if wctb_RezTemplateVersion == 2
			integer = $$Countof(IndexTable) - 1;					/* indexTableSize		*/
			array IndexTable {
					integer		wActiveContentIndex,				/* indexTable			*/
								wActiveFrameIndex,
								wActiveTitleTextIndex,
								wActiveTitleBarIndex,
								wActiveGrowBorderIndex,
								wActiveTitleBarLightTingeIndex,
								wActiveTitleBarDarkTingeIndex,
								wActiveModalLightTingeIndex,
								wActiveModalDarkTingeIndex,
								wActiveModalCornerTingeIndex,
								wRacingStripesIndex,
								wInactiveContentIndex,
								wInactiveFrameIndex,
								wInactiveTitleTextIndex,
								wInactiveTitleBarIndex,
								wInactiveGrowBorderIndex,
								wInactiveTitleBarLightTingeIndex,
								wInactiveTitleBarDarkTingeIndex,
								wInactiveModalLightTingeIndex,
								wInactiveModalDarkTingeIndex,
								wInactiveModalCornerTingeIndex;
			};
#endif
	};


/*----------------------------WIND • Window Template------------------------------------*/
/*
	WIND_RezTemplateVersion:
		0 - original 							<-- default
		1 - additional positioning info at end	
*/
#ifndef WIND_RezTemplateVersion
	#ifdef SystemSevenOrLater					/* grandfather in use of “SystemSevenOrLater” */
		#define WIND_RezTemplateVersion 1
	#else
		#define WIND_RezTemplateVersion 0
	#endif
#endif


type 'WIND' {
		rect;													/* boundsRect			*/
		integer 		documentProc,							/* procID				*/
						dBoxProc,
						plainDBox,
						altDBoxProc,
						noGrowDocProc,
						movableDBoxProc,
						zoomDocProc = 8,
						zoomNoGrow = 12,
						rDocProc = 16;
		byte			invisible, visible; 					/* visible				*/
		fill byte;
		byte			noGoAway, goAway;						/* goAway				*/
		fill byte;
		unsigned hex longint;									/* refCon				*/
		pstring 		Untitled = "Untitled";				/* title				*/
		
#if WIND_RezTemplateVersion == 1
	/*	The following are window positioning options used by System 7.0 and later */
		align word;
		unsigned integer				noAutoCenter = 0x0000,
										centerMainScreen = 0x280a,
										alertPositionMainScreen = 0x300a,
										staggerMainScreen = 0x380a,
										centerParentWindow = 0xa80a,
										alertPositionParentWindow = 0xb00a,
										staggerParentWindow = 0xb80a,
										centerParentWindowScreen = 0x680a,
										alertPositionParentWindowScreen = 0x700a,
										staggerParentWindowScreen = 0x780a;
#endif
};


#endif /* __MACWINDOWS_R__ */

