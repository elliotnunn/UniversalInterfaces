{
 	File:		OpenTptAppleTalk.p
 
 	Contains:	Public AppleTalk definitions
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OpenTptAppleTalk;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTAPPLETALK__}
{$SETC __OPENTPTAPPLETALK__ := 1}

{$I+}
{$SETC OpenTptAppleTalkIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __OPENTRANSPORT__}
{$I OpenTransport.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	MixedMode.p													}
{	Strings.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	ATK_DDP						= 'DDP ';
	ATK_AARP					= 'AARP';
	ATK_ATP						= 'ATP ';
	ATK_ADSP					= 'ADSP';
	ATK_ASP						= 'ASP ';
	ATK_PAP						= 'PAP ';
	ATK_NBP						= 'NBP ';
	ATK_ZIP						= 'ZIP ';

{******************************************************************************
** Some prefixes for shared libraries
*******************************************************************************}
	kATalkVersion	=	'1.0';
	kATalkPrefix		=	'ot:atlk$';
	kATBinderID		=	'ot:atbd$';
{}
{ Module Names}
{}
	kDDPName					= 'ddp';
	kATPName					= 'atp';
	kADSPName					= 'adsp';
	kASPName					= 'asp';
	kPAPName					= 'pap';
	kNBPName					= 'nbp';
	kZIPName					= 'zip';
	kLTalkName					= 'ltlk';
	kLTalkAName					= 'ltlkA';
	kLTalkBName					= 'ltlkB';

{******************************************************************************
** Protocol-specific Options
**
** NOTE:
** All Protocols support OPT_CHECKSUM (Value is (unsigned long)T_YES/T_NO)
** ATP supports OPT_RETRYCNT (# Retries, 0 = try once) and
**				OPT_INTERVAL (# Milliseconds to wait)
*******************************************************************************}
	DDP_OPT_CHECKSUM			= OPT_CHECKSUM;
	DDP_OPT_SRCADDR				= 0x2101;
	ATP_OPT_REPLYCNT			= $2110;						{ AppleTalk - ATP Resp Pkt Ct Type			}
{ Value is (unsigned long)  pkt count		}
	ATP_OPT_DATALEN				= $2111;						{ AppleTalk - ATP Pkt Data Len Type		}
{ Value is (unsigned long) length			}
	ATP_OPT_RELTIMER			= $2112;						{ AppleTalk - ATP Release Timer Type
									 * Value is (unsigned long) timer
									 * (See Inside AppleTalk, second edition	}
	ATP_OPT_TRANID				= $2113;						{ Value is (unsigned long) Boolean			}
	PAP_OPT_OPENRETRY			= $2120;						{ AppleTalk - PAP OpenConn Retry count
									 * Value is (unsigned long) T_YES/T_NO		}

{******************************************************************************
** Protocol-specific events
*******************************************************************************}
	kAppleTalkEvent				= kPROTOCOLEVENT + $10000;
{
	 * If you send the IOCTL: OTIoctl(I_OTGetMiscellaneousEvents, 1),
	 * you will receive these events on your endpoint.
	 * NOTE: The endpoint does not need to be bound.
	 *
	 * No routers have been seen for a while.  If the cookie is NULL,
	 * all routers are gone.  Otherwise, there is still an ARA router
	 * hanging around being used, and only the local cable has been 
	 * timed out.
	 }
	T_ATALKROUTERDOWNEVENT		= kAppleTalkEvent + 51;
{
		 * This indicates that all routers are offline
		 }
	kAllATalkRoutersDown		= 0;
{
		 * This indicates that all local routers went offline, but
		 * an ARA router is still active
		 }
	kLocalATalkRoutersDown		= -1;
{
		 * This indicates that ARA was disconnected, do it's router went offline,
		 * and we have no local routers to fall back onto.
		 }
	kARARouterDisconnected		= -2;
{
	 * We didn't have a router, but now one has come up.
	 * Cookie is NULL for a normal router coming up, non-NULL
	 * for an ARA router coming on-line
	 }
	T_ATALKROUTERUPEVENT		= kAppleTalkEvent + 52;
{
		 * We had no local routers, but an ARA router is now online.
		 }
	kARARouterOnline			= -1;
{
		 * We had no routers, but a local router is now online
		 }
	kATalkRouterOnline			= 0;
{
		 * We have an ARA router, but now we've seen a local router as well
		 }
	kLocalATalkRouterOnline		= -2;
{
	 * A Zone name change was issued from the router, so our
	 * AppleTalk Zone has changed.
	 }
	T_ATALKZONENAMECHANGEDEVENT	= kAppleTalkEvent + 53;
{
	 * An ARA connection was established (cookie != NULL),
	 * or was disconnected (cookie == NULL)
	 }
	T_ATALKCONNECTIVITYCHANGEDEVENT = kAppleTalkEvent + 54;
{
	 * A router has appeared, and our address is in the startup
	 * range.  Cookie is hi/lo of new cable range.
	 }
	T_ATALKINTERNETAVAILABLEEVENT = kAppleTalkEvent + 55;
{
	 * A router has appeared, and it's incompatible withour
	 * current address.  Cookie is hi/lo of new cable range.
	 }
	T_ATALKCABLERANGECHANGEDEVENT = kAppleTalkEvent + 56;

{	-------------------------------------------------------------------------
		ECHO
		------------------------------------------------------------------------- }
	kECHO_TSDU					= 585;							{ Max. # of data bytes.}
{	-------------------------------------------------------------------------
		NBP
		------------------------------------------------------------------------- }
	kNBPMaxNameLength			= 32;
	kNBPMaxTypeLength			= 32;
	kNBPMaxZoneLength			= 32;
	kNBPSlushLength				= 9;							{ Extra space for @, : and a few escape chars}
	kNBPMaxEntityLength			= 0+(kNBPMaxNameLength + kNBPMaxTypeLength + kNBPMaxZoneLength + 3);
	kNBPEntityBufferSize		= 0+(kNBPMaxNameLength + kNBPMaxTypeLength + kNBPMaxZoneLength + kNBPSlushLength);
	kNBPWildCard				= $3D;							{ NBP name and type match anything '='}
	kNBPImbeddedWildCard		= $C5;							{ NBP name and type match some '≈'}
	kNBPDefaultZone				= $2A;							{ NBP default zone '*'}
{	-------------------------------------------------------------------------
		ZIP
		------------------------------------------------------------------------- }
	kZIPMaxZoneLength			= kNBPMaxZoneLength;
{	-------------------------------------------------------------------------
		Address-related values
		------------------------------------------------------------------------- }
	kDDPAddressLength			= 8;							{ value to use in netbuf.len field}
{ Maximum length of AppleTalk address}
	kNBPAddressLength			= kNBPEntityBufferSize;
	kAppleTalkAddressLength		= kDDPAddressLength + kNBPEntityBufferSize;

{******************************************************************************
** CLASS TAppleTalkServices
*******************************************************************************}
{$IFC NOT OTKERNEL }
{$IFC UNDEFINED __cplusplus }
	
TYPE
	ATSvcRef = Ptr;

{$ELSEC}

TYPE
	TAppleTalkServices = RECORD
	END;

	ATSvcRef = ^TAppleTalkServices;

{$ENDC}
{$SETC kDefaultAppleTalkServicesPath := (-3)}

FUNCTION OTAsyncOpenAppleTalkServices(VAR cfig: OTConfiguration; flags: OTOpenFlags; notifyProc: OTNotifyProcPtr; contextPtr: UNIV Ptr): OSStatus;
FUNCTION OTOpenAppleTalkServices(VAR cfig: OTConfiguration; flags: OTOpenFlags; VAR err: OSStatus): ATSvcRef;
{}
{ Get the zone associated with the ATSvcRef}
{}
FUNCTION OTATalkGetMyZone(ref: ATSvcRef; VAR zone: TNetbuf): OSStatus;
{}
{ Get the list of available zones associated with the local cable}
{ of the ATSvcRef}
{}
FUNCTION OTATalkGetLocalZones(ref: ATSvcRef; VAR zones: TNetbuf): OSStatus;
{}
{ Get the list of all zones on the internet specified by the ATSvcRef}
{}
FUNCTION OTATalkGetZoneList(ref: ATSvcRef; VAR zones: TNetbuf): OSStatus;
{}
{ Stores an AppleTalkInfo structure into the TNetbuf (see later in this file)}
{}
FUNCTION OTATalkGetInfo(ref: ATSvcRef; VAR info: TNetbuf): OSStatus;
{$ENDC}

TYPE
	DDPAddress = RECORD
		fAddressType:			OTAddressType;
		fNetwork:				UInt16;
		fNodeID:				SInt8; (* UInt8 *)
		fSocket:				SInt8; (* UInt8 *)
		fDDPType:				SInt8; (* UInt8 *)
		fPad:					SInt8; (* UInt8 *)
	END;

	NBPAddress = RECORD
		fAddressType:			OTAddressType;
		fNBPNameBuffer:			ARRAY [0..kNBPEntityBufferSize-1] OF SInt8; (* UInt8 *)
	END;

	DDPNBPAddress = RECORD
		fAddressType:			OTAddressType;
		fNetwork:				UInt16;
		fNodeID:				SInt8; (* UInt8 *)
		fSocket:				SInt8; (* UInt8 *)
		fDDPType:				SInt8; (* UInt8 *)
		fPad:					SInt8; (* UInt8 *)
		fNBPNameBuffer:			ARRAY [0..kNBPEntityBufferSize-1] OF SInt8; (* UInt8 *)
	END;

	NBPEntity = RECORD
		fEntity:				ARRAY [0..kNBPMaxEntityLength-1] OF SInt8; (* UInt8 *)
	END;

{	---------------------------------------------------------------------
		These are some utility routines for dealing with NBP and DDP addresses. 
		--------------------------------------------------------------------- }
{}
{ Functions to initialize the various AppleTalk Address types}
{}

PROCEDURE OTInitDDPAddress(VAR addr: DDPAddress; net: UInt16; node: ByteParameter; socket: ByteParameter; ddpType: ByteParameter);
FUNCTION OTInitNBPAddress(VAR addr: NBPAddress; name: ConstCStringPtr): size_t;
FUNCTION OTInitDDPNBPAddress(VAR addr: DDPNBPAddress; name: ConstCStringPtr; net: UInt16; node: ByteParameter; socket: ByteParameter; ddpType: ByteParameter): size_t;
{}
{ Compare 2 DDP addresses for equality}
{}
FUNCTION OTCompareDDPAddresses({CONST}VAR addr1: DDPAddress; {CONST}VAR addr2: DDPAddress): BOOLEAN;
{}
{ Init an NBPEntity to a NULL name}
{}
PROCEDURE OTInitNBPEntity(VAR entity: NBPEntity);
{}
{ Get the length an NBPEntity would have when stored as an address}
{ }
FUNCTION OTGetNBPEntityLengthAsAddress({CONST}VAR entity: NBPEntity): size_t;
{}
{ Store an NBPEntity into an address buffer}
{}
FUNCTION OTSetAddressFromNBPEntity(VAR nameBuf: UInt8; {CONST}VAR entity: NBPEntity): size_t;
{}
{ Create an address buffer from a string (use -1 for len to use strlen)}
{}
FUNCTION OTSetAddressFromNBPString(VAR addrBuf: UInt8; name: ConstCStringPtr; len: SInt32): size_t;
{}
{ Create an NBPEntity from an address buffer. False is returned if}
{   the address was truncated.}
{}
FUNCTION OTSetNBPEntityFromAddress(VAR entity: NBPEntity; {CONST}VAR addrBuf: UInt8; len: size_t): BOOLEAN;
{}
{ Routines to set a piece of an NBP entity from a character string}
{}
FUNCTION OTSetNBPName(VAR entity: NBPEntity; name: ConstCStringPtr): BOOLEAN;
FUNCTION OTSetNBPType(VAR entity: NBPEntity; typeVal: ConstCStringPtr): BOOLEAN;
FUNCTION OTSetNBPZone(VAR entity: NBPEntity; zone: ConstCStringPtr): BOOLEAN;
{}
{ Routines to extract pieces of an NBP entity}
{}
PROCEDURE OTExtractNBPName({CONST}VAR entity: NBPEntity; name: CStringPtr);
PROCEDURE OTExtractNBPType({CONST}VAR entity: NBPEntity; typeVal: CStringPtr);
PROCEDURE OTExtractNBPZone({CONST}VAR entity: NBPEntity; zone: CStringPtr);

CONST
	AF_ATALK_FAMILY				= $0100;
	AF_ATALK_DDP				= AF_ATALK_FAMILY;
	AF_ATALK_DDPNBP				= AF_ATALK_FAMILY + 1;
	AF_ATALK_NBP				= AF_ATALK_FAMILY + 2;
	AF_ATALK_MNODE				= AF_ATALK_FAMILY + 3;

{	-------------------------------------------------------------------------
		AppleTalkInfo - filled out by the OTGetATalkInfo function
	------------------------------------------------------------------------- }

TYPE
	AppleTalkInfo = RECORD
		fOurAddress:			DDPAddress;								{ Our DDP address (network # & node)}
		fRouterAddress:			DDPAddress;								{ The address of a router on our cable}
		fCableRange:			ARRAY [0..1] OF UInt16;					{ The current cable range}
		fFlags:					UInt16;									{ See below}
	END;

{}
{ For the fFlags field in AppleTalkInfo}
{}

CONST
	kATalkInfoIsExtended		= $0001;						{ This is an extended (phase 2) network}
	kATalkInfoHasRouter			= $0002;						{ This cable has a router}
	kATalkInfoOneZone			= $0004;						{ This cable has only one zone}


{$SETC UsingIncludes := OpenTptAppleTalkIncludes}

{$ENDC} {__OPENTPTAPPLETALK__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
