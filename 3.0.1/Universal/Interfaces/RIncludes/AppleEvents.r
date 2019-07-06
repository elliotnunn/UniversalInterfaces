/*
 	File:		AppleEvents.r
 
 	Contains:	AppleEvent Package Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1989-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/

#ifndef __APPLEEVENTS_R__
#define __APPLEEVENTS_R__

#ifndef __CONDITIONALMACROS_R__
#include "ConditionalMacros.r"
#endif

#ifndef __AEDATAMODEL_R__
#include "AEDataModel.r"		/* data types have moved to AEDataModel.r */
#endif

															/*  Keywords for Apple event parameters  */
#define keyDirectObject 				'----'
#define keyErrorNumber 					'errn'
#define keyErrorString 					'errs'
#define keyProcessSerialNumber 			'psn '				/*  Keywords for special handlers  */
#define keyPreDispatch 					'phac'				/*  preHandler accessor call  */
#define keySelectProc 					'selh'				/*  more selector call  */
															/*  Keyword for recording  */
#define keyAERecorderCount 				'recr'				/*  available only in vers 1.0.1 and greater  */
															/*  Keyword for version information  */
#define keyAEVersion 					'vers'				/*  available only in vers 1.0.1 and greater  */

/* Event Class */
#define kCoreEventClass 				'aevt'
/* Event ID’s */
#define kAEOpenApplication 				'oapp'
#define kAEOpenDocuments 				'odoc'
#define kAEPrintDocuments 				'pdoc'
#define kAEQuitApplication 				'quit'
#define kAEAnswer 						'ansr'
#define kAEApplicationDied 				'obit'

/* Constants for recording */
#define kAEStartRecording 				'reca'				/*  available only in vers 1.0.1 and greater  */
#define kAEStopRecording 				'recc'				/*  available only in vers 1.0.1 and greater  */
#define kAENotifyStartRecording 		'rec1'				/*  available only in vers 1.0.1 and greater  */
#define kAENotifyStopRecording 			'rec0'				/*  available only in vers 1.0.1 and greater  */
#define kAENotifyRecording 				'recr'				/*  available only in vers 1.0.1 and greater  */


/* parameter to AESend */
#define kAENeverInteract 				0x00000010			/*  server should not interact with user  */
#define kAECanInteract 					0x00000020			/*  server may try to interact with user  */
#define kAEAlwaysInteract 				0x00000030			/*  server should always interact with user where appropriate  */
#define kAECanSwitchLayer 				0x00000040			/*  interaction may switch layer  */
#define kAEDontRecord 					0x00001000			/*  don't record this event - available only in vers 1.0.1 and greater  */
#define kAEDontExecute 					0x00002000			/*  don't send the event for recording - available only in vers 1.0.1 and greater  */
#define kAEProcessNonReplyEvents 		0x00008000			/*  allow processing of non-reply events while awaiting synchronous AppleEvent reply  */

#define kAENoReply 						0x00000001			/*  sender doesn't want a reply to event  */
#define kAEQueueReply 					0x00000002			/*  sender wants a reply but won't wait  */
#define kAEWaitReply 					0x00000003			/*  sender wants a reply and will wait  */
#define kAEDontReconnect 				0x00000080			/*  don't reconnect if there is a sessClosedErr from PPCToolbox  */
#define kAEWantReceipt 					0x00000200			/*  (nReturnReceipt) sender wants a receipt of message  */


/* Constants for timeout durations */

/* priority param of AESend */
#define kAENormalPriority 				0x00000000			/*  post message at the end of the event queue  */
#define kAEHighPriority 				0x00000001			/*  post message at the front of the event queue (same as nAttnMsg)  */


#endif /* __APPLEEVENTS_R__ */

