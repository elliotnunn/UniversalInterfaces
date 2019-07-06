{
 	File:		OpenTptInternet.p
 
 	Contains:	Public TCP/IP definitions
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OpenTptInternet;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTINTERNET__}
{$SETC __OPENTPTINTERNET__ := 1}

{$I+}
{$SETC OpenTptInternetIncludes := UsingIncludes}
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
	
TYPE
	InetPort = UInt16;

	InetHost = UInt32;

{}
{	Enums used as address type designations.}
{}

CONST
	AF_INET						= 2;							{ Traditonal}
	AF_DNS						= 42;							{ Obviously, the answer to...}

{}
{	Enum which can be used to bind to all IP interfaces}
{	rather than a specific one.}
{}
	kOTAnyInetAddress			= 0;							{ Wildcard}

	
TYPE
	InetSvcRef = Ptr;

{******************************************************************************
** XTI Options
*******************************************************************************}
{ Protocol levels}

CONST
	INET_IP						= $0;
	INET_TCP					= $06;
	INET_UDP					= $11;

{******************************************************************************
** Some prefixes for shared libraries
*******************************************************************************}
	kDNRName		=	'dnr';
	kTCPName		=	'tcp';
	kUDPName		=	'udp';
	kRawIPName	=	'rawip';
{ TCP Level Options}
	TCP_NODELAY					= $01;
	TCP_MAXSEG					= $02;
	TCP_NOTIFY_THRESHOLD		= $10;							{* not a real XTI option }
	TCP_ABORT_THRESHOLD			= $11;							{* not a real XTI option }
	TCP_CONN_NOTIFY_THRESHOLD	= $12;							{* not a real XTI option }
	TCP_CONN_ABORT_THRESHOLD	= $13;							{* not a real XTI option }
	TCP_OOBINLINE				= $14;							{* not a real XTI option }
	TCP_URGENT_PTR_TYPE			= $15;							{* not a real XTI option }
	TCP_KEEPALIVE				= $08;							{ keepalive defined in OpenTransport.h }
	T_GARBAGE					= 2;

{ UDP Level Options}
	UDP_CHECKSUM				= $600;
	UDP_RX_ICMP					= $2;

{ IP Level Options}
	IP_OPTIONS					= $01;
	IP_TOS						= $02;
	IP_TTL						= $03;
	IP_REUSEADDR				= $04;
	IP_DONTROUTE				= $10;
	IP_BROADCAST				= $20;
	IP_HDRINCL					= $1002;
	IP_RCVOPTS					= $1005;
	IP_RCVDSTADDR				= $1007;
	IP_MULTICAST_IF				= $1010;						{ set/get IP multicast interface	}
	IP_MULTICAST_TTL			= $1011;						{ set/get IP multicast timetolive	}
	IP_MULTICAST_LOOP			= $1012;						{ set/get IP multicast loopback	}
	IP_ADD_MEMBERSHIP			= $1013;						{ add an IP group membership		}
	IP_DROP_MEMBERSHIP			= $1014;						{ drop an IP group membership		}
	IP_BROADCAST_IF				= $1015;						{ Set interface for broadcasts 	}
	IP_RCVIFADDR				= $1016;						{ Set interface for broadcasts 	}

{	DVMRP-specific setsockopt commands, from ip_mroute.h}
	DVMRP_INIT					= $64;
	DVMRP_DONE					= $65;
	DVMRP_ADD_VIF				= $66;
	DVMRP_DEL_VIF				= $67;
	DVMRP_ADD_LGRP				= $68;
	DVMRP_DEL_LGRP				= $69;
	DVMRP_ADD_MRT				= $6A;
	DVMRP_DEL_MRT				= $6B;

{ IP_TOS precdence levels}
	T_ROUTINE					= 0;
	T_PRIORITY					= 1;
	T_IMMEDIATE					= 2;
	T_FLASH						= 3;
	T_OVERRIDEFLASH				= 4;
	T_CRITIC_ECP				= 5;
	T_INETCONTROL				= 6;
	T_NETCONTROL				= 7;

{	IP_TOS type of service}
	T_NOTOS						= $0;
	T_LDELAY					= 0+(1 * (2**(4)));
	T_HITHRPT					= 0+(1 * (2**(3)));
	T_HIREL						= 0+(1 * (2**(2)));

{ IP Multicast option structures}

TYPE
	TIPAddMulticast = RECORD
		multicastGroupAddress:	InetHost;
		interfaceAddress:		InetHost;
	END;

{******************************************************************************
** Protocol-specific events
*******************************************************************************}

CONST
	T_DNRSTRINGTOADDRCOMPLETE	= kPRIVATEEVENT + 1;
	T_DNRADDRTONAMECOMPLETE		= kPRIVATEEVENT + 2;
	T_DNRSYSINFOCOMPLETE		= kPRIVATEEVENT + 3;
	T_DNRMAILEXCHANGECOMPLETE	= kPRIVATEEVENT + 4;
	T_DNRQUERYCOMPLETE			= kPRIVATEEVENT + 5;

{******************************************************************************
** InetAddress
*******************************************************************************}

TYPE
	InetAddress = RECORD
		fAddressType:			OTAddressType;							{ always AF_INET}
		fPort:					InetPort;								{ Port number }
		fHost:					InetHost;								{ Host address in net byte order}
		fUnused:				PACKED ARRAY [0..7] OF SInt8; (* UInt8 *)		{ Traditional unused bytes}
	END;

{******************************************************************************
** Domain Name Resolver (DNR) 
*******************************************************************************}

CONST
	kMaxHostAddrs				= 10;
	kMaxSysStringLen			= 32;
	kMaxHostNameLen				= 255;

	
TYPE
	InetDomainName = PACKED ARRAY [0..kMaxHostNameLen + 1-1] OF CHAR;

	InetHostInfo = RECORD
		name:					InetDomainName;
		addrs:					ARRAY [0..kMaxHostAddrs-1] OF InetHost;
	END;

	InetSysInfo = RECORD
		cpuType:				PACKED ARRAY [0..kMaxSysStringLen-1] OF CHAR;
		osType:					PACKED ARRAY [0..kMaxSysStringLen-1] OF CHAR;
	END;

	InetMailExchange = RECORD
		preference:				UInt16;
		exchange:				InetDomainName;
	END;

	InetMailExchangePtr = ^InetMailExchange;

	DNSQueryInfo = RECORD
		qType:					UInt16;
		qClass:					UInt16;
		ttl:					UInt32;
		name:					InetDomainName;
		responseType:			UInt16;									{ answer, authority, or additional}
		resourceLen:			UInt16;									{ actual length of array which follows}
		resourceData:			PACKED ARRAY [0..3] OF CHAR;			{ size varies}
	END;

{******************************************************************************
** DNSAddress
**
**		The DNSAddress format is optional and may be used in connects,
**		datagram sends, and resolve address calls.   The name takes the 
**		format "somewhere.com" or "somewhere.com:portnumber" where
**		the ":portnumber" is optional.   The length of this structure
**		is arbitrarily limited to the overall max length of a domain
**		name (255 chars), although a longer one can be use successfully
**		if you use this as a template for doing so.   However, the domain name 
**		is still limited to 255 characters.
*******************************************************************************}
	DNSAddress = RECORD
		fAddressType:			OTAddressType;							{ always AF_DNS}
		fName:					InetDomainName;
	END;

{******************************************************************************
** InetInterfaceInfo
*******************************************************************************}
	InetInterfaceInfo = RECORD
		fAddress:				InetHost;
		fNetmask:				InetHost;
		fBroadcastAddr:			InetHost;
		fDefaultGatewayAddr:	InetHost;
		fDNSAddr:				InetHost;
		fVersion:				UInt16;
		fHWAddrLen:				UInt16;
		fHWAddr:				^UInt8;
		fIfMTU:					UInt32;
		fReservedPtrs:			ARRAY [0..1] OF ^UInt8;
		fDomainName:			InetDomainName;
		fReserved:				PACKED ARRAY [0..255] OF SInt8; (* UInt8 *)
	END;

{******************************************************************************
** Static helper functions
*******************************************************************************}

PROCEDURE OTInitInetAddress(VAR addr: InetAddress; port: InetPort; host: InetHost);
FUNCTION OTInitDNSAddress(VAR addr: DNSAddress; str: CStringPtr): size_t;
FUNCTION OTInetStringToHost(str: CStringPtr; VAR host: InetHost): OSStatus;
PROCEDURE OTInetHostToString(host: InetHost; str: CStringPtr);
FUNCTION OTInetGetInterfaceInfo(VAR info: InetInterfaceInfo; val: SInt32): OSStatus;
{******************************************************************************
** InetServices & DNR calls
*******************************************************************************}

CONST
	kDefaultInternetServicesPath = -3;

{$IFC NOT OTKERNEL }

FUNCTION OTOpenInternetServices(cfig: OTConfigurationPtr; oflag: OTOpenFlags; VAR err: OSStatus): InetSvcRef;
FUNCTION OTAsyncOpenInternetServices(cfig: OTConfigurationPtr; oflag: OTOpenFlags; proc: OTNotifyProcPtr; contextPtr: UNIV Ptr): OSStatus;
FUNCTION OTInetStringToAddress(ref: InetSvcRef; name: CStringPtr; VAR hinfo: InetHostInfo): OSStatus;
FUNCTION OTInetAddressToName(ref: InetSvcRef; addr: InetHost; VAR name: InetDomainName): OSStatus;
FUNCTION OTInetSysInfo(ref: InetSvcRef; name: CStringPtr; VAR sysinfo: InetSysInfo): OSStatus;
FUNCTION OTInetMailExchange(ref: InetSvcRef; name: CStringPtr; VAR num: UInt16; mx: InetMailExchangePtr): OSStatus;
FUNCTION OTInetQuery(ref: InetSvcRef; name: CStringPtr; qClass: UInt16; qType: UInt16; buf: CStringPtr; buflen: size_t; argv: UNIV Ptr; argvlen: size_t; flags: OTFlags): OSStatus;

CONST
	kDefaultInetInterface		= -1;
	kInetInterfaceInfoVersion	= 2;

{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OpenTptInternetIncludes}

{$ENDC} {__OPENTPTINTERNET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
