/*
	File:		OpenTptGlobalNew.h

	Contains:	Open Transport's GlobalNew.h function

	Copyright:	© 1994-1995 by Apple Computer, Inc., all rights reserved.


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

extern "C" 
{
	extern void* 	OTAllocMem(size_t);
	extern void		OTFreeMem(void*);
}

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
