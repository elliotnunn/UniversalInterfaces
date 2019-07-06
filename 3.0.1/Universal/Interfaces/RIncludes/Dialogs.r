/*
 	File:		Dialogs.r
 
 	Contains:	Dialog Manager interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/

#ifndef __DIALOGS_R__
#define __DIALOGS_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

#ifndef __MACWINDOWS_R__
#include "MacWindows.r"		/* for 'wctb' */
#endif


/*----------------------------wctb • Alert Color Lookup Table--------------------------*/
type 'actb' as 'wctb';


/*----------------------------ALRT • Alert Template-------------------------------------*/
/*
	ALRT_RezTemplateVersion:
		0 - original 							<-- default
		1 - additional positioning info at end	
*/
#ifndef ALRT_RezTemplateVersion
	#ifdef SystemSevenOrLater					/* grandfather in use of “SystemSevenOrLater” */
		#define ALRT_RezTemplateVersion 1
	#else
		#define ALRT_RezTemplateVersion 0
	#endif
#endif


type 'ALRT' {
		rect;													/* boundsRect			*/
		integer;												/* 'DITL' ID			*/

		/* NOTE: the stages are ordered 4, 3, 2, 1 */
		wide array [4] {
				boolean 				OK, Cancel; 			/* Bold Outline 		*/
				boolean 				invisible, visible; 	/* Draw Alert			*/
				unsigned bitstring[2]	silent = 0
								sound1, sound2, sound3; 		/* Beeps				*/
		};

#if ALRT_RezTemplateVersion == 1
	/*	The following are alert positioning options used by System 7.0 and later */
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

/* stages for ALRT */
#define silentStage OK, visible, silent
#define silentStages { silentStage; silentStage; silentStage; silentStage; }

#define beepStage OK, visible, sound1
#define beepStages { beepStage; beepStage; beepStage; beepStage; }


/*----------------------------dctb • Dialog Color Lookup Table--------------------------*/
type 'dctb' as 'wctb';


/*----------------------------DITL • Dialog Item List-----------------------------------*/
type 'DITL' {
		integer = $$CountOf(DITLarray) - 1; 					/* Array size			*/
		wide array DITLarray {
				fill long;
				rect;											/* Item bounds			*/
				switch {

				case HelpItem:									/* Help Mgr type item */
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 1;					/* this is a new type = 1 */

						switch {
							case HMScanhdlg:
								byte = 4;						/* sizeola				*/
								key int = 1;					/* key value 			*/
								integer;						/* resource ID			*/

							case HMScanhrct:
								byte = 4;						/* sizeola				*/
								key int = 2;					/* key value 			*/
								integer;						/* resource ID			*/

							case HMScanAppendhdlg:
								byte = 6;						/* sizeola				*/
								key int = 8;					/* key value 			*/
								integer;						/* resource ID			*/
								integer;						/* offset (zero based)	*/
						};


				case Button:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 4;
						pstring;								/* Title				*/

				case CheckBox:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 5;
						pstring;								/* Title				*/

				case RadioButton:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 6;
						pstring;								/* Title				*/

				case Control:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 7;
						byte = 2;
						integer;								/* 'CTRL' ID			*/

				case StaticText:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 8;
						pstring;								/* Text 				*/

				case EditText:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 16;
						pstring;								/* Text 				*/

				case Icon:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 32;
						byte = 2;
						integer;								/* 'ICON' ID			*/

				case Picture:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 64;
						byte = 2;
						integer;								/* 'PICT' ID			*/

				case UserItem:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 0;
						byte = 0;
				};
				align word;
		};
};


/*----------------------------DLOG • Dialog Template------------------------------------*/
/*
	DLOG_RezTemplateVersion:
		0 - original 							<-- default
		1 - additional positioning info at end	
*/
#ifndef DLOG_RezTemplateVersion
	#ifdef SystemSevenOrLater					/* grandfather in use of “SystemSevenOrLater” */
		#define DLOG_RezTemplateVersion 1
	#else
		#define DLOG_RezTemplateVersion 0
	#endif
#endif


type 'DLOG' {
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
		integer;												/* 'DITL' ID			*/
		pstring;												/* title				*/
#if DLOG_RezTemplateVersion == 1
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


#endif /* __DIALOGS_R__ */

