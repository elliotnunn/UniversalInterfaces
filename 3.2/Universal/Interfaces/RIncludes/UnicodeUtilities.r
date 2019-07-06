/*
 	File:		UnicodeUtilities.r
 
 	Contains:	Types, constants, prototypes for Unicode Utilities (Unicode input and text utils)
 
 	Version:	Technology:	Allegro
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1997-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/

#ifndef __UNICODEUTILITIES_R__
#define __UNICODEUTILITIES_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

#define kUCKeyOutputStateIndexMask 		0x4000
#define kUCKeyOutputSequenceIndexMask 	0x8000
#define kUCKeyOutputTestForIndexMask 	0xC000				/*  test bits 14-15 */
#define kUCKeyOutputGetIndexMask 		0x3FFF				/*  get bits 0-13 */

#define kUCKeyStateEntryTerminalFormat 	0x0001
#define kUCKeyStateEntryRangeFormat 	0x0002

#define kUCKeyLayoutHeaderFormat 		0x1002
#define kUCKeyLayoutFeatureInfoFormat 	0x2001
#define kUCKeyModifiersToTableNumFormat  0x3001
#define kUCKeyToCharTableIndexFormat 	0x4001
#define kUCKeyStateRecordsIndexFormat 	0x5001
#define kUCKeyStateTerminatorsFormat 	0x6001
#define kUCKeySequenceDataIndexFormat 	0x7001

#define kUCKeyActionDown 				0					/*  key is going down */
#define kUCKeyActionUp 					1					/*  key is going up */
#define kUCKeyActionAutoKey 			2					/*  auto-key down */
#define kUCKeyActionDisplay 			3					/*  get information for key display (as in Key Caps)			 */

#define kUCKeyTranslateNoDeadKeysBit 	0					/*  Prevents setting any new dead-key states */
#define kUCKeyTranslateNoDeadKeysMask 	0x00000001

#endif /* __UNICODEUTILITIES_R__ */

