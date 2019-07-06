/*
 	File:		OpenTransportProtocol.r
 
 	Contains:	Definitions likely to be used by low-level protocol stack implementation.
 
 	Version:	Technology:	2.5
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1993-1999 by Apple Computer, Inc. and Mentat Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/

#ifndef __OPENTRANSPORTPROTOCOL_R__
#define __OPENTRANSPORTPROTOCOL_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

#define kOTConfiguratorInterfaceID	kOTClientPrefix "cfigMkr"
#define kOTConfiguratorCFMTag		kOTClientPrefix "cfigMkr"
type 'otdr'
{
	unsigned integer	/* version		*/	= 0x01;
	wide array DeviceInfo
	{
		unsigned longint;		/* 'Creator' of preference file or....	*/
		pstring;				/* Name of preference file				*/
		align word;
		pstring;				/* Device abbreviation, if appropriate	*/
		align word;
		pstring;				/* Device Name							*/
		align word;
	};
};

type 'epcf'
{
	unsigned integer	/* version		*/	= 0x01;
	unsigned integer;	/* protocolType	*/
	unsigned longint;	/* upperInterface	*/
	unsigned longint;	/* lowerInterface	*/
	unsigned longint;	/* flags			*/
	unsigned longint;	/* myXTILevel		*/
	unsigned integer = $$CountOf(OptionList);	/* Resource List		*/
	wide array OptionList
	{
		unsigned longint;		/* XTI Level of Options	*/
		unsigned longint;		/* XTI Name of Options	*/
		unsigned integer;		/* minOctets			*/
		unsigned integer;		/* maxOctets			*/
		unsigned integer;		/* optionType			*/
		pstring;				/* Option Name			*/
		align word;
	};
};
/* ***** Configuration Helpers ******/

/*
   These definitions are used by device driver and port scanner
   developers to provide a library giving client-side information about
   the registered ports, such as a user-visible name or an icon.
*/

/* Configuration helper library prefix*/

/*
   This prefix is prepended to the string found in the "fResourceInfo"
   field of the OTPortRecord to build the actual library name of the
   configuration helper library.
*/

#define kPortConfigLibPrefix "OTPortCfg$"

#endif /* __OPENTRANSPORTPROTOCOL_R__ */

