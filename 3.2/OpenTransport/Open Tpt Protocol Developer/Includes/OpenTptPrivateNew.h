/*
	File:		OpenTptPrivateNew.h

	Contains:	Definition of "new" operator that uses the Open Transport
				OTAllocSharedClientMem and OTFreeSharedClientMem functions.

	Copyright:	© 1994-1996 by Apple Computer, Inc., all rights reserved.


*/

#ifndef __OPENTPTPRIVATENEW__
#define __OPENTPTPRIVATENEW__

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
	extern void* 	OTAllocSharedClientMem(size_t);
	extern void		OTFreeSharedClientMem(void*);
}

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif
#if GENERATING68K && defined(__MWERKS__)
#pragma pointers_in_A0
#endif

inline void* operator new(size_t size)
{
	return OTAllocSharedClientMem(size);
}

inline void* operator new(size_t size, size_t extra)
{
	return OTAllocSharedClientMem(size + extra);
}

inline void operator delete(void* theMem)
{
	OTFreeSharedClientMem(theMem);
}
	
#endif	/* __OPENTPTPRIVATENEW__ */
