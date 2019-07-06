{
 	File:		OpenTransport.p
 
 	Contains:	OpenTransport interfaces
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OpenTransport;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTRANSPORT__}
{$SETC __OPENTRANSPORT__ := 1}

{$I+}
{$SETC OpenTransportIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$SETC SystemSevenOrLater := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$IFC UNDEFINED __STRINGS__}
{$I Strings.p}
{$ENDC}
	
TYPE
	size_t = LONGINT;

{$SETC NULL := 0}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
	uchar_p = LONGINT;

	ushort_p = LONGINT;

	short_p = LONGINT;

	char_p = LONGINT;

	boolean_p = LONGINT;

{$IFC UNDEFINED OTKERNEL }
{$SETC OTKERNEL := 0}
{$ENDC}

CONST
	gestaltOpenTptVersions		= 'otvr';
	gestaltOpenTpt				= 'otan';
	gestaltOpenTptPresent		= $00000001;
	gestaltOpenTptLoaded		= $00000002;
	gestaltOpenTptAppleTalkPresent = $00000004;
	gestaltOpenTptAppleTalkLoaded = $00000008;
	gestaltOpenTptTCPPresent	= $00000010;
	gestaltOpenTptTCPLoaded		= $00000020;
	gestaltOpenTptIPXSPXPresent	= $00000040;
	gestaltOpenTptIPXSPXLoaded	= $00000080;

{******************************************************************************
** Some prefixes for shared libraries
*******************************************************************************}
	kOTLibraryVersion	=	'1.0';
	kOTLibraryPrefix	=	'OTLib$';
	kOTModulePrefix	=	'OTModl$';
	kOTKernelPrefix	=	'OTKrnl$';
	kOTClientPrefix	=	'OTClnt$';
	kOTSupportPrefix	=	'OTSupp$';
{******************************************************************************
** Some typedefs used by the OpenTransport system
*******************************************************************************}
{	-------------------------------------------------------------------------
	Miscellaneous typedefs
	------------------------------------------------------------------------- }
	
TYPE
	OTTimeout = UInt32;

	OTSequence = LONGINT;

	OTNameID = LONGINT;

	OTReason = SInt32;

	OTQLen = UInt32;

	OTClient = Ptr;

	OTClientName = ^UInt8;

	OTOpenFlags = UInt32;


CONST
	O_ASYNC						= $01;
	O_NDELAY					= $04;
	O_NONBLOCK					= $04;

{	-------------------------------------------------------------------------
	StdCLib-style Error codes
	------------------------------------------------------------------------- }
	
TYPE
	OTUnixErr = UInt16;

{
		 * There may be some error code confusions with other compiler vendor header
		 * files - However, these match both MPW and AIX definitions.
		 * We undefine the #defined ones we know about so that we can put them
		 * in an enum.
		 }

CONST
	EPERM						= 1;							{ Permission denied					}
	ENOENT						= 2;							{ No such file or directory			}
	ENORSRC						= 3;							{ No such resource						}
	EINTR						= 4;							{ Interrupted system service			}
	EIO							= 5;							{ I/O error							}
	ENXIO						= 6;							{ No such device or address			}
	EBADF						= 9;							{ Bad file number						}
	EAGAIN						= 11;							{ Try operation again later			}
	ENOMEM						= 12;							{ Not enough space						}
	EACCES						= 13;							{ Permission denied					}
	EFAULT						= 14;							{ Bad address							}
	EBUSY						= 16;							{ Device or resource busy				}
	EEXIST						= 17;							{ File exists							}
	ENODEV						= 19;							{ No such device						}
	EINVAL						= 22;							{ Invalid argument						}
	ENOTTY						= 25;							{ Not a character device				}
	EPIPE						= 32;							{ Broken pipe							}
	ERANGE						= 34;							{ Math result not representable		}
	EDEADLK						= 35;							{ Call would block so was aborted		}
	EWOULDBLOCK					= EDEADLK;						{ Or a deadlock would occur			}
	EALREADY					= 37;
	ENOTSOCK					= 38;							{ Socket operation on non-socket		}
	EDESTADDRREQ				= 39;							{ Destination address required			}
	EMSGSIZE					= 40;							{ Message too long						}
	EPROTOTYPE					= 41;							{ Protocol wrong type for socket		}
	ENOPROTOOPT					= 42;							{ Protocol not available				}
	EPROTONOSUPPORT				= 43;							{ Protocol not supported				}
	ESOCKTNOSUPPORT				= 44;							{ Socket type not supported			}
	EOPNOTSUPP					= 45;							{ Operation not supported on socket	}
	EADDRINUSE					= 48;							{ Address already in use				}
	EADDRNOTAVAIL				= 49;							{ Can't assign requested address		}
	ENETDOWN					= 50;							{ Network is down						}
	ENETUNREACH					= 51;							{ Network is unreachable				}
	ENETRESET					= 52;							{ Network dropped connection on reset	}
	ECONNABORTED				= 53;							{ Software caused connection abort		}
	ECONNRESET					= 54;							{ Connection reset by peer				}
	ENOBUFS						= 55;							{ No buffer space available			}
	EISCONN						= 56;							{ Socket is already connected			}
	ENOTCONN					= 57;							{ Socket is not connected				}
	ESHUTDOWN					= 58;							{ Can't send after socket shutdown		}
	ETOOMANYREFS				= 59;							{ Too many references: can't splice	}
	ETIMEDOUT					= 60;							{ Connection timed out					}
	ECONNREFUSED				= 61;							{ Connection refused					}
	EHOSTDOWN					= 64;							{ Host is down							}
	EHOSTUNREACH				= 65;							{ No route to host						}
	EPROTO						= 70;
	ETIME						= 71;
	ENOSR						= 72;
	EBADMSG						= 73;
	ECANCEL						= 74;
	ENOSTR						= 75;
	ENODATA						= 76;
	EINPROGRESS					= 77;
	ESRCH						= 78;
	ENOMSG						= 79;
	ELASTERRNO					= 79;

{	-------------------------------------------------------------------------
	Open Transport/XTI Error codes
	------------------------------------------------------------------------- }
	
TYPE
	OTXTIErr = UInt16;


CONST
	TSUCCESS					= 0;							{ No Error occurred						}
	TBADADDR					= 1;							{ A Bad address was specified				}
	TBADOPT						= 2;							{ A Bad option was specified				}
	TACCES						= 3;							{ Missing access permission				}
	TBADF						= 4;							{ Bad provider reference					}
	TNOADDR						= 5;							{ No address was specified					}
	TOUTSTATE					= 6;							{ Call issued in wrong state				}
	TBADSEQ						= 7;							{ Sequence specified does not exist		}
	TSYSERR						= 8;							{ A system error occurred					}
	TLOOK						= 9;							{ An event occurred - call Look()			}
	TBADDATA					= 10;							{ An illegal amount of data was specified	}
	TBUFOVFLW					= 11;							{ Passed buffer not big enough				}
	TFLOW						= 12;							{ Provider is flow-controlled				}
	TNODATA						= 13;							{ No data available for reading			}
	TNODIS						= 14;							{ No disconnect indication available		}
	TNOUDERR					= 15;							{ No Unit Data Error indication available	}
	TBADFLAG					= 16;							{ A Bad flag value was supplied			}
	TNOREL						= 17;							{ No orderly release indication available	}
	TNOTSUPPORT					= 18;							{ Command is not supported					}
	TSTATECHNG					= 19;							{ State is changing - try again later		}
	TNOSTRUCTYPE				= 20;							{ Bad structure type requested for OTAlloc	}
	TBADNAME					= 21;							{ A bad endpoint name was supplied			}
	TBADQLEN					= 22;							{ A Bind to an in-use address with qlen > 0}
	TADDRBUSY					= 23;							{ Address requested is already in use		}
	TINDOUT						= 24;							{ Accept failed because of pending listen	}
	TPROVMISMATCH				= 25;							{ Tried to accept on incompatible endpoint	}
	TRESQLEN					= 26;
	TRESADDR					= 27;
	TQFULL						= 28;
	TPROTO						= 29;							{ An unspecified provider error occurred	}
	TBADSYNC					= 30;							{ A synchronous call at interrupt time		}
	TCANCELED					= 31;							{ The command was cancelled				}
	TLASTXTIERROR				= 31;

{	-------------------------------------------------------------------------
	Standard negative error codes conforming to both the Open Transport/XTI
	errors and the Exxxxx StdCLib errors.
	These are returned as OSStatus' from functions, and to the OTResult parameter
	of a notification function or method.  However, OTResult may sometimes
	contain other values depending on the notification.
	------------------------------------------------------------------------- }
	
TYPE
	OTResult = SInt32;

{
		 * These map the Open Transport/XTI errors (the Txxxx error codes), and the
		 * StdCLib Exxxx error codes into unique spaces in the Apple OSStatus space.
		 }

CONST
	kOTNoError					= 0;							{ No Error occurred						}
	kOTOutOfMemoryErr			= 0+(-3199 - (ENOMEM));
	kOTNotFoundErr				= 0+(-3199 - (ENOENT));
	kOTDuplicateFoundErr		= 0+(-3199 - (EEXIST));
{
			 * Remapped XTI error codes
			 }
	kOTBadAddressErr			= 0+(-3149 - (TBADADDR));		{ A Bad address was specified				}
	kOTBadOptionErr				= 0+(-3149 - (TBADOPT));		{ A Bad option was specified				}
	kOTAccessErr				= 0+(-3149 - (TACCES));			{ Missing access permission				}
	kOTBadReferenceErr			= 0+(-3149 - (TBADF));			{ Bad provider reference					}
	kOTNoAddressErr				= 0+(-3149 - (TNOADDR));		{ No address was specified					}
	kOTOutStateErr				= 0+(-3149 - (TOUTSTATE));		{ Call issued in wrong state				}
	kOTBadSequenceErr			= 0+(-3149 - (TBADSEQ));		{ Sequence specified does not exist		}
	kOTSysErrorErr				= 0+(-3149 - (TSYSERR));		{ A system error occurred					}
	kOTLookErr					= 0+(-3149 - (TLOOK));			{ An event occurred - call Look()			}
	kOTBadDataErr				= 0+(-3149 - (TBADDATA));		{ An illegal amount of data was specified	}
	kOTBufferOverflowErr		= 0+(-3149 - (TBUFOVFLW));		{ Passed buffer not big enough				}
	kOTFlowErr					= 0+(-3149 - (TFLOW));			{ Provider is flow-controlled				}
	kOTNoDataErr				= 0+(-3149 - (TNODATA));		{ No data available for reading			}
	kOTNoDisconnectErr			= 0+(-3149 - (TNODIS));			{ No disconnect indication available		}
	kOTNoUDErrErr				= 0+(-3149 - (TNOUDERR));		{ No Unit Data Error indication available	}
	kOTBadFlagErr				= 0+(-3149 - (TBADFLAG));		{ A Bad flag value was supplied			}
	kOTNoReleaseErr				= 0+(-3149 - (TNOREL));			{ No orderly release indication available	}
	kOTNotSupportedErr			= 0+(-3149 - (TNOTSUPPORT));	{ Command is not supported					}
	kOTStateChangeErr			= 0+(-3149 - (TSTATECHNG));		{ State is changing - try again later		}
	kOTNoStructureTypeErr		= 0+(-3149 - (TNOSTRUCTYPE));	{ Bad structure type requested for OTAlloc	}
	kOTBadNameErr				= 0+(-3149 - (TBADNAME));		{ A bad endpoint name was supplied			}
	kOTBadQLenErr				= 0+(-3149 - (TBADQLEN));		{ A Bind to an in-use addr with qlen > 0	}
	kOTAddressBusyErr			= 0+(-3149 - (TADDRBUSY));		{ Address requested is already in use		}
	kOTIndOutErr				= 0+(-3149 - (TINDOUT));		{ Accept failed because of pending listen	}
	kOTProviderMismatchErr		= 0+(-3149 - (TPROVMISMATCH));	{ Tried to accept on incompatible endpoint	}
	kOTResQLenErr				= 0+(-3149 - (TRESQLEN));
	kOTResAddressErr			= 0+(-3149 - (TRESADDR));
	kOTQFullErr					= 0+(-3149 - (TQFULL));
	kOTProtocolErr				= 0+(-3149 - (TPROTO));			{ An unspecified provider error occurred	}
	kOTBadSyncErr				= 0+(-3149 - (TBADSYNC));		{ A synchronous call at interrupt time		}
	kOTCanceledErr				= 0+(-3149 - (TCANCELED));		{ The command was cancelled				}
{
			 * Remapped StdCLib error codes. %%% Remove ones we don't actually return.
			 }
	kEPERMErr					= 0+(-3199 - (EPERM));			{ Permission denied					}
	kENOENTErr					= 0+(-3199 - (ENOENT));			{ No such file or directory			}
	kENORSRCErr					= 0+(-3199 - (ENORSRC));		{ No such resource						}
	kEINTRErr					= 0+(-3199 - (EINTR));			{ Interrupted system service			}
	kEIOErr						= 0+(-3199 - (EIO));			{ I/O error							}
	kENXIOErr					= 0+(-3199 - (ENXIO));			{ No such device or address			}
	kEBADFErr					= 0+(-3199 - (EBADF));			{ Bad file number						}
	kEAGAINErr					= 0+(-3199 - (EAGAIN));			{ Try operation again later			}
	kENOMEMErr					= 0+(-3199 - (ENOMEM));			{ Not enough space						}
	kEACCESErr					= 0+(-3199 - (EACCES));			{ Permission denied					}
	kEFAULTErr					= 0+(-3199 - (EFAULT));			{ Bad address							}
	kEBUSYErr					= 0+(-3199 - (EBUSY));			{ Device or resource busy				}
	kEEXISTErr					= 0+(-3199 - (EEXIST));			{ File exists							}
	kENODEVErr					= 0+(-3199 - (ENODEV));			{ No such device						}
	kEINVALErr					= 0+(-3199 - (EINVAL));			{ Invalid argument						}
	kENOTTYErr					= 0+(-3199 - (ENOTTY));			{ Not a character device				}
	kEPIPEErr					= 0+(-3199 - (EPIPE));			{ Broken pipe							}
	kERANGEErr					= 0+(-3199 - (ERANGE));			{ Message size too large for STREAM	}
	kEWOULDBLOCKErr				= 0+(-3199 - (EWOULDBLOCK));	{ Call would block, so was aborted		}
	kEDEADLKErr					= 0+(-3199 - (EDEADLK));		{ or a deadlock would occur			}
	kEALREADYErr				= 0+(-3199 - (EALREADY));
	kENOTSOCKErr				= 0+(-3199 - (ENOTSOCK));		{ Socket operation on non-socket		}
	kEDESTADDRREQErr			= 0+(-3199 - (EDESTADDRREQ));	{ Destination address required			}
	kEMSGSIZEErr				= 0+(-3199 - (EMSGSIZE));		{ Message too long						}
	kEPROTOTYPEErr				= 0+(-3199 - (EPROTOTYPE));		{ Protocol wrong type for socket		}
	kENOPROTOOPTErr				= 0+(-3199 - (ENOPROTOOPT));	{ Protocol not available				}
	kEPROTONOSUPPORTErr			= 0+(-3199 - (EPROTONOSUPPORT)); { Protocol not supported				}
	kESOCKTNOSUPPORTErr			= 0+(-3199 - (ESOCKTNOSUPPORT)); { Socket type not supported			}
	kEOPNOTSUPPErr				= 0+(-3199 - (EOPNOTSUPP));		{ Operation not supported on socket	}
	kEADDRINUSEErr				= 0+(-3199 - (EADDRINUSE));		{ Address already in use				}
	kEADDRNOTAVAILErr			= 0+(-3199 - (EADDRNOTAVAIL));	{ Can't assign requested address		}
	kENETDOWNErr				= 0+(-3199 - (ENETDOWN));		{ Network is down						}
	kENETUNREACHErr				= 0+(-3199 - (ENETUNREACH));	{ Network is unreachable				}
	kENETRESETErr				= 0+(-3199 - (ENETRESET));		{ Network dropped connection on reset	}
	kECONNABORTEDErr			= 0+(-3199 - (ECONNABORTED));	{ Software caused connection abort		}
	kECONNRESETErr				= 0+(-3199 - (ECONNRESET));		{ Connection reset by peer				}
	kENOBUFSErr					= 0+(-3199 - (ENOBUFS));		{ No buffer space available			}
	kEISCONNErr					= 0+(-3199 - (EISCONN));		{ Socket is already connected			}
	kENOTCONNErr				= 0+(-3199 - (ENOTCONN));		{ Socket is not connected				}
	kESHUTDOWNErr				= 0+(-3199 - (ESHUTDOWN));		{ Can't send after socket shutdown		}
	kETOOMANYREFSErr			= 0+(-3199 - (ETOOMANYREFS));	{ Too many references: can't splice	}
	kETIMEDOUTErr				= 0+(-3199 - (ETIMEDOUT));		{ Connection timed out					}
	kECONNREFUSEDErr			= 0+(-3199 - (ECONNREFUSED));	{ Connection refused					}
	kEHOSTDOWNErr				= 0+(-3199 - (EHOSTDOWN));		{ Host is down							}
	kEHOSTUNREACHErr			= 0+(-3199 - (EHOSTUNREACH));	{ No route to host						}
	kEPROTOErr					= 0+(-3199 - (EPROTO));
	kETIMEErr					= 0+(-3199 - (ETIME));
	kENOSRErr					= 0+(-3199 - (ENOSR));
	kEBADMSGErr					= 0+(-3199 - (EBADMSG));
	kECANCELErr					= 0+(-3199 - (ECANCEL));
	kENOSTRErr					= 0+(-3199 - (ENOSTR));
	kENODATAErr					= 0+(-3199 - (ENODATA));
	kEINPROGRESSErr				= 0+(-3199 - (EINPROGRESS));
	kESRCHErr					= 0+(-3199 - (ESRCH));
	kENOMSGErr					= 0+(-3199 - (ENOMSG));
	kOTClientNotInittedErr		= 0+(-3199 - (ELASTERRNO + 1));
	kOTPortHasDiedErr			= 0+(-3199 - (ELASTERRNO + 2));
	kOTPortWasEjectedErr		= 0+(-3199 - (ELASTERRNO + 3));
	kOTBadConfigurationErr		= 0+(-3199 - (ELASTERRNO + 4));
	kOTConfigurationChangedErr	= 0+(-3199 - (ELASTERRNO + 5));
	kOTUserRequestedErr			= 0+(-3199 - (ELASTERRNO + 6));
	kOTPortLostConnection		= 0+(-3199 - (ELASTERRNO + 7));

{	-------------------------------------------------------------------------
	OTAddressType - defines the address type for the OTAddress
	------------------------------------------------------------------------- }
	
TYPE
	OTAddressType = UInt16;


CONST
	kOTGenericName				= 0;

{	-------------------------------------------------------------------------
	OTAddress - Generic OpenTransport protocol address
	------------------------------------------------------------------------- }

TYPE
	OTAddress = RECORD
		fAddressType:			OTAddressType;
		fAddress:				PACKED ARRAY [0..0] OF SInt8; (* UInt8 *)
	END;

{	-------------------------------------------------------------------------
	OTStructType - defines the structure type for the OTAlloc call
	------------------------------------------------------------------------- }
	OTStructType = UInt32;


CONST
	T_BIND						= 1;
	T_OPTMGMT					= 2;
	T_CALL						= 3;
	T_DIS						= 4;
	T_UNITDATA					= 5;
	T_UDERROR					= 6;
	T_INFO						= 7;
	T_REPLYDATA					= 8;
	T_REQUESTDATA				= 9;
	T_UNITREQUEST				= 10;
	T_UNITREPLY					= 11;

{	-------------------------------------------------------------------------
	OTFlags - flags for sending and receiving data
	------------------------------------------------------------------------- }
	
TYPE
	OTFlags = UInt32;


CONST
	T_MORE						= $001;							{ More data to come in message		}
	T_EXPEDITED					= $002;							{ Data is expedited, if possible	}
	T_ACKNOWLEDGED				= $004;							{ Acknowledge transaction			}
	T_PARTIALDATA				= $008;							{ Partial data - more coming		}
	T_NORECEIPT					= $010;							{ No event on transaction done		}

{	-------------------------------------------------------------------------
	OTBand - a band value when reading priority messages
	------------------------------------------------------------------------- }
	
TYPE
	OTBand = UInt32;

{	-------------------------------------------------------------------------
	Reference values
	------------------------------------------------------------------------- }
	StreamRef = Ptr;

	ProviderRef = Ptr;

	EndpointRef = Ptr;

	MapperRef = Ptr;


CONST
	kOTInvalidRef				= 0;
	kOTInvalidStreamRef			= 0;
	kOTInvalidProviderRef		= 0;
	kOTInvalidEndpointRef		= 0;
	kOTInvalidMapperRef			= 0;

{	-------------------------------------------------------------------------
	OTEventCode values for Open Transport - These are the event codes that
	are sent to notification routine during asynchronous processing.
	------------------------------------------------------------------------- }
	
TYPE
	OTEventCode = UInt32;

{
	 * Function definition to handle notification from providers
	 }
	OTNotifyProcPtr = ProcPtr;  { PROCEDURE (contextPtr: UNIV Ptr; code: OTEventCode; result: OTResult; cookie: UNIV Ptr); }


CONST
{
		 * These will be returned by the T_LOOK function, or will be returned
		 * if asynchronous notification is used.
		 }
	T_LISTEN					= $0001;						{ An connection request is available 	}
	T_CONNECT					= $0002;						{ Confirmation of a connect request	}
	T_DATA						= $0004;						{ Standard data is available			}
	T_EXDATA					= $0008;						{ Expedited data is available			}
	T_DISCONNECT				= $0010;						{ A disconnect is available			}
	T_ERROR						= $0020;						{ obsolete/unused in library			}
	T_UDERR						= $0040;						{ A Unit Data Error has occurred		}
	T_ORDREL					= $0080;						{ An orderly release is available		}
	T_GODATA					= $0100;						{ Flow control lifted on standard data	}
	T_GOEXDATA					= $0200;						{ Flow control lifted on expedited data}
	T_REQUEST					= $0400;						{ An Incoming request is available		}
	T_REPLY						= $0800;						{ An Incoming reply is available		}
	T_PASSCON					= $1000;						{ State is now T_DATAXFER				}
	T_RESET						= $2000;						{ Protocol has been reset				}
{
		 * kPRIVATEEVENT + 1 through kPRIVATEEVENT + 0xffff
		 *		may be used for any private event codes desired.
		 *		All other event codes are reserved for Apple Computer, Inc.
		 *		use only.
		 }
	kPRIVATEEVENT				= $10000000;
{
		 * These are only returned if asynchronous notification is being used
		 }
	kCOMPLETEEVENT				= $20000000;
	T_BINDCOMPLETE				= $20000001;					{ Bind call is complete				}
	T_UNBINDCOMPLETE			= $20000002;					{ Unbind call is complete				}
	T_ACCEPTCOMPLETE			= $20000003;					{ Accept call is complete				}
	T_REPLYCOMPLETE				= $20000004;					{ SendReply call is complete			}
	T_DISCONNECTCOMPLETE		= $20000005;					{ Disconnect call is complete			}
	T_OPTMGMTCOMPLETE			= $20000006;					{ OptMgmt call is complete				}
	T_OPENCOMPLETE				= $20000007;					{ An Open call is complete				}
	T_GETPROTADDRCOMPLETE		= $20000008;					{ GetProtAddress call is complete		}
	T_RESOLVEADDRCOMPLETE		= $20000009;					{ A ResolveAddress call is complet		}
	T_GETINFOCOMPLETE			= $2000000A;					{ A GetInfo call is complete			}
	T_SYNCCOMPLETE				= $2000000B;					{ A Sync call is complete				}
	T_MEMORYRELEASED			= $2000000C;					{ No-copy memory was released			}
	T_REGNAMECOMPLETE			= $2000000D;					{ A RegisterName call is complete		}
	T_DELNAMECOMPLETE			= $2000000E;					{ A DeleteName call is complete		}
	T_LKUPNAMECOMPLETE			= $2000000F;					{ A LookupName call is complete		}
	T_LKUPNAMERESULT			= $20000010;					{ A LookupName is returning a name		}
{
		 * Events for streams - not normally seen by clients.
		 }
	kSTREAMEVENT				= $21000000;
	kOTDisablePortEvent			= $21000001;					{ this line deleted for release disk	}
	kGetmsgEvent				= $21000002;					{ A GetMessage call is complete		}
	kStreamReadEvent			= $21000003;					{ A Read call is complete				}
	kStreamWriteEvent			= $21000004;					{ A Write call is complete				}
	kStreamIoctlEvent			= $21000005;					{ An Ioctl call is complete			}
	kStreamOpenEvent			= $21000007;					{ An OpenStream call is complete		}
	kPollEvent					= $21000008;					{ A Poll call is complete				}
	kSIGNALEVENT				= $22000000;					{ A signal has arrived from the STREAM	}
	kPROTOCOLEVENT				= $23000000;					{ Some event from the protocols		}
	kIMMEDIATEEVENT				= $80000000;					{ This bit or'd in makes it "immediate"}
{
		 * These are miscellaneous events that could be sent to a provider
		 }
	kOTProviderIsDisconnected	= $23000001;					{ Provider is temporarily off-line		}
	kOTProviderIsReconnected	= $23000002;					{ Provider is now back on-line			}
{
		 * These are system events sent to each provider.
		 }
	kOTProviderWillClose		= $24000001;					{ Provider will close immediately		}
	kOTProviderIsClosed			= $24000002;					{ Provider was closed					}
{
		 * These are system events sent to registered clients
		 	*
			* result code is 0, cookie is the OTPortRef
		 }
	kOTPortDisabled				= $25000001;					{ Port is now disabled					}
	kOTPortEnabled				= $25000002;					{ Port is now enabled					}
	kOTRequestHardware			= $25000003;					{ Request to use hardware				}
	kOTHardwareInUse			= $25000003;					{ specified hardware is in use			}
	kOTReleaseHardware			= $25000004;					{ Release use of hardware				}
	kOTHardwareIsFree			= $25000004;					{ specified hardware is no longer used	}
{
			 * A new port has been registered, cookie is the OTPortRef
			 }
	kOTNewPortRegistered		= $25000003;					{ New port has been registered			}
{
			 * result is a reason for the close request, cookie is a pointer to the 
			 * OTPortCloseStruct structure.
			 }
	kOTClosePortRequest			= $25000005;					{ Request to close						}
{
		 * These are events sent to the configuration management infrastructure 
		 }
	kOTConfigurationChanged		= $26000001;					{ Protocol configuration changed		}
	kOTSystemSleep				= $26000002;
	kOTSystemShutdown			= $26000003;
	kOTSystemAwaken				= $26000004;
	kOTSystemIdle				= $26000005;

	SIGHUP						= 1;
	SIGURG						= 16;
	SIGPOLL						= 30;

{	-------------------------------------------------------------------------
	Option Management equates
	------------------------------------------------------------------------- }
{
	** The XTI Level number of a protocol
	}
	
TYPE
	OTXTILevel = UInt32;


CONST
	XTI_GENERIC					= $ffff;						{ level to match any protocol	}

{
	** The XTI name of a protocol option
	}
	
TYPE
	OTXTIName = UInt32;

{
		 * XTI names for options used with XTI_GENERIC above
		 }

CONST
	XTI_DEBUG					= $0001;
	XTI_LINGER					= $0080;
	XTI_RCVBUF					= $1002;
	XTI_RCVLOWAT				= $1004;
	XTI_SNDBUF					= $1001;
	XTI_SNDLOWAT				= $1003;
	XTI_PROTOTYPE				= $1005;

{
		 * Generic options that can be used with any protocol
		 * that understands them
		 }
	OPT_CHECKSUM				= $0600;						{ Set checksumming = UInt32 - 0 or 1)}
	OPT_RETRYCNT				= $0601;						{ Set a retry counter = UInt32 (0 = infinite)}
	OPT_INTERVAL				= $0602;						{ Set a retry interval = UInt32 milliseconds}
	OPT_ENABLEEOM				= $0603;						{ Enable the EOM indication = UInt8 (0 or 1)}
	OPT_SELFSEND				= $0604;						{ Enable Self-sending on broadcasts = UInt32 (0 or 1)}
	OPT_SERVERSTATUS			= $0605;						{ Set Server Status (format is proto dependent)}
	OPT_KEEPALIVE				= $0008;						{ See t_keepalive structure}

{******************************************************************************
** Definitions not associated with a Typedef
*******************************************************************************}
{	-------------------------------------------------------------------------
	IOCTL values for the OpenTransport system
	------------------------------------------------------------------------- }
	MIOC_STREAMIO				= 'A';							{ Basic Stream ioctl() cmds - I_PUSH, I_LOOK, etc. }
	MIOC_STRLOG					= 'b';							{ ioctl's for Mentat's log device }
	MIOC_SAD					= 'g';							{ ioctl's for Mentat's sad module }
	MIOC_ARP					= 'h';							{ ioctl's for Mentat's arp module }
	MIOC_TCP					= 'k';							{ tcp.h ioctl's }
	MIOC_DLPI					= 'l';							{ dlpi.h additions }
	MIOC_OT						= 'O';							{ ioctls for Open Transport	}
	MIOC_ATALK					= 'T';							{ ioctl's for AppleTalk	}
	MIOC_SRL					= 'U';							{ ioctl's for Serial		}
	MIOC_SRL_HIGH				= $5400;						{ ioctls for Serial			'U' << 8 }
	MIOC_OT_HIGH				= $4F00;						{ ioctls for Open Transport	'O' << 8 }
	MIOC_SIO_HIGH				= $4100;						{ ioctls for StreamIO			'A' << 8 }

	I_STR						= 0+(MIOC_SIO_HIGH + 8);
	I_FIND						= 0+(MIOC_SIO_HIGH + 11);
	I_LIST						= 0+(MIOC_SIO_HIGH + 22);
	I_OTGetMiscellaneousEvents	= 0+(MIOC_OT_HIGH + 1);
	I_OTSetFramingType			= 0+(MIOC_OT_HIGH + 2);
	kOTGetFramingValue			= $ffffffff;
	I_OTSetRawMode				= 0+(MIOC_OT_HIGH + 3);

{ 
	 * structure of ioctl data for I_STR IOCtls
	 }

TYPE
	strioctl = RECORD
		ic_cmd:					LONGINT;								{ downstream command	}
		ic_timout:				LONGINT;								{ ACK/NAK timeout		}
		ic_len:					LONGINT;								{ length of data arg	}
		ic_dp:					^CHAR;									{ ptr to data arg		}
	END;

{	-------------------------------------------------------------------------
	Maximum size of a provider name, and maximum size of a STREAM module name.
	This module name is smaller than the maximum size of a TProvider to allow
	for 4 characters of extra "minor number" information that might be 
	potentially in a TProvider name
	------------------------------------------------------------------------- }

CONST
	kMaxModuleNameLength		= 31;
	kMaxModuleNameSize			= kMaxModuleNameLength + 1;
	kMaxProviderNameLength		= kMaxModuleNameLength + 4;
	kMaxProviderNameSize		= kMaxProviderNameLength + 1;
	kMaxSlotIDLength			= 7;
	kMaxSlotIDSize				= 8;
	kMaxResourceInfoLength		= 31;
	kMaxResourceInfoSize		= 32;

{	-------------------------------------------------------------------------
	These values are used in the "fields" parameter of the OTAlloc call
	to define which fields of the structure should be allocated.
	------------------------------------------------------------------------- }
	T_ADDR						= $01;
	T_OPT						= $02;
	T_UDATA						= $04;
	T_ALL						= $ffff;

{	-------------------------------------------------------------------------
	These are the potential values returned by OTGetEndpointState and OTSync
	which represent the state of an endpoint
	------------------------------------------------------------------------- }
	T_UNINIT					= 0;							{ addition to standard xti.h	}
	T_UNBND						= 1;							{ unbound						}
	T_IDLE						= 2;							{ idle							}
	T_OUTCON					= 3;							{ outgoing connection pending	}
	T_INCON						= 4;							{ incoming connection pending	}
	T_DATAXFER					= 5;							{ data transfer				}
	T_OUTREL					= 6;							{ outgoing orderly release		}
	T_INREL						= 7;							{ incoming orderly release		}

{	-------------------------------------------------------------------------
	Flags used by option management calls to request services
	------------------------------------------------------------------------- }
	T_NEGOTIATE					= $004;
	T_CHECK						= $008;
	T_DEFAULT					= $010;
	T_CURRENT					= $080;

{	-------------------------------------------------------------------------
	Flags used by option management calls to return results
	------------------------------------------------------------------------- }
	T_SUCCESS					= $020;
	T_FAILURE					= $040;
	T_PARTSUCCESS				= $100;
	T_READONLY					= $200;
	T_NOTSUPPORT				= $400;

{	-------------------------------------------------------------------------
	General definitions
	------------------------------------------------------------------------- }
	T_YES						= 1;
	T_NO						= 0;
	T_UNUSED					= -1;
	T_NULL						= 0;
	T_ABSREQ					= $8000;

{	-------------------------------------------------------------------------
	Option Management definitions
	------------------------------------------------------------------------- }
	T_UNSPEC					= 0+($FFFFFFFF - 2);
	T_ALLOPT					= 0;

{}
{ This macro will align return the value of "len", rounded up to the next}
{ 4-byte boundary.}
{}

TYPE
	OTConfiguration = RECORD
	END;
	OTConfigurationPtr = ^OTConfiguration;

	t_kpalive = RECORD
		kp_onoff:				LONGINT;								{ option on/off		}
		kp_timeout:				LONGINT;								{ timeout in minutes	}
	END;

{
	 * Structure used with XTI_LINGER option
	 }
	t_linger = RECORD
		l_onoff:				LONGINT;								{ option on/off }
		l_linger:				LONGINT;								{ linger time }
	END;

{	-------------------------------------------------------------------------
	TEndpointInfo - this structure is returned from the GetEndpointInfo call
	and contains information about an endpoint
	------------------------------------------------------------------------- }
	TEndpointInfo = RECORD
		addr:					SInt32;									{ Maximum size of an address			}
		options:				SInt32;									{ Maximum size of options				}
		tsdu:					SInt32;									{ Standard data transmit unit size		}
		etsdu:					SInt32;									{ Expedited data transmit unit size	}
		connect:				SInt32;									{ Maximum data size on connect			}
		discon:					SInt32;									{ Maximum data size on disconnect		}
		servtype:				UInt32;									{ service type (see below for values)	}
		flags:					UInt32;									{ Flags (see below for values)			}
	END;

{
	 * Values returned in servtype field of TEndpointInfo
	 }

CONST
	T_COTS						= 1;							{ Connection-mode service								}
	T_COTS_ORD					= 2;							{ Connection service with orderly release				}
	T_CLTS						= 3;							{ Connectionless-mode service							}
	T_TRANS						= 5;							{ Connection-mode transaction service					}
	T_TRANS_ORD					= 6;							{ Connection transaction service with orderly release	}
	T_TRANS_CLTS				= 7;							{ Connectionless transaction service					}

{
	 * Values returned in flags field of TEndpointInfo
	 }
	T_SENDZERO					= $001;							{ supports 0-length TSDU's			}
	T_XPG4_1					= $002;							{ supports the GetProtAddress call	}
	T_CAN_SUPPORT_MDATA			= $10000000;					{ support M_DATAs on packet protocols	}
	T_CAN_RESOLVE_ADDR			= $40000000;					{ Supports ResolveAddress call			}
	T_CAN_SUPPLY_MIB			= $20000000;					{ Supports SNMP MIB data				}

{
	 * Values returned in tsdu, etsdu, connect, and discon fields of TEndpointInfo
	 }
	T_INFINITE					= -1;							{ supports infinit amounts of data		}
	T_INVALID					= -2;							{ Does not support data transmission	}

{	-------------------------------------------------------------------------
	OTPortRecord
	------------------------------------------------------------------------- }
{
	 * Unique identifier for a port
	 }
	
TYPE
	OTPortRef = UInt32;

{
	 * A couple of special values for the "port type" in an OTPortRef.
	 * See OpenTptLinks.h for other values.
	 * The device kOTPseudoDevice is used where no other defined
	 * device type will work.
	 }

CONST
	kOTNoDeviceType				= 0;
	kOTPseudoDevice				= 1023;
	kOTLastDeviceIndex			= 1022;
	kOTLastSlotNumber			= 255;
	kOTLastOtherNumber			= 255;

{
	 * kMaxPortNameLength is the maximum size allowed to define
	 * a port
	 }
	kMaxPortNameLength			= kMaxModuleNameLength + 4;
	kMaxPortNameSize			= kMaxPortNameLength + 1;

	kInvalidPortRef				= 0+(0);						{ %%% Going away }
	kOTInvalidPortRef			= 0+(0);

{
	 * Equates for the legal Bus-type values
	 }
	kOTUnknownBusPort			= 0;
	kOTMotherboardBus			= 1;
	kOTNuBus					= 2;
	kOTPCIBus					= 3;
	kOTGeoPort					= 4;
	kOTPCMCIABus				= 5;
	kOTLastBusIndex				= 15;


TYPE
	OTPortCloseStruct = RECORD
		fPortRef:				OTPortRef;								{ The port requested to be closed.}
		fTheProvider:			ProviderRef;							{ The provider using the port.}
		fDenyReason:			OSStatus;								{ Set to a negative number to deny the request}
	END;


FUNCTION OTCreatePortRef(busType: ByteParameter; devType: UInt16; slot: UInt16; other: UInt16): OTPortRef;
FUNCTION OTGetDeviceTypeFromPortRef(ref: OTPortRef): UInt16;
FUNCTION OTGetBusTypeFromPortRef(ref: OTPortRef): UInt16;
FUNCTION OTGetSlotFromPortRef(ref: OTPortRef; VAR other: UInt16): UInt16;

TYPE
	OTPortRecord = RECORD
		fRef:					OTPortRef;
		fPortFlags:				UInt32;
		fInfoFlags:				UInt32;
		fCapabilities:			UInt32;
		fNumChildPorts:			size_t;
		fChildPorts:			^OTPortRef;
		fPortName:				PACKED ARRAY [0..kMaxProviderNameSize-1] OF CHAR;
		fModuleName:			PACKED ARRAY [0..kMaxModuleNameSize-1] OF CHAR;
		fSlotID:				PACKED ARRAY [0..kMaxSlotIDSize-1] OF CHAR;
		fResourceInfo:			PACKED ARRAY [0..kMaxResourceInfoSize-1] OF CHAR;
		fReserved:				PACKED ARRAY [0..163] OF CHAR;
	END;

{
	 * Values for the fInfoFlags field of OTPortRecord
	 }

CONST
	kOTPortIsDLPI				= $00000001;
	kOTPortIsTPI				= $00000002;
	kOTPortCanYield				= $00000004;
	kOTPortIsSystemRegistered	= $00004000;
	kOTPortIsPrivate			= $00008000;
	kOTPortIsAlias				= $80000000;

{
	 * Values for the fPortFlags field of TPortRecord
	 * If no bits are set, the port is currently inactive.
	 * kOTPortIsDisabled and kOTPortIsUnavailable may be set
	 * at the same time.  
	 }
	kOTPortIsActive				= $00000001;
	kOTPortIsDisabled			= $00000002;
	kOTPortIsUnavailable		= $00000004;

{	-------------------------------------------------------------------------
	TOptionHeader and TOption
	
	This structure describes the contents of a single option in a buffer
	------------------------------------------------------------------------- }

TYPE
	TOptionHeader = RECORD
		len:					UInt32;									{ total length of option				}
		{ = sizeof(TOptionHeader) + length		}
		{	 of option value in bytes			}
		level:					OTXTILevel;								{ protocol affected					}
		optName:				OTXTIName;								{ option name							}
		status:					UInt32;									{ status value							}
	END;

	TOption = RECORD
		len:					UInt32;									{ total length of option				}
		{ = sizeof(TOption) + length	}
		{	 of option value in bytes			}
		level:					OTXTILevel;								{ protocol affected					}
		optName:				OTXTIName;								{ option name							}
		status:					UInt32;									{ status value							}
		value:					ARRAY [0..0] OF UInt32;					{ data goes here						}
	END;


CONST
	kOTOptionHeaderSize			= sizeof(TOptionHeader);
	kOTBooleanOptionDataSize	= sizeof(UInt32);
	kOTBooleanOptionSize		= kOTOptionHeaderSize + kOTBooleanOptionDataSize;
	kOTOneByteOptionSize		= kOTOptionHeaderSize + 1;
	kOTTwoByteOptionSize		= kOTOptionHeaderSize + 2;
	kOTFourByteOptionSize		= kOTOptionHeaderSize + sizeof(UInt32);

{	-------------------------------------------------------------------------
	PollRef structure
	
	This is used with the OTStreamPoll function
	------------------------------------------------------------------------- }

TYPE
	PollRef = RECORD
		filler:					LONGINT;
		events:					INTEGER;
		revents:				INTEGER;
		ref:					StreamRef;
	END;

{	-------------------------------------------------------------------------
	OTClientList structure
	
	This is used with the OTYieldPortRequest function.
	------------------------------------------------------------------------- }
	OTClientList = RECORD
		fNumClients:			size_t;
		fBuffer:				PACKED ARRAY [0..3] OF SInt8; (* UInt8 *)
	END;

{	-------------------------------------------------------------------------
	OTData
	
	This is a structure that may be used in a TNetbuf or netbuf to send
	non-contiguous data.  Set the 'len' field of the netbuf to the
	constant kNetbufDataIsOTData to signal that the 'buf' field of the
	netbuf actually points to one of these structures instead of a
	memory buffer.
	------------------------------------------------------------------------- }
	OTData = RECORD
		fNext:					Ptr;
		fData:					Ptr;
		fLen:					size_t;
	END;


CONST
	kNetbufDataIsOTData			= $fffffffe;

{	-------------------------------------------------------------------------
	OTBuffer

	This is the structure that is used for no-copy receives.
	When you are done with it, you must call the OTReleaseBuffer function.
	For best performance, you need to call OTReleaseBuffer quickly.  Only
	data netbufs may use this - no netbufs for addresses or options, or the like.
	------------------------------------------------------------------------- }

TYPE
	OTBuffer = RECORD
		fLink:					Ptr;									{ b_next & b_prev}
		fLink2:					Ptr;
		fNext:					^OTBuffer;								{ b_cont}
		fData:					^UInt8;									{ b_rptr}
		fLen:					size_t;									{ b_wptr}
		fSave:					Ptr;									{ b_datap}
		fBand:					SInt8; (* UInt8 *)						{ b_band}
		fType:					SInt8; (* UInt8 *)						{ b_pad1}
		fPad1:					SInt8; (* UInt8 *)
		fFlags:					SInt8; (* UInt8 *)						{ b_flag}
	END;

{	-------------------------------------------------------------------------
	OTBufferInfo
	
	This structure is used with OTReadBuffer to keep track of where you
	are in the buffer, since the OTBuffer is "read-only".
	------------------------------------------------------------------------- }
	OTBufferInfo = RECORD
		fBuffer:				^OTBuffer;
		fOffset:				size_t;
		fPad:					SInt8; (* UInt8 *)
		fFiller:				SInt8; (* UInt8 *)
	END;


CONST
	kOTNetbufDataIsOTBufferStar	= $fffffffd;

{	-------------------------------------------------------------------------
	TNetbuf
	
	This structure is the basic structure used to pass data back and forth
	between the Open Transport protocols and their clients
	------------------------------------------------------------------------- }

TYPE
	TNetbuf = RECORD
		maxlen:					size_t;
		len:					size_t;
		buf:					Ptr;
	END;

{	-------------------------------------------------------------------------
	TBind
	
	Structure passed to GetProtAddress, ResolveAddress and Bind
	------------------------------------------------------------------------- }
	TBind = RECORD
		addr:					TNetbuf;
		qlen:					OTQLen;
	END;
	TBindPtr = ^TBind;

{	-------------------------------------------------------------------------
	TDiscon
	
	Structure passed to RcvDisconnect to find out additional information
	about the disconnect
	------------------------------------------------------------------------- }
	TDiscon = RECORD
		udata:					TNetbuf;
		reason:					OTReason;
		sequence:				OTSequence;
	END;
	TDisconPtr = ^TDiscon;

{	-------------------------------------------------------------------------
	TCall
	
	Structure passed to Connect, RcvConnect, Listen, Accept, and
	SndDisconnect to describe the connection.
	------------------------------------------------------------------------- }
	TCall = RECORD
		addr:					TNetbuf;
		opt:					TNetbuf;
		udata:					TNetbuf;
		sequence:				OTSequence;
	END;

{	-------------------------------------------------------------------------
	TUnitData
	
	Structure passed to SndUData and RcvUData to describe the datagram
	------------------------------------------------------------------------- }
	TUnitData = RECORD
		addr:					TNetbuf;
		opt:					TNetbuf;
		udata:					TNetbuf;
	END;

{	-------------------------------------------------------------------------
	TUDErr
	
	Structure passed to RcvUDErr to find out about a datagram error
	------------------------------------------------------------------------- }
	TUDErr = RECORD
		addr:					TNetbuf;
		opt:					TNetbuf;
		error:					SInt32;
	END;

{	-------------------------------------------------------------------------
	TOptMgmt
	
	Structure passed to the OptionManagement call to read or set protocol
	options.
	------------------------------------------------------------------------- }
	TOptMgmt = RECORD
		opt:					TNetbuf;
		flags:					OTFlags;
	END;

{	-------------------------------------------------------------------------
	TRequest
	
	Structure passed to SndRequest and RcvRequest that contains the information
	about the request
	------------------------------------------------------------------------- }
	TRequest = RECORD
		data:					TNetbuf;
		opt:					TNetbuf;
		sequence:				OTSequence;
	END;

{	-------------------------------------------------------------------------
	TReply
	
	Structure passed to SndReply to send a reply to an incoming request
	------------------------------------------------------------------------- }
	TReply = RECORD
		data:					TNetbuf;
		opt:					TNetbuf;
		sequence:				OTSequence;
	END;

{	-------------------------------------------------------------------------
	TUnitRequest
	
	Structure passed to SndURequest and RcvURequest that contains the information
	about the request
	------------------------------------------------------------------------- }
	TUnitRequest = RECORD
		addr:					TNetbuf;
		opt:					TNetbuf;
		udata:					TNetbuf;
		sequence:				OTSequence;
	END;

{	-------------------------------------------------------------------------
	TUnitReply
	
	Structure passed to SndUReply to send a reply to an incoming request
	------------------------------------------------------------------------- }
	TUnitReply = RECORD
		opt:					TNetbuf;
		udata:					TNetbuf;
		sequence:				OTSequence;
	END;

{	-------------------------------------------------------------------------
	TRegisterRequest
	------------------------------------------------------------------------- }
	TRegisterRequest = RECORD
		name:					TNetbuf;
		addr:					TNetbuf;
		flags:					OTFlags;
	END;

{	-------------------------------------------------------------------------
	TRegisterReply
	------------------------------------------------------------------------- }
	TRegisterReply = RECORD
		addr:					TNetbuf;
		nameid:					OTNameID;
	END;

{	-------------------------------------------------------------------------
	TLookupRequest
	------------------------------------------------------------------------- }
	TLookupRequest = RECORD
		name:					TNetbuf;
		addr:					TNetbuf;
		maxcnt:					UInt32;
		timeout:				OTTimeout;
		flags:					OTFlags;
	END;

{	-------------------------------------------------------------------------
	TLookupReply 
	
	Structure used by Mapper protocols to return the results of name Lookups
	------------------------------------------------------------------------- }
{
	 * This is the structure returned by the mapper for names that are
	 * looked up.  
	 }
	TLookupBuffer = RECORD
		fAddressLength:			UInt16;
		fNameLength:			UInt16;
		fAddressBuffer:			PACKED ARRAY [0..0] OF SInt8; (* UInt8 *)
	END;

	TLookupReply = RECORD
		names:					TNetbuf;
		rspcount:				UInt32;
	END;

{******************************************************************************
** C Interfaces to Open Transport
*******************************************************************************}
{	-------------------------------------------------------------------------
	Initializing and shutting down Open Transport
	------------------------------------------------------------------------- }
{$IFC NOT OTKERNEL }

FUNCTION InitOpenTransport: OSStatus;
FUNCTION InitOpenTransportUtilities: OSStatus;
PROCEDURE CloseOpenTransport;
{}
{ This registers yourself as a client for any miscellaneous Open Transport}
{ notifications that come along. CloseOpenTransport will automatically do}
{ an OTUnregisterAsClient, if you have not already done so.}
{}
FUNCTION OTRegisterAsClient(name: OTClientName; proc: OTNotifyProcPtr): OSStatus;
FUNCTION OTUnregisterAsClient: OSStatus;
{$ENDC}

PROCEDURE OTEnterInterrupt;
PROCEDURE OTLeaveInterrupt;
TYPE
	OTProcessProcPtr = ProcPtr;  { PROCEDURE (arg: UNIV Ptr); }


FUNCTION OTCreateDeferredTask(proc: OTProcessProcPtr; arg: UNIV Ptr): LONGINT;
FUNCTION OTScheduleDeferredTask(dtCookie: LONGINT): BOOLEAN;
FUNCTION OTScheduleInterruptTask(dtCookie: LONGINT): BOOLEAN;
FUNCTION OTDestroyDeferredTask(dtCookie: LONGINT): OSStatus;
{$IFC NOT OTKERNEL }
FUNCTION OTCreateSystemTask(proc: OTProcessProcPtr; arg: UNIV Ptr): LONGINT;
FUNCTION OTDestroySystemTask(stCookie: LONGINT): OSStatus;
FUNCTION OTScheduleSystemTask(stCookie: LONGINT): BOOLEAN;
FUNCTION OTCancelSystemTask(stCookie: LONGINT): BOOLEAN;
FUNCTION OTCanMakeSyncCall: BOOLEAN;
{$ENDC}
{$IFC NOT OTKERNEL }
FUNCTION OTGetIndexedPort(VAR record1: OTPortRecord; index: size_t): BOOLEAN;
FUNCTION OTFindPort(VAR record1: OTPortRecord; portName: ConstCStringPtr): BOOLEAN;
FUNCTION OTFindPortByRef(VAR record1: OTPortRecord; ref: OTPortRef): BOOLEAN;
{$ENDC}

TYPE
	strbuf = RECORD
		maxlen:					LONGINT;								{ max buffer length }
		len:					LONGINT;								{ length of data }
		buf:					^CHAR;									{ pointer to buffer }
	END;

{$IFC NOT OTKERNEL }

FUNCTION OTCloseProvider(ref: ProviderRef): OSStatus;
FUNCTION OTTransferProviderOwnership(ref: ProviderRef; prevOwner: OTClient; VAR errPtr: OSStatus): ProviderRef;
FUNCTION OTWhoAmI: OTClient;
FUNCTION OTGetProviderPortRef(ref: ProviderRef): OTPortRef;
FUNCTION OTIoctl(ref: ProviderRef; cmd: UInt32; data: UNIV Ptr): SInt32;
FUNCTION OTGetMessage(ref: ProviderRef; VAR ctlbuf: strbuf; VAR databuf: strbuf; VAR flagPtr: OTFlags): OTResult;
FUNCTION OTGetPriorityMessage(ref: ProviderRef; VAR ctlbuf: strbuf; VAR databuf: strbuf; VAR bandPtr: OTBand; VAR flagPtr: OTFlags): OTResult;
FUNCTION OTPutMessage(ref: ProviderRef; {CONST}VAR ctlbuf: strbuf; {CONST}VAR databuf: strbuf; flags: OTFlags): OSStatus;
FUNCTION OTPutPriorityMessage(ref: ProviderRef; {CONST}VAR ctlbuf: strbuf; {CONST}VAR databuf: strbuf; band: OTBand; flags: OTFlags): OSStatus;
FUNCTION OTSetAsynchronous(ref: ProviderRef): OSStatus;
FUNCTION OTSetSynchronous(ref: ProviderRef): OSStatus;
FUNCTION OTIsSynchronous(ref: ProviderRef): BOOLEAN;
FUNCTION OTSetBlocking(ref: ProviderRef): OSStatus;
FUNCTION OTSetNonBlocking(ref: ProviderRef): OSStatus;
FUNCTION OTIsBlocking(ref: ProviderRef): BOOLEAN;
FUNCTION OTInstallNotifier(ref: ProviderRef; proc: OTNotifyProcPtr; contextPtr: UNIV Ptr): OSStatus;
PROCEDURE OTRemoveNotifier(ref: ProviderRef);
FUNCTION OTAckSends(ref: ProviderRef): OSStatus;
FUNCTION OTDontAckSends(ref: ProviderRef): OSStatus;
FUNCTION OTIsAckingSends(ref: ProviderRef): BOOLEAN;
FUNCTION OTCancelSynchronousCalls(ref: ProviderRef; err: OSStatus): OSStatus;
{$ENDC}
{$IFC NOT OTKERNEL }

FUNCTION OTOpenEndpoint(config: OTConfigurationPtr; oflag: OTOpenFlags; VAR info: TEndpointInfo; VAR err: OSStatus): EndpointRef;
FUNCTION OTAsyncOpenEndpoint(config: OTConfigurationPtr; oflag: OTOpenFlags; VAR info: TEndpointInfo; proc: OTNotifyProcPtr; contextPtr: UNIV Ptr): OSStatus;
{}
{ Misc Information}
{}
FUNCTION OTGetEndpointInfo(ref: EndpointRef; VAR info: TEndpointInfo): OSStatus;
FUNCTION OTGetEndpointState(ref: EndpointRef): OTResult;
FUNCTION OTLook(ref: EndpointRef): OTResult;
FUNCTION OTSync(ref: EndpointRef): OTResult;
FUNCTION OTCountDataBytes(ref: EndpointRef; VAR countPtr: size_t): OTResult;
FUNCTION OTGetProtAddress(ref: EndpointRef; VAR boundAddr: TBind; VAR peerAddr: TBind): OSStatus;
FUNCTION OTResolveAddress(ref: EndpointRef; VAR reqAddr: TBind; VAR retAddr: TBind; timeOut: OTTimeout): OSStatus;
{}
{ Allocating structures}
{}
FUNCTION OTAlloc(ref: EndpointRef; structType: OTStructType; fields: UInt32; VAR err: OSStatus): Ptr;
FUNCTION OTFree(ptr: UNIV Ptr; structType: OTStructType): OTResult;
{}
{ Option management}
{}
FUNCTION OTOptionManagement(ref: EndpointRef; VAR req: TOptMgmt; VAR ret: TOptMgmt): OSStatus;
{}
{ Bind/Unbind}
{}
FUNCTION OTBind(ref: EndpointRef; reqAddr: TBindPtr; retAddr: TBindPtr): OSStatus;
FUNCTION OTUnbind(ref: EndpointRef): OSStatus;
{}
{ Connection creation/tear-down}
{}
FUNCTION OTConnect(ref: EndpointRef; VAR sndCall: TCall; VAR rcvCall: TCall): OSStatus;
FUNCTION OTRcvConnect(ref: EndpointRef; VAR call: TCall): OSStatus;
FUNCTION OTListen(ref: EndpointRef; VAR call: TCall): OSStatus;
FUNCTION OTAccept(ref: EndpointRef; resRef: EndpointRef; VAR call: TCall): OSStatus;
FUNCTION OTSndDisconnect(ref: EndpointRef; VAR call: TCall): OSStatus;
FUNCTION OTSndOrderlyDisconnect(ref: EndpointRef): OSStatus;
FUNCTION OTRcvDisconnect(ref: EndpointRef; discon: TDisconPtr): OSStatus;
FUNCTION OTRcvOrderlyDisconnect(ref: EndpointRef): OSStatus;
{}
{ Connection-oriented send/receive}
{}
FUNCTION OTRcv(ref: EndpointRef; buf: UNIV Ptr; nbytes: size_t; VAR flags: OTFlags): OTResult;
FUNCTION OTSnd(ref: EndpointRef; buf: UNIV Ptr; nbytes: size_t; flags: OTFlags): OTResult;
{}
{ non-connection oriented send/receive}
{}
FUNCTION OTSndUData(ref: EndpointRef; VAR udata: TUnitData): OSStatus;
FUNCTION OTRcvUData(ref: EndpointRef; VAR udata: TUnitData; VAR flags: OTFlags): OSStatus;
FUNCTION OTRcvUDErr(ref: EndpointRef; VAR uderr: TUDErr): OSStatus;
{}
{ Connection-oriented transactions}
{}
FUNCTION OTSndRequest(ref: EndpointRef; VAR req: TRequest; reqFlags: OTFlags): OSStatus;
FUNCTION OTRcvReply(ref: EndpointRef; VAR reply: TReply; VAR replyFlags: OTFlags): OSStatus;
FUNCTION OTSndReply(ref: EndpointRef; VAR reply: TReply; replyFlags: OTFlags): OSStatus;
FUNCTION OTRcvRequest(ref: EndpointRef; VAR req: TRequest; VAR reqFlags: OTFlags): OSStatus;
FUNCTION OTCancelRequest(ref: EndpointRef; sequence: OTSequence): OSStatus;
FUNCTION OTCancelReply(ref: EndpointRef; sequence: OTSequence): OSStatus;
{}
{ Connectionless transactions}
{}
FUNCTION OTSndURequest(ref: EndpointRef; VAR req: TUnitRequest; reqFlags: OTFlags): OSStatus;
FUNCTION OTRcvUReply(ref: EndpointRef; VAR reply: TUnitReply; VAR replyFlags: OTFlags): OSStatus;
FUNCTION OTSndUReply(ref: EndpointRef; VAR reply: TUnitReply; replyFlags: OTFlags): OSStatus;
FUNCTION OTRcvURequest(ref: EndpointRef; VAR req: TUnitRequest; VAR reqFlags: OTFlags): OSStatus;
FUNCTION OTCancelURequest(ref: EndpointRef; seq: OTSequence): OSStatus;
FUNCTION OTCancelUReply(ref: EndpointRef; seq: OTSequence): OSStatus;
{	-------------------------------------------------------------------------
	Interface to mappers
	------------------------------------------------------------------------- }
FUNCTION OTAsyncOpenMapper(VAR config: OTConfiguration; oflag: OTOpenFlags; proc: OTNotifyProcPtr; contextPtr: UNIV Ptr): OSStatus;
FUNCTION OTOpenMapper(VAR config: OTConfiguration; oflag: OTOpenFlags; VAR err: OSStatus): MapperRef;
FUNCTION OTRegisterName(ref: MapperRef; VAR req: TRegisterRequest; VAR reply: TRegisterReply): OSStatus;
FUNCTION OTDeleteName(ref: MapperRef; VAR name: TNetbuf): OSStatus;
FUNCTION OTDeleteNameByID(ref: MapperRef; nameID: OTNameID): OSStatus;
FUNCTION OTLookupName(ref: MapperRef; VAR req: TLookupRequest; VAR reply: TLookupReply): OSStatus;
{	-------------------------------------------------------------------------
	Miscellaneous and generic functions
	------------------------------------------------------------------------- }
FUNCTION OTAllocMem(size: size_t): Ptr; C;
PROCEDURE OTFreeMem(memptr: UNIV Ptr); C;
PROCEDURE OTDelay(seconds: UInt32);
PROCEDURE OTIdle;
	
FUNCTION OTCreateConfiguration(path: ConstCStringPtr): OTConfigurationPtr;
FUNCTION OTCloneConfiguration(cfig: OTConfigurationPtr): OTConfigurationPtr;
PROCEDURE OTDestroyConfiguration(cfig: OTConfigurationPtr);
FUNCTION OTCreateOptions(endPtName: ConstCStringPtr; strPtr: CStringPtr; VAR buf: TNetbuf): OSStatus;
FUNCTION OTCreateOptionString(endPtName: ConstCStringPtr; VAR opt: TOption; bufEnd: UNIV Ptr; strPTr: CStringPtr; stringSize: size_t): OSStatus;
FUNCTION OTNextOption(VAR buffer: UInt8; buflen: UInt32; VAR prevOptPtr: TOption): OSStatus;
	
TYPE
	TOptionPtr = ^TOption;


FUNCTION OTFindOption(VAR buffer: UInt8; buflen: UInt32; level: OTXTILevel; name: OTXTIName): TOptionPtr;
{$ENDC}

PROCEDURE OTMemcpy(dest: UNIV Ptr; src: UNIV Ptr; nBytes: size_t); C;
FUNCTION OTMemcmp(mem1: UNIV Ptr; mem2: UNIV Ptr; nBytes: size_t): BOOLEAN; C;
PROCEDURE OTMemmove(dest: UNIV Ptr; src: UNIV Ptr; nBytes: size_t); C;
PROCEDURE OTMemzero(dest: UNIV Ptr; nBytes: size_t); C;
PROCEDURE OTMemset(dest: UNIV Ptr; toSet: uchar_p; nBytes: size_t); C;
FUNCTION OTStrLength(strPtr: ConstCStringPtr): size_t; C;
PROCEDURE OTStrCopy(strTo: CStringPtr; strFrom: ConstCStringPtr); C;
PROCEDURE OTStrCat(strTo: CStringPtr; strFrom: ConstCStringPtr); C;
FUNCTION OTStrEqual(strPtr1: ConstCStringPtr; strPtr2: ConstCStringPtr): BOOLEAN; C;
{	-------------------------------------------------------------------------
	** Time functions
	**	
	**	OTGetTimeStamp returns time in "tick" numbers, stored in 64 bits.
	**	This timestamp can be used as a base number for calculating elapsed 
	**	time.
	**	OTSubtractTimeStamps returns a pointer to the "result" parameter.
	**		
	**	OTGetClockTimeInSecs returns time since Open Transport was initialized
	**		in seconds.
	------------------------------------------------------------------------- }
	
TYPE
	OTTimeStamp = UnsignedWide;

	OTTimeStampPtr = ^OTTimeStamp;


PROCEDURE OTGetTimeStamp(VAR stamp: OTTimeStamp); C;
FUNCTION OTSubtractTimeStamps(VAR result: OTTimeStamp; VAR startTime: OTTimeStamp; VAR endTime: OTTimeStamp): OTTimeStampPtr; C;
FUNCTION OTTimeStampInMilliseconds(VAR delta: OTTimeStamp): UInt32; C;
FUNCTION OTTimeStampInMicroseconds(VAR delta: OTTimeStamp): UInt32; C;
FUNCTION OTElapsedMilliseconds(VAR startTime: OTTimeStamp): UInt32; C;
FUNCTION OTElapsedMicroseconds(VAR startTime: OTTimeStamp): UInt32; C;
FUNCTION OTGetClockTimeInSecs: UInt32; C;
{	-------------------------------------------------------------------------
	** OTLIFO
	**
	** These are functions to implement a LIFO list that is interrupt-safe.
	** The only function which is not is OTReverseList.  Normally, you create
	** a LIFO list, populate it at interrupt time, and then use OTLIFOStealList
	** to atomically remove the list, and OTReverseList to flip the list so that
	** it is a FIFO list, which tends to be more useful.
	------------------------------------------------------------------------- }
	
TYPE
	OTLinkPtr = ^OTLink;

	OTLIFO = RECORD
		fHead:					^OTLink;
	END;

	OTLink = RECORD
		fNext:					^OTLink;
	END;

{}
{ This function puts "object" on the listHead, and places the}
{ previous value at listHead into the pointer at "object" plus}
{ linkOffset.}
{}

PROCEDURE OTEnqueue(listHead: UNIV Ptr; object: UNIV Ptr; linkOffset: size_t); C;
{}
{ This function returns the head object of the list, and places}
{ the pointer at "object" + linkOffset into the listHead}
{}
FUNCTION OTDequeue(listHead: UNIV Ptr; linkOffset: size_t): Ptr; C;
{}
{ This function atomically enqueues the link onto the list}
{}
PROCEDURE OTLIFOEnqueue(VAR list: OTLIFO; VAR link: OTLink); C;
{}
{ This function atomically dequeues the first element}
{ on the list}
{}
FUNCTION OTLIFODequeue(VAR list: OTLIFO): OTLinkPtr; C;
FUNCTION OTLIFOStealList(VAR list: OTLIFO): OTLinkPtr; C;
FUNCTION OTReverseList(VAR list: OTLink): OTLinkPtr; C;

TYPE
	OTList = RECORD
		fHead:					^OTLink;
	END;

	OTListSearchProcPtr = ProcPtr;  { FUNCTION (ref: UNIV Ptr; VAR linkToCheck: OTLink): BOOLEAN; }

{}
{ Add the link to the list at the front}
{}

PROCEDURE OTAddFirst(VAR list: OTList; VAR link: OTLink); C;
{}
{ Add the link to the list at the end}
{}
PROCEDURE OTAddLast(VAR list: OTList; VAR link: OTLink); C;
{}
{ Remove the first link from the list}
{}
FUNCTION OTRemoveFirst(VAR list: OTList): OTLinkPtr; C;
FUNCTION OTRemoveLast(VAR list: OTList): OTLinkPtr; C;
FUNCTION OTGetFirst(VAR list: OTList): OTLinkPtr; C;
FUNCTION OTGetLast(VAR list: OTList): OTLinkPtr; C;
FUNCTION OTIsInList(VAR list: OTList; VAR link: OTLink): BOOLEAN; C;
{}
{ Find a link in the list which matches the search criteria}
{ established by the search proc and the refPtr.  This is done}
{ by calling the search proc, passing it the refPtr and each}
{ link in the list, until the search proc returns true.}
{ NULL is returned if the search proc never returned true.}
{}
FUNCTION OTFindLink(VAR listPtr: OTList; procPtr: OTListSearchProcPtr; refPtr: UNIV Ptr): OTLink; C;
{}
{ Remove the specified link from the list, returning true if it was found}
{}
FUNCTION OTRemoveLink(VAR listPtr: OTList; VAR linkPtr: OTLink): BOOLEAN; C;
{}
{ Similar to OTFindLink, but it also removes it from the list.}
{}
FUNCTION OTFindAndRemoveLink(VAR list: OTList; proc: OTListSearchProcPtr; refPtr: UNIV Ptr): OTLinkPtr; C;
FUNCTION OTGetIndexedLink(VAR list: OTList; index: size_t): OTLinkPtr; C;
	
TYPE
	OTLock = UInt8;


FUNCTION OTAtomicSetBit(VAR ptr: UInt8; len: size_t): BOOLEAN; C;
FUNCTION OTAtomicClearBit(VAR ptr: UInt8; len: size_t): BOOLEAN; C;
FUNCTION OTAtomicTestBit(VAR ptr: UInt8; len: size_t): BOOLEAN; C;
{}
{ WARNING! void* and UInt32 locations MUST be on 4-byte boundaries.}
{			UInt16 locations must not cross a 4-byte boundary.}
{}
FUNCTION OTCompareAndSwapPtr(oldValue: UNIV Ptr; newValue: UNIV Ptr; location: UNIV Ptr): BOOLEAN; C;
FUNCTION OTCompareAndSwap32(oldValue: UInt32; newValue: UInt32; VAR location: UInt32): BOOLEAN; C;
FUNCTION OTCompareAndSwap16(oldValue: UInt32; newValue: UInt32; VAR location: UInt16): BOOLEAN; C;
FUNCTION OTCompareAndSwap8(oldValue: UInt32; newValue: UInt32; VAR location: UInt8): BOOLEAN; C;
{}
{ WARNING! UInt32 locations MUST be on 4-byte boundaries.}
{			UInt16 locations must not cross a 4-byte boundary.}
{}
FUNCTION OTAtomicAdd32(val: SInt32; VAR ptr: SInt32): SInt32; C;
FUNCTION OTAtomicAdd16(val: SInt16; VAR ptr: SInt16): SInt16; C;
FUNCTION OTAtomicAdd8(val: ByteParameter; VAR ptr: SInt8): SInt8; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OpenTransportIncludes}

{$ENDC} {__OPENTRANSPORT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
