{
 	File:		OpenTptLinks.p
 
 	Contains:	Definitions for link modules
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OpenTptLinks;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTLINKS__}
{$SETC __OPENTPTLINKS__ := 1}

{$I+}
{$SETC OpenTptLinksIncludes := UsingIncludes}
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
{$SETC kPortBaseResID := 1000}

CONST
	kOTADEVDevice				= 1;							{ An Atalk ADEV		}
	kOTMDEVDevice				= 2;							{ A TCP/IP MDEV		}
	kOTLocalTalkDevice			= 3;							{ LocalTalk			}
	kOTIRTalkDevice				= 4;							{ IRTalk				}
	kOTTokenRingDevice			= 5;							{ Token Ring			}
	kOTISDNDevice				= 6;							{ ISDN					}
	kOTATMDevice				= 7;							{ ATM					}
	kOTSMDSDevice				= 8;							{ SMDS					}
	kOTSerialDevice				= 9;							{ Serial 				}
	kOTEthernetDevice			= 10;							{ Ethernet				}
	kOTSLIPDevice				= 11;							{ SLIP Pseudo-device	}
	kOTPPPDevice				= 12;							{ PPP Pseudo-device	}
	kOTModemDevice				= 13;							{ Modem Pseudo-Device	}
	kOTFastEthernetDevice		= 14;							{ 100 MB Ethernet		}
	kOTFDDIDevice				= 15;							{ FDDI					}
	kOTATMLANEDevice			= 16;							{ ATM LAN emulation	}
	kOTATMSNAPDevice			= 17;							{ ATM SNAP emulation	}

{******************************************************************************
** Interface option flags
*******************************************************************************}
{}
{ Ethernet framing options}
{}
	kOTFramingEthernet			= $01;
	kOTFramingEthernetIPX		= $02;
	kOTFraming8023				= $04;
	kOTFraming8022				= $08;

{}
{ Raw mode options}
{}
	kOTRawRcvOn					= 0;
	kOTRawRcvOff				= 1;
	kOTRawRcvOnWithTimeStamp	= 2;

{}
{ OPT_SETPROMISCUOUS value}
{}
	DL_PROMISC_OFF				= 0;

{******************************************************************************
** Module definitions
*******************************************************************************}
{}
{ XTI Levels}
{}
	LNK_ENET					= 'ENET';
	LNK_TOKN					= 'TOKN';
	LNK_FDDI					= 'FDDI';
	LNK_TPI						= 'LTPI';

{}
{ Module IDs}
{}
	kT8022ModuleID				= 7100;
	kEnetModuleID				= 7101;
	kTokenRingModuleID			= 7102;
	kFDDIModuleID				= 7103;

{}
{ Module Names}
{}
	kEnet8022Name				= 'enet8022x';
	kEnetName					= 'enet';
	kFastEnetName				= 'fenet';
	kTokenRingName				= 'tokn';
	kFDDIName					= 'fddi';
	kIRTalkName					= 'irtlk';
	kSMDSName					= 'smds';
	kATMName					= 'atm';
	kT8022Name					= 'tpi8022x';
	kATMLANEName				= 'atmlane';
	kATMSNAPName				= 'atmsnap';

{}
{ Address Family}
{}
	AF_8022						= 8200;							{ Our 802.2 generic address family	}

{******************************************************************************
** Options
*******************************************************************************}
	OPT_ADDMCAST				= $1000;
	OPT_DELMCAST				= $1001;
	OPT_RCVPACKETTYPE			= $1002;
	OPT_RCVDESTADDR				= $1003;
	OPT_SETRAWMODE				= $1004;
	OPT_SETPROMISCUOUS			= $1005;

	kETypeStandard				= 0;
	kETypeMulticast				= 1;
	kETypeBroadcast				= 2;
	kETRawPacketBit				= $80000000;
	kETTimeStampBit				= $40000000;

{******************************************************************************
** Link related constants
*******************************************************************************}
	kMulticastLength			= 6;							{ length of ENET hardware addresses	}
	k48BitAddrLength			= 6;
	k8022DLSAPLength			= 2;							{ The protocol type is our DLSAP		}
	k8022SNAPLength				= 5;
	kEnetAddressLength			= k48BitAddrLength + k8022DLSAPLength;
	kSNAPSAP					= $00AA;						{ Some special DLSAPS for ENET		}
	kIPXSAP						= $00FF;
	kMax8022SAP					= $00FE;
	k8022GlobalSAP				= $00FF;
	kMinDIXSAP					= 1501;
	kMaxDIXSAP					= $FFFF;

{******************************************************************************
** Generic Address Structure
*******************************************************************************}

TYPE
	T8022Address = RECORD
		fAddrFamily:			OTAddressType;
		fHWAddr:				ARRAY [0..k48BitAddrLength-1] OF SInt8; (* UInt8 *)
		fSAP:					UInt16;
		fSNAP:					ARRAY [0..k8022SNAPLength-1] OF SInt8; (* UInt8 *)
	END;


CONST
	k8022BasicAddressLength		= sizeof(OTAddressType) + k48BitAddrLength + sizeof(UInt16);
	k8022SNAPAddressLength		= sizeof(OTAddressType) + k48BitAddrLength + sizeof(UInt16) + k8022SNAPLength;

{******************************************************************************
** Some helpful stuff for dealing with 48 bit addresses
*******************************************************************************}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OpenTptLinksIncludes}

{$ENDC} {__OPENTPTLINKS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
