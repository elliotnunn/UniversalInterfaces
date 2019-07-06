/*
	File:		OpenTptConfig.h

	Contains:	
	
	Copyright:	© 1995-1996 by Apple Computer, Inc., all rights reserved.


*/


#ifndef __OPENTPTCONFIG__
#define __OPENTPTCONFIG__

#ifndef __OPENTRANSPORT__
#include <OpenTransport.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#if GENERATING68K && defined(__MWERKS__)
#pragma pointers_in_D0
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#ifdef __cplusplus
extern "C" {
#endif

/*******************************************************************************
** Implementing a Config library helper
** 
** These definitions should be used by port scanner developpers to provide
** a library giving information about the ports they register
********************************************************************************/


/*	-------------------------------------------------------------------------
	Library prefix: previx prepended to the string found in "fResourceInfo"
	to build the actual library name.  Other prefixes may be defined in the
	future to identify other types of extension libraries.
	------------------------------------------------------------------------- */

	#define kPortConfigLibPrefix	"OTPortCfg$"
	
/*	-------------------------------------------------------------------------
	Library functions and IDs
	------------------------------------------------------------------------- */
	//
	// Returns the name of the port.  If includeSlot is true, the suffix "slot X"
	// should be added.  If includePort is true, " port X" should be added for
	// multiport cards.
	//
	#define kOTGetUserPortNameID	"OTGetUserPortName"
	
	typedef void (*OTGetPortNameProcPtr)(OTPortRecord*, boolean_p includeSlot,
										 boolean_p includePort, Str255 label);
										 
	//
	// Returns the location of the icon for the port.  Return false if no
	// icon is provided.
	//
	#define kOTGetPortIconID	"OTGetPortIcon"
	
	typedef struct
	{
		FSSpec	fFile;
		UInt16	fResID;
	} OTResourceLocator;
	
	typedef Boolean (*OTGetPortIconProcPtr)(OTPortRecord*, OTResourceLocator* iconLocation);

/*******************************************************************************
**	Application API
**
**	Calls that can be used by clients to get information about ports
********************************************************************************/

//	Returns a user friendly name for a port
//
void OTGetUserPortNameFromPortRef(OTPortRef ref, Str255 friendlyName);


//	Returns the location for the icon familly representing the port.
//	Returns false if the port has no icon
//
Boolean OTGetPortIconFromPortRef(OTPortRef ref, OTResourceLocator* iconLocation);

Boolean OTIsPortCompatibleWith(const OTPortRecord* port, char* protocolName);		//this line deleted for release disk
#ifdef __cplusplus
}
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if GENERATING68K && defined(__MWERKS__)
#pragma pointers_in_A0
#endif

#endif
