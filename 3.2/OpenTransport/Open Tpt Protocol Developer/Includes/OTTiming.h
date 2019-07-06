/*
	File:		OTTiming.h

	Contains:	Macros for debugging stuff

	Copyright:	© 1994-1996 by Apple Computer, Inc., all rights reserved.

*/

#ifndef __OTTIMING__
#define __OTTIMING__

#ifndef __OTDEBUG__
#include "OTDebug.h"
#endif
#ifndef __SHAREDGLOBAL__
#include "SharedGlobal.h"
#endif

#if qDebug
#define DO_TIMING	1
#else
#define DO_TIMING	0
#endif

/*******************************************************************************
** Timing constants
********************************************************************************/
//
// Instrumentation path defines (for Maxwell)
//
#define kOTParentInstrumentationPath	"Operating System:I/O Families:"
#define kOTInstrumentationPath			"Operating System:I/O Families:Open Transport:"
#define kEthernetInstrumentationPath	kOTInstrumentationPath "Ethernet:"
#define kSerialInstrumentationPath		kOTInstrumentationPath "Serial:"

enum
{
	kOTEnterSndUData		= 0x01,
	kOTLeaveSndUData		= 0x02,
	kOTEnterRcvUData		= 0x03,
	kOTLeaveRcvUData		= 0x04,
	
	kOTEnterSnd				= 0x10,
	kOTLeaveSnd				= 0x11,
	kOTEnterRcv				= 0x12,
	kOTLeaveRcv				= 0x13,
	
	kOTEnterSndURequest		= 0x20,	
	kOTLeaveSndURequest		= 0x21,
	kOTEnterSndUReply		= 0x22,
	kOTLeaveSndUReply		= 0x23,
	kOTEnterRcvUReply		= 0x24,
	kOTLeaveRcvUReply		= 0x25,
	kOTEnterRcvURequest		= 0x26,
	kOTLeaveRcvURequest		= 0x27,
	kOTUReplyComplete		= 0x28,
	kOTDeliverReplyEvent	= 0x29,
	kOTDeliverRequestEvent	= 0x2a,
	
	kOTSchedTaskCritSection = 0x30,
	kOTEnterKernel			= 0x31,
	kOTLeaveKernel			= 0x32,
	kOTEnterKernelSignalTask= 0x33,
	kOTLeaveKernelSignalTask= 0x34,
	kOTEnterClientSignalTask= 0x35,
	kOTLeaveClientSignalTask= 0x36,
	kOTRunKernelTimers		= 0x37,
	kOTDoneKernelTimers		= 0x38,
	kOTEnterRunClientTasks	= 0x39,
	kOTLeaveRunClientTasks	= 0x3a,
	
	kOTCritWillRunTask		= 0x40,
	kOTRunImmediateTask		= 0x41,
	kOTDoDTInstall			= 0x42,
	kOTTaskWillRun			= 0x43,
	kOTTaskIsScheduled		= 0x44,
	kOTEnterRealDT			= 0x45,
	kOTLeaveRealDT			= 0x46,
	kOTEnterKernelTask		= 0x47,
	kOTLeaveKernelTask		= 0x48,
	kOTEnterRealKernelTask	= 0x49,
	kOTLeaveRealKernelTask	= 0x4a,
	
	kOTEnterADEVRcv			= 0x50,
	kOTLeaveADEVRcv			= 0x51,
	kOTEnterADEVSnd			= 0x52,
	kOTLeaveADEVSnd			= 0x53,

	kOTEnterDDPRcv			= 0x60,
	kOTLeaveDDPRcv			= 0x61,
	kOTEnterDDPSnd			= 0x62,
	kOTLeaveDDPSnd			= 0x63,
	kOTDDPEnterContSend		= 0x64,
	kOTDDPLeaveContSend		= 0x65,
	kOTDDPEnterContRcv		= 0x66,
	kOTDDPLeaveContRcv		= 0x67,

	kOTEnterATPSndReq		= 0x70,
	kOTLeaveATPSndReq		= 0x71,
	kOTEnterATPSndReply		= 0x72,
	kOTLeaveATPSndReply		= 0x73,
	kOTEnterATPRcvReq		= 0x74,
	kOTLeaveATPRcvReq		= 0x75,
	kOTEnterATPRcvReply		= 0x76,
	kOTLeaveATPRcvReply		= 0x77,
	kOTEnterATPRelease		= 0x78,
	kOTLeaveATPRelease		= 0x79,
	kOTDeliverATPRequest	= 0x7a,
	kOTDeliverATPReply		= 0x7b,
	kOTDeliverATPReplyDone	= 0x7c,
	
	kOTMaxStdEvents			= 0x0ff,
	
	/*
	 * Special, second tier events
	 */
	kOTIncPromisesEvent		= 0x1001,
	kOTDecPromisesEvent		= 0x1002,
		kOTPlaceSchedule1		= 1,
		kOTPlaceSchedule2		= 2,
		kOTPlaceSchedule3		= 3,
		kOTPlaceSchedule4		= 4,
		kOTPlaceWriteMessage	= 5,
		kOTPlaceProcessClose	= 6,
		kOTPlaceKernelDispatch	= 7,
		kOTPlaceGroupNotify		= 8,
		kOTPlaceOSRWait			= 9,
		kOTPlaceRealSWITask		= 10,
		kOTPlaceSWITask			= 11,
		kOTPlaceIdle			= 12,
	kOTRunSWITask			= 0x1003,
		kOTPlaceImplPromise		= 1,
		kOTPlaceLeaveCrit		= 2,
	kOTRunDeferredTasks		= 0x1004,
		
	/*
	 * Another second tier of events, for Open/Close endpoints & Stream
	 */
	kOTEnterStreamClose			= 0x2001,
	kOTLeaveStreamClose			= 0x2002,
	kOTEnterKernelStreamClose	= 0x2003,
	kOTLeaveKernelStreamClose	= 0x2004,
	kOTEnterStreamOpen			= 0x2005,
	kOTLeaveStreamOpen			= 0x2006,
	kOTEnterStreamOpenSpin		= 0x2007,
	kOTLeaveStreamOpenSpin		= 0x2008,
	kOTEnterILINKIOCTL			= 0x2009,
	kOTLeaveILINKIOCTL			= 0x200a,
	kOTEnterOpenEndpoint		= 0x200b,
	kOTLeaveOpenEndpoint		= 0x200c,
	kOTEnterGetEPInfo			= 0x200d,
	kOTLeaveGetEPInfo			= 0x200e,
	kOTEnterProviderClose		= 0x200f,
	kOTLeaveProviderClose		= 0x2010,
	kOTEnterProviderOpen		= 0x2011,
	kOTLeaveProviderOpen		= 0x2012,
	kOTProviderOpenComplete		= 0x2013,
	kOTEnterCreateStream		= 0x2014,
	kOTLeaveCreateStream		= 0x2015,
	kOTEnterCfigCreateStream	= 0x2016,
	kOTLeaveCfigCreateStream	= 0x2017,
	kOTStreamOpenComplete		= 0x2018,
	kOTEnterKernelStreamOpen	= 0x2019,
	kOTLeaveKernelStreamOpen	= 0x201a,
	kOTEnterIPUSHIOCTL			= 0x201b,
	kOTLeaveIPUSHIOCTL			= 0x201c,
	
	kOTEnterOSRCancel			= 0x2100,
	kOTLeaveOSRCancel			= 0x2102,
	kOTStartWaitForKernelClose	= 0x2103,
	kOTEndWaitForKernelClose	= 0x2104,
	kOTCloseNotificationDone	= 0x2105,
	kOTEnterOSRClose			= 0x2106,
	kOTLeaveOSRClose			= 0x2107,
	kOTEnterCancelSigs			= 0x2108,
	kOTLeaveCancelSigs			= 0x2109,
	kOTCloseState3				= 0x210a,
	kOTCloseState4				= 0x210b,
	kOTCloseState5				= 0x210c,
	kOTCloseState6				= 0x210d,
	kOTCloseState7				= 0x210e,
	kOTCloseState8				= 0x210f,
	kOTCloseState10				= 0x2110,
	kOTCloseState1112			= 0x2111,
	kOTRestartClose				= 0x2112,
	kOTOSRPopState0				= 0x2113,
	kOTOSRPopState2				= 0x2114,
	kOTOSRPopState2a			= 0x2115,
	kOTIPOPState0				= 0x2116,
	kOTIPOPState4				= 0x2117,
	kOTIPOPState5				= 0x2118,
	kOTIPOPState5a				= 0x2119,
	kOTIPOPState6				= 0x211a,
	kOTIPOPCleanup				= 0x211b,
	kOTIPOPLeave				= 0x211c,
	
	
	kOTEnterProcessOpen			= 0x2200,
	kOTLeaveProcessOpen			= 0x2201,
	kOTEnterOSROpen				= 0x2202,
	kOTLeaveOSROpen				= 0x2203,
	kOTOpenState0				= 0x2204,
	kOTOpenState1				= 0x2205,
	kOTOpenState2				= 0x2206,
	kOTOpenState4				= 0x2207,
	kOTOpenState5				= 0x2208,
	kOTOpenState5a				= 0x2209,
	kOTOpenState5b				= 0x220a,
	kOTOpenState5c				= 0x220b,
	kOTOpenState7				= 0x220c,
	kOTOpenState8				= 0x220d,
	kOTCleaningUpOpen		 	= 0x220e,
	kOTCallOpenFinish			= 0x220f,
	kOTDoneOpenFinish			= 0x2210,
	kOTOSRPushState0			= 0x2211,
	kOTOSRPushState1			= 0x2212,
	kOTOSRPushState6			= 0x2213,
	kOTOSRPushState8a			= 0x2214,
	kOTOSRPushState9			= 0x2215,
	kOTOSRPushState9a			= 0x2216,
	kOTOSRPushCleanup			= 0x2217
};

/*******************************************************************************
** Timing function
**
** The first parameter is the event code to log.  The 2nd 2 parameters are
** auxiliary logging values, if you want to use them.  If no one sets the 2nd
** 2 parameters to non-zero values, the log will remain using 2 longs - the
** first being a timestamp, and the second being a code.  As soon as
** someone uses non-zero values in the 2nd 2 longs, the log will begin using
** 4 longs per log entry.
********************************************************************************/

#ifdef __cplusplus
extern "C" {
#endif

void OTDoTimingLog(unsigned long, unsigned long, unsigned long);

#ifdef __cplusplus
}
#endif

#if DO_TIMING

#define OTSetEvent(code)						\
	{ if ( GetOTGlobal()->fTBSize != 0 && 		\
		   GetOTGlobal()->fLowHigh[1] != 0 )	\
		OTDoTimingLog(code, 0, 0);				\
	}

#define OTLogEvent(code, data1, data2)			\
	{ if ( GetOTGlobal()->fTBSize != 0 && 		\
		   GetOTGlobal()->fLowHigh[1] != 0 )	\
		OTDoTimingLog(code, data1, data2);		\
	}

#else

#define OTSetEvent(code)
#define OTLogEvent(code, data1, data2)

#endif


#endif
