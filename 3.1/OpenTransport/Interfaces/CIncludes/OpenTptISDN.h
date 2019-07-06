/*
	File:		OpenTptISDN.h

	Contains:	Definitions for ISDN.  This file is a first draft at definitions
				for ISDN.  ISDN modules may also want to support serial framing 
				definitions and IOCTLs for "spoofing" purposes.

	Copyright:	© 1996 by Apple Computer, Inc., all rights reserved.

*/

#ifndef __OPENTPTISDN__
#define __OPENTPTISDN__

#ifndef __OPENTPTSERIAL__
#include <OpenTptSerial.h>
#endif

/*******************************************************************************
** Module Definitions
********************************************************************************/
//
// XTI Level
//
enum
{
	COM_ISDN	= 'ISDN'
};

//
// Module Names
//
#define kISDNName		"isdn"

enum
{
	kISDNModuleID	= 7300
};
//
// ISDN framing methods, set using the I_OTSetFramingType IOCTL
//
enum
{
	kOTISDNFramingTransparentSupported	= 0x0010,	/* Support Transparent mode 		*/
	kOTISDNFramingHDLCSupported			= 0x0020,	/* Support HDLC Synchronous mode 	*/
	kOTISDNFramingV110Supported			= 0x0040,	/* Support V.110 Asynchronous mode 	*/
	kOTISDNFramingV14ESupported			= 0x0080	/* Support V.14 Asynchronous mode 	*/
};


/*******************************************************************************
** Miscellaneous equates
********************************************************************************/
/*
 * Disconnect reason codes (from Q.931)
 */
enum
{
	kOTISDNUnallocatedNumber						= 1,
	kOTISDNNoRouteToSpecifiedTransitNetwork			= 2,
	kOTISDNNoRouteToDestination						= 3,
	kOTISDNChannelUnacceptable						= 6,
    kOTISDNNormal 									= 16,
    kOTISDNUserBusy 								= 17,
    kOTISDNNoUserResponding 						= 18,
    kOTISDNNoAnswerFromUser							= 19,
    kOTISDNCallRejected 							= 21,
    kOTISDNNumberChanged 							= 22,
    kOTISDNNonSelectedUserClearing					= 26,
    kOTISDNDestinationOutOfOrder					= 27,
    kOTISDNInvalidNumberFormat						= 28,
    kOTISDNFacilityRejected							= 29,
    kOTISDNNormalUnspecified						= 31,
    kOTISDNNoCircuitChannelAvailable				= 34,
    kOTISDNNetworkOutOfOrder						= 41,
    kOTISDNSwitchingEquipmentCongestion				= 42,
    kOTISDNAccessInformationDiscarded				= 43,
    kOTISDNRequestedCircuitChannelNotAvailable		= 44,
    kOTISDNResourceUnavailableUnspecified			= 45,
	kOTISDNQualityOfServiceUnvailable				= 49,
	kOTISDNRequestedFacilityNotSubscribed			= 50,
	kOTISDNBearerCapabilityNotAuthorized			= 57,
	kOTISDNBearerCapabilityNotPresentlyAvailable	= 58,
	kOTISDNCallRestricted							= 59,
	kOTISDNServiceOrOptionNotAvilableUnspecified	= 63,
	kOTISDNBearerCapabilityNotImplemented			= 65,
	kOTISDNRequestedFacilityNotImplemented			= 69,
	kOTISDNOnlyRestrictedDigitalBearer				= 70,
	kOTISDNServiceOrOptionNotImplementedUnspecified	= 79,
	kOTISDNCallIdentityNotUsed						= 83,
	kOTISDNCallIdentityInUse						= 84,
	kOTISDNNoCallSuspended							= 85,
	kOTISDNCallIdentityCleared						= 86,
	kOTISDNIncompatibleDestination					= 88,
	kOTISDNInvalidTransitNetworkSelection			= 91,
	kOTISDNInvalidMessageUnspecified				= 95,
	kOTISDNMandatoryInformationElementIsMissing		= 96,
	kOTISDNMessageTypeNonExistentOrNotImplemented	= 97,
	kOTISDNInterworkingUnspecified					= 127
};

/*******************************************************************************
** OTISDNAddress
**
**		The OTISDNAddress has the following format:
**
**		"xxxxxx*yy"
**
**		where 'x' is the phone number and 'y' is the sub address (if available
**		in the network. The characters are coded in ASCII (IA5), and valid
**		characters are: '0'-'9','#','*'.
**		The max length of the each phone number is 21 characters (?) and the max
**		subaddress length is network dependent.
**		When using bonded channels the phone numbers are separated by '&'.
**		The X.25 user data is preceded by '@'.
********************************************************************************/

enum
{
	AF_ISDN				= 0x2000
};

enum
{
	kOTISDNMaxPhoneSize = 32,
	kOTISDNMaxSubSize = 4
};

struct OTISDNAddress
{
	OTAddressType	fAddressType;
	UInt16			fPhoneLength;
	char			fPhoneNumber[kOTISDNMaxPhoneSize+1+kOTISDNMaxSubSize];	
};
typedef struct OTISDNAddress OTISDNAddress;

/*******************************************************************************
** IOCTL Calls for ISDN
********************************************************************************/

enum
{
	MIOC_ISDN	= MIOC_SRL		/* ISDN ioctl() cmds */
};

enum
{
	/* 
	 * Send or receive an ALERTING message
	 */
	I_OTISDNAlerting = MIOC_CMD(MIOC_ISDN, 100),

	/* 
	 * Send a SUSPEND message
	 * The parameter is the Call Identity (Maximum 8 octets)
	 */
	I_OTISDNSuspend = MIOC_CMD(MIOC_ISDN, 101),

	/* 
	 * Receive a SUSPEND ACKNOWLEDGE message
	 */
	I_OTISDNSuspendAcknowledge = MIOC_CMD(MIOC_ISDN, 102),

	/* 
	 * Receive a SUSPEND REJECT message
	 */
	I_OTISDNSuspendReject = MIOC_CMD(MIOC_ISDN, 103),
	
	/* 
	 * Send a RESUME message
	 * The parameter is the Call Identity (Maximum 8 octets)
	 */
	I_OTISDNResume = MIOC_CMD(MIOC_ISDN, 104),

	/* 
	 * Receive a RESUME ACKNOWLEDGE message
	 */
	I_OTISDNResumeAcknowledge = MIOC_CMD(MIOC_ISDN, 105),

	/* 
	 * Receive a RESUME REJECT message
	 */
	I_OTISDNResumeReject = MIOC_CMD(MIOC_ISDN, 106),
	
	/* 
	 * Send or receive a FACILITY message
	 */
	I_OTISDNFaciltity = MIOC_CMD(MIOC_ISDN, 107)
	
};

/*******************************************************************************
** Connect user data size
********************************************************************************/

enum
{
	kOTISDNMaxUserDataSize = 32
};

/*******************************************************************************
** Option management calls for ISDN
********************************************************************************/

enum
{
	ISDN_OPT_COMMTYPE				= 0x0200,
		kOTISDNTelephoneALaw			= 1,				/* G.711 A-law 						*/
		kOTISDNTelephoneMuLaw			= 26,				/* G.711 µ-law 						*/
		kOTISDNDigital64k				= 13,				/* unrestricted digital (default) 	*/
		kOTISDNDigital56k				= 37,				/* user rate 56Kb/s 				*/
		kOTISDNVideo64k					= 41,				/* video terminal at 64Kb/s 		*/
		kOTISDNVideo56k					= 42,				/* video terminal at 56Kb/s 		*/
	
	ISDN_OPT_FRAMINGTYPE			= 0x0201,
		kOTISDNFramingTransparent		= 0x0010,			/* Transparent mode 				*/
		kOTISDNFramingHDLC				= 0x0020,			/* HDLC synchronous mode (default)	*/
		kOTISDNFramingV110				= 0x0040,			/* V.110 asynchronous mode 			*/
		kOTISDNFramingV14E				= 0x0080,			/* V.14E asynchronous mode			*/
	
	ISDN_OPT_56KADAPTATION			= 0x0202,
		kOTISDNNot56KAdaptation			= false,			/* not 56K Adaptation (default)		*/
		kOTISDN56KAdaptation			= true				/* 56K Adaptation					*/
};


/* Default options, you do not need to set these */
enum 
{
	kOTISDNDefaultCommType		= kOTISDNDigital64k,
	kOTISDNDefaultFramingType	= kOTISDNFramingHDLC,
	kOTISDNDefault56KAdaptation	= kOTISDNNot56KAdaptation
};

#endif
