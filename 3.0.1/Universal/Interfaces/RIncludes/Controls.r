/*
 	File:		Controls.r
 
 	Contains:	Control Manager interfaces
 
 	Version:	Technology:	MacOS 7.x
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/

#ifndef __CONTROLS_R__
#define __CONTROLS_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

#define popupFixedWidth 				0x01
#define popupVariableWidth 				0x02
#define popupUseAddResMenu 				0x04
#define popupUseWFont 					0x08

#define popupTitleBold 					0x0100
#define popupTitleItalic 				0x0200
#define popupTitleUnderline 			0x0400
#define popupTitleOutline 				0x0800
#define popupTitleShadow 				0x1000
#define popupTitleCondense 				0x2000
#define popupTitleExtend 				0x4000
#define popupTitleNoStyle 				0x8000

#define popupTitleLeftJust 				0x00000000
#define popupTitleCenterJust 			0x00000001
#define popupTitleRightJust 			0x000000FF

#ifdef oldTemp
/*--------------------------cctb • Control Color old Lookup Table----------------------*/
	type 'cctb' {
			unsigned hex longint;									/* CCSeed				*/
			integer;												/* ccReserved			*/
			integer = $$Countof(ColorSpec) - 1;						/* ctSize				*/
			wide array ColorSpec {
					integer		cFrameColor,						/* partcode				*/
								cBodyColor,
								cTextColor,
								cElevatorColor;
					unsigned integer;								/* RGB:	red				*/
					unsigned integer;								/*		green			*/
					unsigned integer;								/*		blue			*/
			};
	};
#else
/*----------------------------cctb • Control Color Lookup Table-------------------------*/
	type 'cctb' {
			unsigned hex longint = 0;								/* CCSeed				*/
			integer = 0;											/* ccReserved			*/
			integer = $$Countof(ColorSpec) - 1;						/* ctSize				*/
			wide array ColorSpec {
					integer		cFrameColor,						/* partcode				*/
								cBodyColor,
								cTextColor,
								cElevatorColor,
								cFillPatColor,
								cArrowsLight,
								cArrowsDark,
								cThumbLight,
								cThumbDark,
								cHiliteLight,
								cHiliteDark,
								cTitleBarLight,
								cTitleBarDark,
								cTingeLight,
								cTingeDark;
					unsigned integer;								/* RGB:	red				*/
					unsigned integer;								/*		green			*/
					unsigned integer;								/*		blue			*/
			};
	};
#endif

/*----------------------------CNTL • Control Template-----------------------------------*/
type 'CNTL' {
		rect;													/* Bounds				*/
		integer;												/* Value				*/
		byte			invisible, visible; 					/* visible				*/
		fill byte;
		integer;												/* Max					*/
		integer;												/* Min					*/
		integer 		pushButProc,							/* ProcID				*/
						checkBoxProc,
						radioButProc,
						pushButProcUseWFont = 8,
						checkBoxProcUseWFont,
						radioButProcUseWFont,
						scrollBarProc = 16;
		longint;												/* RefCon				*/
		pstring;												/* Title				*/
};

#define	popupMenuCDEFproc		1008							/* ProcID 1008 = 16 * 63		*/


#endif /* __CONTROLS_R__ */

