/*
 	File:		Slots.r
 
 	Contains:	Slot Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1986-1993, 1995-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/

#ifndef __SLOTS_R__
#define __SLOTS_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif


/*----------------------------pslt • Nubus psuedo-slot mapping constants------------------*/
#define	horizAscending		0			/* horizontal form factor, ascending slot order   */
#define	horizDescending		1			/* horizontal form factor, descending slot order  */
#define	vertAscending		2			/* vertical form factor, ascending slot order     */
#define	vertDescending		3			/* vertical form factor, descending slot order    */


/*----------------------------pslt • Nubus pseudo-slot mapping resource-------------------*/
type 'pslt' {
		integer = $$Countof(pSlotSpec);							/* # of slots 			  */
		integer;												/* Nubus orientation	  */
		longint;												/* psltFlags, reserved    */
		wide array pSlotSpec {
				integer;										/* Nubus slot #			  */
				integer;										/* pseudo slot #		  */
		};
};


#endif /* __SLOTS_R__ */

