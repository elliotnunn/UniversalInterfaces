/*
	File:		OTSharedLibs.h

	Contains:	This file contains prototypes for helpful routines for loading
				shared libraries.

	Copyright:	© 1994-1997 by Apple Computer, Inc., all rights reserved.


*/

#ifndef __OTSHAREDLIBS__
#define __OTSHAREDLIBS__

#ifndef __OPENTRANSPORT__
#include <OpenTransport.h>
#endif

/*******************************************************************************
** Declarations
********************************************************************************/

typedef struct CFragInitBlock	CFragInitBlock;

typedef FSSpec 	OTFileSpec;

enum
{
	kOTGetDataSymbol	= 0,
	kOTGetCodeSymbol	= 1,
	kOTLoadNewCopy		= 2,
	kOTLoadACopy		= 4,
	kOTFindACopy		= 8,
	kOTLibMask			= kOTLoadNewCopy | kOTLoadACopy | kOTFindACopy,
	kOTLoadLibResident	= 0x20
};

/*******************************************************************************
** Some CFM Tags
********************************************************************************/

#define kOTCFMTag				'otan'

#define kOTPortScannerCFMTag				kOTKernelPrefix "pScnr"
#define kOTPseudoPortScannerCFMTag			kOTKernelPrefix "ppScnr"
#define kOTCompatPortScannerCFMTag			kOTKernelPrefix "cpScnr"
#define kOTConfiguratorCFMTag				kOTClientPrefix "cfigMkr"

/*
 * A list of these structures is returned by the OTSearchForCFMLibrary routine.
 * The list is created out of the data that is passed to the function.
 * Note that only the first 3 fields are valid when using OT 1.2 and older.
 */
 
struct CFMLibraryInfo {
	OTLink 							link;						/* To link them all up on a list					*/
	char *							libName;					/* "C" String which is fragment name				*/
	StringPtr 						intlName;					/* Pascal String which is internationalized name	*/
	OTFileSpec *					fileSpec;					/* location of fragment's file */
	StringPtr 						pstring2;					/* Secondary string from extended cfrg				*/
	StringPtr 						pstring3;					/* Extra info from extended cfrg					*/
};
typedef struct CFMLibraryInfo CFMLibraryInfo;

/*******************************************************************************
** Functions for dealing with CFM
********************************************************************************/

#ifdef __cplusplus
extern "C" {
#endif

	typedef void* 	(*OTAllocMemProcPtr)(size_t);
	typedef void 	(*OTFreeMemProcPtr)(void*);
	
	//
	// Find CFM libraries of the specified kind and type
	//
	extern OSStatus	OTFindCFMLibraries(OSType libKind, const char* type, OTList* theList, OTAllocMemProcPtr);
	//
	// Load a CFM library by name
	//
	extern OSStatus	OTLoadCFMLibrary(const char* libName, UInt32* connID, UInt32 type);
	//
	// Load a CFM library and get a named pointer from it
	//
	extern void*	OTGetCFMPointer(const char* libName, const char* entryName, UInt32* connID, UInt32 type);
	//
	// Get a named pointer from a CFM library that's already loaded
	//
	extern void*	OTGetCFMSymbol(const char* entryName, UInt32 connID, UInt32 type);
	//
	// Release a connection to a CFM library
	//
	extern void		OTReleaseCFMConnection(UInt32* connID);
	//
	// Load an ASLM library
	//
	extern OSStatus	OTLoadASLMLibrary(const char* libName);
	//
	// Unload an ASLM library
	//
	extern void		OTUnloadASLMLibrary(const char* libName);

#if !GENERATING68K
	//
	// Used in a CFM InitProc, will hold the executable code, if applicable.
	// This can also be the InitProc of the library
	//
	extern OSStatus	OTHoldThisCFMLibrary(CFragInitBlock*);
	//
	// Used in a CFM terminate proc, will unhold the executable code, if applicable.
	// This can also be the terminate proc of the library
	//
	extern void		OTUnholdThisCFMLibrary(void);
#endif
/*
 * This is an ASLM utility routine.  You can get it by including LibraryManagerUtilities.h, but since
 * we only use a few ASLM utilities, we put the prototype here for convenience.
 */
void	UnloadUnusedLibraries(void);

#ifdef __cplusplus
}
#endif

#endif
