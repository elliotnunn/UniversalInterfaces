/*
	File:		OpenTptGlobalNew.h

	Contains:	Definition of "new" operator that uses Open Transport's
				OTAllocMem and OTFreeMem functions.

	Copyright:	© 1994-1996 by Apple Computer, Inc., all rights reserved.


*/

#ifndef __OPENTPTGLOBALNEW__
#define __OPENTPTGLOBALNEW__

#ifndef SystemSevenOrLater
#define SystemSevenOrLater	1
#endif

#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif
#ifndef __STDDEF__
#include <StdDef.h>
#endif

#if GENERATING68K && defined(__MWERKS__)
#pragma pointers_in_D0
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

extern "C" 
{
	void* 	OTAllocMem(size_t);
	void	OTFreeMem(void*);
}

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif
#if GENERATING68K && defined(__MWERKS__)
#pragma pointers_in_A0
#endif

inline void* operator new(size_t size)
{
	return OTAllocMem(size);
}

inline void* operator new(size_t size, size_t extra)
{
	return OTAllocMem(size + extra);
}

inline void operator delete(void* theMem)
{
	OTFreeMem(theMem);
}
	
#endif	/* __OPENTPTGLOBALNEW__ */
