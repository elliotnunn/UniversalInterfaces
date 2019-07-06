/*
 	File:		Components.r
 
 	Contains:	Component Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1991-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/

#ifndef __COMPONENTS_R__
#define __COMPONENTS_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

#define cmpWantsRegisterMessage 		0x80000000
#define componentDoAutoVersion 			0x01
#define componentWantsUnregister 		0x02
#define componentAutoVersionIncludeFlags  0x04
#define componentHasMultiplePlatforms 	0x08


/*----------------------------thng  • Component Manager thing ------------------------*/
/*
	thng_RezTemplateVersion:
		0 - original 'thng' template	<-- default
		1 - extended 'thng' template
*/
#ifndef thng_RezTemplateVersion
	#ifdef UseExtendedThingResource			/* grandfather in use of “UseExtendedThingResource” */
		#define thng_RezTemplateVersion 1
	#else
		#define thng_RezTemplateVersion 0
	#endif
#endif


type 'thng' {
		literal longint;										/* Type */
		literal longint;										/* Subtype */
		literal longint;										/* Manufacturer */
		unsigned hex longint; 									/* component flags */
		unsigned hex longint	kAnyComponentFlagsMask = 0;		/* component flags Mask */
		literal longint;										/* Code Type */
		integer;												/* Code ID */
		literal longint;										/* Name Type */
		integer;												/* Name ID */
		literal longint;										/* Info Type */
		integer;												/* Info ID */
		literal longint;										/* Icon Type */
		integer;												/* Icon ID */
#if thng_RezTemplateVersion == 1
		unsigned hex longint;									/* version of Component */
		longint;												/* registration flags */
		integer;												/* resource id of Icon Family */
		longint = $$CountOf(ComponentPlatformInfo);
		wide array ComponentPlatformInfo {
			unsigned hex longint; 								/* component flags */
			literal longint;									/* Code Type */
			integer;											/* Code ID */
			integer platform68k = 1, platformPowerPC = 2;		/* platform type (response from gestaltSysArchitecture) */
		};
#endif
};


/*----------------------------thn#  • Component Manager thing load order dependency ----*/
type 'thn#' {
		array {
			literal longint;										/* Code Type */
			integer;												/* Code ID */
		};
};


#endif /* __COMPONENTS_R__ */

