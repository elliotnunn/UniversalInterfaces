/*
	File:		OTDebug.h

	Contains:	Macros for debugging stuff

	Copyright:	© 1994-1995 by Apple Computer, Inc., all rights reserved.

*/

#ifndef __OTDEBUG__
#define __OTDEBUG__

#ifndef SystemEightOrLater
#define SystemEightOrLater	0
#endif

#if SystemEightOrLater
	#ifndef __EXCEPTIONS__
	#include <Exceptions.h>
	#endif
#endif

#define kOTFatalErr				"FB "
#define kOTNonfatalErr			"NB "
#define kOTExtFatalErr			"FX "
#define kOTExtNonfatalErr		"NX "
#define kOTUserFatalErr			"UF "
#define kOTUserErr				"UE "
#define kOTUserNonfatalErr		"UE "
#define kOTInfoErr				"IE "
#define kOTInfoBreak			"IN "

#if qDebug || qDebug2

	#define OTDebugBreak(str)			OTDebugStr(str)
	#define OTDebugTest(val, str)		{ if ( val ) OTDebugStr(str); }
	#define OTAssert(name, cond)								\
		if ( !(cond) )											\
		{														\
			OTDebugStr(#name " - Failed assertion:" #cond);		\
		}
		
#else

	#define OTDebugBreak(str)
	#define OTDebugTest(val, str)
	#define OTAssert(name, cond)

#endif

#if qDebug > 1 || qDebug2 > 1
	#define OTDebugBreak2(str)			OTDebugStr(str)
	#define OTDebugTest2(val, str)		{ if ( val) OTDebugStr(str); }
#else
	#define OTDebugBreak2(str)
	#define OTDebugTest2(val, str)
#endif

#endif
