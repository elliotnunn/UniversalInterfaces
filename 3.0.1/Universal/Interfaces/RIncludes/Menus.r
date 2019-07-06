/*
 	File:		Menus.r
 
 	Contains:	Menu Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/

#ifndef __MENUS_R__
#define __MENUS_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif


/*----------------------------MENU • Menu-----------------------------------------------*/
type 'MENU' {
		integer;												/* Menu ID				*/
		fill word[2];
		integer 		textMenuProc = 0;						/* ID of menu def proc	*/
		fill word;
		unsigned hex bitstring[31]
						allEnabled = 0x7FFFFFFF;				/* Enable flags 		*/
		boolean 		disabled, enabled;						/* Menu enable			*/
		pstring 		apple = "\0x14";						/* Menu Title			*/
		wide array {
				pstring;										/* Item title			*/
				byte			noIcon; 						/* Icon number			*/
				char			noKey = "\0x00",				/* Key equivalent or	*/
								hierarchicalMenu = "\0x1B";		/* hierarchical menu	*/
				char			noMark = "\0x00",				/* Marking char or id	*/
								check = "\0x12";				/* of hierarchical menu	*/
				fill bit;
				unsigned bitstring[7]
								plain;							/* Style				*/
		};
		byte = 0;
};
/*----------------------------MBAR • Menu Bar-------------------------------------------*/
type 'MBAR' {
		integer = $$CountOf(MenuArray); 						/* Number of menus		*/
		wide array MenuArray{
				integer;										/* Menu resource ID 	*/
		};
};
/*----------------------------mctb • Menu Color Lookup Table----------------------------*/
type 'mctb' {
		integer = $$CountOf(MCTBArray); 						/* Color table count	*/
		wide array MCTBArray {
			integer				mctbLast = -99;					/* Menu resource ID 	*/
			integer;											/* Menu Item 			*/
			wide array [4] {
					unsigned integer;							/* RGB: red				*/
					unsigned integer;							/*		green			*/
					unsigned integer;							/*		blue			*/
			};
			fill word;											/* Reserved word		*/
		};
};

#endif /* __MENUS_R__ */

