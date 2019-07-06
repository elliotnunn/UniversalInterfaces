/*
 	File:		Types.r
 
 	Contains:	Basic Macintosh data types.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/

#ifndef __TYPES_R__
#define __TYPES_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

#ifndef __SCRIPT_R__
#include "Script.r"		/* to get Region codes for 'vers' resource */
#endif

#define normal 							0
#define bold 							1
#define italic 							2
#define underline 						4
#define outline 						8
#define shadow 							0x10
#define condense 						0x20
#define extend 							0x40

															/*  Version Release Stage Codes  */
#define developStage 					0x20
#define alphaStage 						0x40
#define betaStage 						0x60
#define finalStage 						0x80

#ifndef __CONTROLS_R__
#include "Controls.r"        /* Types.r used to define 'CNTL' and 'cctb' */
#endif
#ifndef __MACWINDOWS_R__
#include "MacWindows.r"      /* Types.r used to define 'WIND' and 'wctb' */
#endif
#ifndef __DIALOGS_R__
#include "Dialogs.r"         /* Types.r used to define 'DLOG', 'ALRT', 'DITL', 'actb', and 'dctb' */
#endif
#ifndef __MENUS_R__
#include "Menus.r"           /* Types.r used to define 'MENU', 'MBAR', and 'mctb' */
#endif
#ifndef __ICONS_R__
#include "Icons.r"           /* Types.r used to define 'ICON', 'ICN#', 'SICN', 'ics#', 'icm#', 'icm8', 'icm4', 'icl8', etc. */
#endif
#ifndef __FINDER_R__
#include "Finder.r"          /* Types.r used to define 'BNDL', 'FREF', 'open', and 'kind' */
#endif
#ifndef __QUICKDRAW_R__
#include "Quickdraw.r"       /* Types.r used to define 'CURS', 'PAT', 'ppat', 'PICT', 'acur', 'clut', 'crsr', and 'PAT#' */
#endif
#ifndef __PROCESSES_R__
#include "Processes.r"       /* Types.r used to define 'SIZE' */
#endif
#ifndef __APPLEEVENTS_R__
#include "AppleEvents.r"     /* AppleEvents.r used to define 'aedt' */
#endif

/*----------------------------STR  • Pascal-Style String--------------------------------*/
type 'STR ' {
		pstring;												/* String				*/
};
/*----------------------------STR# • Pascal-Style String List---------------------------*/
type 'STR#' {
		integer = $$Countof(StringArray);
		array StringArray {
				pstring;										/* String				*/
		};
};

/*----------------------------RECT • single rectangle-----------------------------------*/
type 'RECT' { rect; };

/*----------------------------vers • Version--------------------------------------------*/
type 'vers' {
		hex byte;												/* Major revision in BCD*/
		hex byte;												/* Minor vevision in BCD*/
		hex byte	development = 0x20,							/* Release stage		*/
					alpha = 0x40,
					beta = 0x60,
					final = 0x80, /* or */ release = 0x80;
		hex byte;												/* Non-final release #	*/
		integer;												/* Region code			*/
		pstring;												/* Short version number	*/
		pstring;												/* Long version number	*/
};


#endif /* __TYPES_R__ */

