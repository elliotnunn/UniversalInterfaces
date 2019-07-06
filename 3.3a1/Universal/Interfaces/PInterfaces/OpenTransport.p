{
 	File:		OpenTransport.p
 
 	Contains:	Open Transport client interface file.  This contains all the client APIs
 
 	Version:	Technology:	Open Transport 1.3
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1985-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
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




{
   The following table shows how to map from the old (pre-Universal
   Interfaces) header file name to the equivalent Universal Interfaces
   header file name.
  	Old Header				New Header
  	----------				----------
  	cred.h					OpenTransportProtocol.h
  	dlpi.h					OpenTransportProtocol.h
  	miioccom.h				OpenTransportProtocol.h
  	mistream.h				OpenTransportProtocol.h/OpenTransportKernel.h
  	modnames.h				OpenTransportProtocol.h
  	OpenTptAppleTalk.h		OpenTransportProviders.h
  	OpenTptClient.h			OpenTransportProtocol.h
  	OpenTptCommon.h			OpenTransportProtocol.h
  	OpenTptConfig.h			OpenTransportProtocol.h
  	OpenTptDevLinks.h		OpenTransportProviders.h
  	OpenTptInternet.h		OpenTransportProviders.h
  	OpenTptISDN.h			OpenTransportProviders.h
  	OpenTptLinks.h			OpenTransportProviders.h
  	OpenTptModule.h			OpenTransportKernel.h
  	OpenTptPCISupport.h		OpenTransportKernel.h
  	OpenTptSerial.h			OpenTransportProviders.h
  	OpenTptXTI.h			OpenTransportUNIX.r
  	OpenTransport.h			OpenTransport.h
  	OpenTransport.r			OpenTransport.r
  	OTConfig.r				OpenTransportProtocol.r
  	OTDebug.h				OpenTransport.h
  	OTSharedLibs.h			OpenTransportProviders.h
  	strlog.h				OpenTransportProtocol.h/OpenTransportKernel.h
  	stropts.h				OpenTransportProtocol.h/OpenTransportUNIX.h
  	strstat.h				OpenTransportProtocol.h
  	tihdr.h					OpenTransportProtocol.h
}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}




{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{$ifc not undefined __MWERKS and TARGET_CPU_68K}
	{$pragmac d0_pointers on}
{$endc}

{  ***** Setup Default Compiler Variables ***** }

{
   OTKERNEL is used to indicate whether the code is being built
   for the kernel environment.  It defaults to 0.  If you include
   "OpenTransportKernel.h" before including this file,
   it will be 1 and you will only be able to see stuff available
   to kernel code.
}

{$IFC UNDEFINED OTKERNEL }
{$SETC OTKERNEL := 0 }
{$ENDC}

{
   OTUNIXERRORS determines whether this file defines a bunch of
   common UNIX error codes, like EPERM.  Typically, client code does
   not want to do this because of the possibility of a clash with
   other code modules, like the standard C libraries, that also
   defines these routines.  However, client code can turn it on to
   get these definitions.  This might be done by protocol stack
   infrastructure, or some other low-level code.
   "OpenTransportKernel.i" sets this flag before include
   "OpenTransport.h" because kernel modules typically need these
   error codes.  Note that kernel modules shouldn't be including
   standard C libraries, so this is rarely a problem.
   In general, the clash between OT and standard C definitions
   of these error codes is rarely a problem becasue both OT
   and the C libraries define them to have the same value.  But
   I'm sure this check is useful to some people.
}
{$IFC UNDEFINED OTUNIXERRORS }
{$SETC OTUNIXERRORS := 0 }
{$ENDC}

{
   OTDEBUG is used to control the behaviour of the OT debugging
   macros.  If you set it to non-zero, the macros will generate code
   that drops you into the debugger.  If you set it to 0, or leave it
   undefined, the macros are compiled out.
   Setting up this compiler variable is a little tricky because previous
   versions of the OT interfaces used a different variable, qDebug.
   We replaced qDebug with OTDEBUG because qDebug does not fit into
   the OT namespace.  But I didn't want to break a lot of currently
   building code.  The following tricky compiler variable footwork
   avoids this.
   There are four outcomes when this code is compiled, depending on
   whether qDebug and OTDEBUG are defined beforehand.  The following
   table shows the outcome in each case.
   qDebug     OTDEBUG    Outcome       Explanation  
   ------     -------    -------       -----------
   defined    defined    OTDEBUG wins  Mixed legacy and new code, we believe the new code.
   defined    undefined  qDebug wins   Legacy code.
   undefined  defined    OTDEBUG wins  New code.
   undefined  undefined  no debugging  No debugging.
}

{$IFC NOT UNDEFINED qDebug }
{$IFC UNDEFINED OTDEBUG }
{$SETC OTDebug := qDebug }
{$ENDC}
{$ENDC}

{$IFC UNDEFINED OTDEBUG }
{$SETC OTDEBUG := 0 }
{$ENDC}

{  Carbon Applications have some restrictions on using OT }
{$IFC UNDEFINED OTCARBONAPPLICATION }
{$SETC OTCARBONAPPLICATION := 0 }
{$ENDC}

{
   ***** Normalise 68K Calling C Conventions *****
   Define special types that handle the difference in parameter passing
   between different Mac OS C compilers when generating 68K code.  OT
   exports C calling conventions routines, and various C compilers use
   various different conventions.  Differences in the placement of the result
   are covered above, where we output pragma pointers_in_D0.  The other big
   difference is how the compilers pass integer parameters less than 32 bits.
   The MPW compiler always extends these to 32 bits; other compilers simply
   push a value of the appropriate size.  We overcome this difference by
   defining special OTFooParam types, which are only used when passing
   sub 32 bit values to routines.  They are always defined to a 32 bit
   size, which makes all the compilers do the same thing.
   One weird consequence of this is that in more strict type checking
   languages (eg Pascal) OTBooleanParam is not compatible with Boolean.
   Sorry.
}



{$IFC TARGET_CPU_68K }

TYPE
	OTUInt8Param						= UInt32;
	OTUInt16Param						= UInt32;
	OTSInt16Param						= SInt32;
	OTSInt8Param						= SInt32;
	OTBooleanParam						= SInt32;
{$ELSEC}

TYPE
	OTUInt8Param						= UInt8;
	OTUInt16Param						= UInt16;
	OTSInt16Param						= SInt16;
	OTSInt8Param						= SInt8;
	OTBooleanParam						= BOOLEAN;
{$ENDC}  {TARGET_CPU_68K}

	OTByteCount							= ByteCount;
	OTItemCount							= ItemCount;
	OTInt32								= SInt32;
	OTUInt32							= UInt32;

{
   I've removed the definitions of int_t and uint_t.
   These we previously used to allow Mentat interfaces, where ints
   must be 32 bits, to be exposed to developers.  As I've rolled
   all Mentat definitions into Apple header files, these types are
   no longer necessary.  It's likely that SInt32/UInt32 or
   OTInt32/OTUInt32 will meet your needs better.
}
{  ***** C++ Support ***** }

{
   Setup _MDECL to be _cdecl when compiling C++ code with
   compilers that support it, or nothing otherwise.
}


{  ***** Shared Library Prefixes ***** }


CONST
	kOTCFMClass					= 'otan';

{  ***** Miscellaneous Type Definitions ***** }

{  A millisecond timeout value }

TYPE
	OTTimeout							= UInt32;
{ An ID number in connections/transactions		}
	OTSequence							= SInt32;
{ An ID number for registered names			}
	OTNameID							= SInt32;
{
   A protocol-specific reason code for failure.
   Usually a Unix-style positive error code.
}
	OTReason							= SInt32;
{  Number of outstanding connection requests at a time. }
	OTQLen								= UInt32;
{  Will become internationalizeable shortly (yeah, right). }
	OTClientName						= ^UInt8;
{  The command code in STREAMS messages. }
	OTCommand							= SInt32;
{  value describing a client }
	OTClient = ^LONGINT; { an opaque 32-bit type }
{  ***** Debugging Macros ***** }

{  Debugging macros are only available in the C header file.  Sorry. }

{  ***** Open Transport Gestalt ***** }


CONST
	gestaltOpenTpt				= 'otan';						{  Defined by all versions, response is defined below. }
	gestaltOpenTptVersions		= 'otvr';						{  Defined by OT 1.1 and higher, response is NumVersion. }

	gestaltOpenTptPresentMask	= $00000001;
	gestaltOpenTptLoadedMask	= $00000002;
	gestaltOpenTptAppleTalkPresentMask = $00000004;
	gestaltOpenTptAppleTalkLoadedMask = $00000008;
	gestaltOpenTptTCPPresentMask = $00000010;
	gestaltOpenTptTCPLoadedMask	= $00000020;
	gestaltOpenTptIPXSPXPresentMask = $00000040;
	gestaltOpenTptIPXSPXLoadedMask = $00000080;
	gestaltOpenTptPresentBit	= 0;
	gestaltOpenTptLoadedBit		= 1;
	gestaltOpenTptAppleTalkPresentBit = 2;
	gestaltOpenTptAppleTalkLoadedBit = 3;
	gestaltOpenTptTCPPresentBit	= 4;
	gestaltOpenTptTCPLoadedBit	= 5;
	gestaltOpenTptIPXSPXPresentBit = 6;
	gestaltOpenTptIPXSPXLoadedBit = 7;

{
   ***** Flags Used When Opening Providers *****
   Important
   OT does not currently support any of these flags.  You should
   always pass 0 to a parameter of type OTOpenFlags.  If you need
   to modify the mode of operation of a provider, use OTSetBlocking,
   OTSetSynchronous, etc.
}


TYPE
	OTOpenFlags							= UInt32;
{  Rename constants to avoid conflict with BSD system headers }

CONST
	kO_ASYNC					= $01;
	kO_NDELAY					= $04;
	kO_NONBLOCK					= $04;

	O_ASYNC						= $01;
	O_NDELAY					= $04;
	O_NONBLOCK					= $04;


{  ***** UNIX-Style Error Codes ***** }


TYPE
	OTUnixErr							= UInt16;
{
   These definitions are only compiled if you're building kernel code
   or you explicit request them by setting OTUNIXERRORS.  See the
   description of these compiler variables, given above.
}
{$IFC OTKERNEL OR OTUNIXERRORS }
{
   There may be some error code confusions with other compiler vendor header
   files - However, these match both MPW and AIX definitions.
}
{
   First we undefine the #defined ones we know about so that we can put them
   in an enum.  Of course, this is only going to work in C, but hopefully
   other languages won't have these symbols overloaded.
}


CONST
	EPERM						= 1;							{  Permission denied					 }
	ENOENT						= 2;							{  No such file or directory			 }
	ENORSRC						= 3;							{  No such resource						 }
	EINTR						= 4;							{  Interrupted system service			 }
	EIO							= 5;							{  I/O error							 }
	ENXIO						= 6;							{  No such device or address			 }
	EBADF						= 9;							{  Bad file number						 }
	EAGAIN						= 11;							{  Try operation again later			 }
	ENOMEM						= 12;							{  Not enough space						 }
	EACCES						= 13;							{  Permission denied					 }
	EFAULT						= 14;							{  Bad address							 }
	EBUSY						= 16;							{  Device or resource busy				 }
	EEXIST						= 17;							{  File exists							 }
	ENODEV						= 19;							{  No such device						 }
	EINVAL						= 22;							{  Invalid argument						 }
	ENOTTY						= 25;							{  Not a character device				 }
	EPIPE						= 32;							{  Broken pipe							 }
	ERANGE						= 34;							{  Math result not representable		 }
	EDEADLK						= 35;							{  Call would block so was aborted		 }
	EWOULDBLOCK					= 35;							{  Or a deadlock would occur			 }
	EALREADY					= 37;
	ENOTSOCK					= 38;							{  Socket operation on non-socket		 }
	EDESTADDRREQ				= 39;							{  Destination address required			 }
	EMSGSIZE					= 40;							{  Message too long						 }
	EPROTOTYPE					= 41;							{  Protocol wrong type for socket		 }
	ENOPROTOOPT					= 42;							{  Protocol not available				 }
	EPROTONOSUPPORT				= 43;							{  Protocol not supported				 }
	ESOCKTNOSUPPORT				= 44;							{  Socket type not supported			 }
	EOPNOTSUPP					= 45;							{  Operation not supported on socket	 }
	EADDRINUSE					= 48;							{  Address already in use				 }
	EADDRNOTAVAIL				= 49;							{  Can't assign requested address		 }
	ENETDOWN					= 50;							{  Network is down						 }
	ENETUNREACH					= 51;							{  Network is unreachable				 }
	ENETRESET					= 52;							{  Network dropped connection on reset	 }
	ECONNABORTED				= 53;							{  Software caused connection abort		 }
	ECONNRESET					= 54;							{  Connection reset by peer				 }
	ENOBUFS						= 55;							{  No buffer space available			 }
	EISCONN						= 56;							{  Socket is already connected			 }
	ENOTCONN					= 57;							{  Socket is not connected				 }
	ESHUTDOWN					= 58;							{  Can't send after socket shutdown		 }
	ETOOMANYREFS				= 59;							{  Too many references: can't splice	 }
	ETIMEDOUT					= 60;							{  Connection timed out					 }
	ECONNREFUSED				= 61;							{  Connection refused					 }
	EHOSTDOWN					= 64;							{  Host is down							 }
	EHOSTUNREACH				= 65;							{  No route to host						 }
	EPROTO						= 70;							{  STREAMS protocol error				 }
	ETIME						= 71;							{  ••• fill in remainder •••			 }
	ENOSR						= 72;
	EBADMSG						= 73;
	ECANCEL						= 74;
	ENOSTR						= 75;
	ENODATA						= 76;
	EINPROGRESS					= 77;
	ESRCH						= 78;
	ENOMSG						= 79;
	ELASTERRNO					= 79;

{$ENDC}

{  ***** Open Transport/XTI Error codes ***** }

TYPE
	OTXTIErr							= UInt16;

CONST
	TSUCCESS					= 0;							{  No Error occurred						 }
	TBADADDR					= 1;							{  A Bad address was specified				 }
	TBADOPT						= 2;							{  A Bad option was specified				 }
	TACCES						= 3;							{  Missing access permission				 }
	TBADF						= 4;							{  Bad provider reference					 }
	TNOADDR						= 5;							{  No address was specified					 }
	TOUTSTATE					= 6;							{  Call issued in wrong state				 }
	TBADSEQ						= 7;							{  Sequence specified does not exist		 }
	TSYSERR						= 8;							{  A system error occurred					 }
	TLOOK						= 9;							{  An event occurred - call Look()			 }
	TBADDATA					= 10;							{  An illegal amount of data was specified	 }
	TBUFOVFLW					= 11;							{  Passed buffer not big enough				 }
	TFLOW						= 12;							{  Provider is flow-controlled				 }
	TNODATA						= 13;							{  No data available for reading			 }
	TNODIS						= 14;							{  No disconnect indication available		 }
	TNOUDERR					= 15;							{  No Unit Data Error indication available	 }
	TBADFLAG					= 16;							{  A Bad flag value was supplied			 }
	TNOREL						= 17;							{  No orderly release indication available	 }
	TNOTSUPPORT					= 18;							{  Command is not supported					 }
	TSTATECHNG					= 19;							{  State is changing - try again later		 }
	TNOSTRUCTYPE				= 20;							{  Bad structure type requested for OTAlloc	 }
	TBADNAME					= 21;							{  A bad endpoint name was supplied			 }
	TBADQLEN					= 22;							{  A Bind to an in-use address with qlen > 0 }
	TADDRBUSY					= 23;							{  Address requested is already in use		 }
	TINDOUT						= 24;							{  Accept failed because of pending listen	 }
	TPROVMISMATCH				= 25;							{  Tried to accept on incompatible endpoint	 }
	TRESQLEN					= 26;
	TRESADDR					= 27;
	TQFULL						= 28;
	TPROTO						= 29;							{  An unspecified provider error occurred	 }
	TBADSYNC					= 30;							{  A synchronous call at interrupt time		 }
	TCANCELED					= 31;							{  The command was cancelled				 }
	TLASTXTIERROR				= 31;

{
   ***** Mac OS Error Codes *****
   Most OT client routines return an OSStatus error code, a 32 bit type
   defined in "MacTypes.h".  The OT-unique error code values are
   defined below.  Many of these are generated by remapping XTI error
   codes (Txxxx) and UNIX error codes (Exxxx) to a reserved range
   in the OSStatus space.
   Some routines return an OTResult type, indicating
   that the routine might fail with a negative error, succeed with noErr,
   or possible return a positive value indicating some status.
}


TYPE
	OTResult							= SInt32;

CONST
	kOTNoError					= 0;							{  No Error occurred								 }
	kOTOutOfMemoryErr			= -3211;						{  OT ran out of memory, may be a temporary			 }
	kOTNotFoundErr				= -3201;						{  OT generic not found error						 }
	kOTDuplicateFoundErr		= -3216;						{  OT generic duplicate found error					 }
	kOTBadAddressErr			= -3150;						{  XTI2OSStatus(TBADADDR) A Bad address was specified				 }
	kOTBadOptionErr				= -3151;						{  XTI2OSStatus(TBADOPT) A Bad option was specified					 }
	kOTAccessErr				= -3152;						{  XTI2OSStatus(TACCES) Missing access permission					 }
	kOTBadReferenceErr			= -3153;						{  XTI2OSStatus(TBADF) Bad provider reference						 }
	kOTNoAddressErr				= -3154;						{  XTI2OSStatus(TNOADDR) No address was specified					 }
	kOTOutStateErr				= -3155;						{  XTI2OSStatus(TOUTSTATE) Call issued in wrong state					 }
	kOTBadSequenceErr			= -3156;						{  XTI2OSStatus(TBADSEQ) Sequence specified does not exist			 }
	kOTSysErrorErr				= -3157;						{  XTI2OSStatus(TSYSERR) A system error occurred					 }
	kOTLookErr					= -3158;						{  XTI2OSStatus(TLOOK) An event occurred - call Look()			 }
	kOTBadDataErr				= -3159;						{  XTI2OSStatus(TBADDATA) An illegal amount of data was specified	 }
	kOTBufferOverflowErr		= -3160;						{  XTI2OSStatus(TBUFOVFLW) Passed buffer not big enough				 }
	kOTFlowErr					= -3161;						{  XTI2OSStatus(TFLOW) Provider is flow-controlled				 }
	kOTNoDataErr				= -3162;						{  XTI2OSStatus(TNODATA) No data available for reading				 }
	kOTNoDisconnectErr			= -3163;						{  XTI2OSStatus(TNODIS) No disconnect indication available			 }
	kOTNoUDErrErr				= -3164;						{  XTI2OSStatus(TNOUDERR) No Unit Data Error indication available	 }
	kOTBadFlagErr				= -3165;						{  XTI2OSStatus(TBADFLAG) A Bad flag value was supplied				 }
	kOTNoReleaseErr				= -3166;						{  XTI2OSStatus(TNOREL) No orderly release indication available	 }
	kOTNotSupportedErr			= -3167;						{  XTI2OSStatus(TNOTSUPPORT) Command is not supported					 }
	kOTStateChangeErr			= -3168;						{  XTI2OSStatus(TSTATECHNG) State is changing - try again later		 }
	kOTNoStructureTypeErr		= -3169;						{  XTI2OSStatus(TNOSTRUCTYPE) Bad structure type requested for OTAlloc	 }
	kOTBadNameErr				= -3170;						{  XTI2OSStatus(TBADNAME) A bad endpoint name was supplied			 }
	kOTBadQLenErr				= -3171;						{  XTI2OSStatus(TBADQLEN) A Bind to an in-use addr with qlen > 0		 }
	kOTAddressBusyErr			= -3172;						{  XTI2OSStatus(TADDRBUSY) Address requested is already in use		 }
	kOTIndOutErr				= -3173;						{  XTI2OSStatus(TINDOUT) Accept failed because of pending listen	 }
	kOTProviderMismatchErr		= -3174;						{  XTI2OSStatus(TPROVMISMATCH) Tried to accept on incompatible endpoint	 }
	kOTResQLenErr				= -3175;						{  XTI2OSStatus(TRESQLEN)											 }
	kOTResAddressErr			= -3176;						{  XTI2OSStatus(TRESADDR)											 }
	kOTQFullErr					= -3177;						{  XTI2OSStatus(TQFULL)											 }
	kOTProtocolErr				= -3178;						{  XTI2OSStatus(TPROTO) An unspecified provider error occurred		 }
	kOTBadSyncErr				= -3179;						{  XTI2OSStatus(TBADSYNC) A synchronous call at interrupt time		 }
	kOTCanceledErr				= -3180;						{  XTI2OSStatus(TCANCELED) The command was cancelled					 }
	kEPERMErr					= -3200;						{  Permission denied					 }
	kENOENTErr					= -3201;						{  No such file or directory			 }
	kENORSRCErr					= -3202;						{  No such resource						 }
	kEINTRErr					= -3203;						{  Interrupted system service			 }
	kEIOErr						= -3204;						{  I/O error							 }
	kENXIOErr					= -3205;						{  No such device or address			 }
	kEBADFErr					= -3208;						{  Bad file number						 }
	kEAGAINErr					= -3210;						{  Try operation again later			 }
	kENOMEMErr					= -3211;						{  Not enough space						 }
	kEACCESErr					= -3212;						{  Permission denied					 }
	kEFAULTErr					= -3213;						{  Bad address							 }
	kEBUSYErr					= -3215;						{  Device or resource busy				 }
	kEEXISTErr					= -3216;						{  File exists							 }
	kENODEVErr					= -3218;						{  No such device						 }
	kEINVALErr					= -3221;						{  Invalid argument						 }
	kENOTTYErr					= -3224;						{  Not a character device				 }
	kEPIPEErr					= -3231;						{  Broken pipe							 }
	kERANGEErr					= -3233;						{  Message size too large for STREAM	 }
	kEWOULDBLOCKErr				= -3234;						{  Call would block, so was aborted		 }
	kEDEADLKErr					= -3234;						{  or a deadlock would occur			 }
	kEALREADYErr				= -3236;						{  										 }
	kENOTSOCKErr				= -3237;						{  Socket operation on non-socket		 }
	kEDESTADDRREQErr			= -3238;						{  Destination address required			 }
	kEMSGSIZEErr				= -3239;						{  Message too long						 }
	kEPROTOTYPEErr				= -3240;						{  Protocol wrong type for socket		 }
	kENOPROTOOPTErr				= -3241;						{  Protocol not available				 }
	kEPROTONOSUPPORTErr			= -3242;						{  Protocol not supported				 }
	kESOCKTNOSUPPORTErr			= -3243;						{  Socket type not supported			 }
	kEOPNOTSUPPErr				= -3244;						{  Operation not supported on socket	 }
	kEADDRINUSEErr				= -3247;						{  Address already in use				 }
	kEADDRNOTAVAILErr			= -3248;						{  Can't assign requested address		 }
	kENETDOWNErr				= -3249;						{  Network is down						 }
	kENETUNREACHErr				= -3250;						{  Network is unreachable				 }
	kENETRESETErr				= -3251;						{  Network dropped connection on reset	 }
	kECONNABORTEDErr			= -3252;						{  Software caused connection abort		 }
	kECONNRESETErr				= -3253;						{  Connection reset by peer				 }
	kENOBUFSErr					= -3254;						{  No buffer space available			 }
	kEISCONNErr					= -3255;						{  Socket is already connected			 }
	kENOTCONNErr				= -3256;						{  Socket is not connected				 }
	kESHUTDOWNErr				= -3257;						{  Can't send after socket shutdown		 }
	kETOOMANYREFSErr			= -3258;						{  Too many references: can't splice	 }
	kETIMEDOUTErr				= -3259;						{  Connection timed out					 }
	kECONNREFUSEDErr			= -3260;						{  Connection refused					 }
	kEHOSTDOWNErr				= -3263;						{  Host is down							 }
	kEHOSTUNREACHErr			= -3264;						{  No route to host						 }
	kEPROTOErr					= -3269;						{  ••• fill out missing codes •••		 }
	kETIMEErr					= -3270;						{  										 }
	kENOSRErr					= -3271;						{  										 }
	kEBADMSGErr					= -3272;						{  										 }
	kECANCELErr					= -3273;						{  										 }
	kENOSTRErr					= -3274;						{  										 }
	kENODATAErr					= -3275;						{  										 }
	kEINPROGRESSErr				= -3276;						{  										 }
	kESRCHErr					= -3277;						{  										 }
	kENOMSGErr					= -3278;						{  										 }
	kOTClientNotInittedErr		= -3279;						{  										 }
	kOTPortHasDiedErr			= -3280;						{  										 }
	kOTPortWasEjectedErr		= -3281;						{  										 }
	kOTBadConfigurationErr		= -3282;						{  										 }
	kOTConfigurationChangedErr	= -3283;						{  										 }
	kOTUserRequestedErr			= -3284;						{  										 }
	kOTPortLostConnection		= -3285;						{  										 }

{  ***** OTAddress ***** }

{
   OTAddress type defines the standard header for all OT address formats.
   It consists of one 16 bit integer, which defines the address format
   used, followed by an arbitrary number of bytes which are protocol-specific.
   Conceptually, all OT address formats are subtypes of this type,
   extended with fields that are specific to the protocol.  For example,
   OTInetAddress starts with the OTAddressType field and then continues
   to include a host IP address and a port number.
}

	kOTGenericName				= 0;							{  Protocol specific data is just a string, interpreted in a protocol-specific fashion. }


TYPE
	OTAddressType						= UInt16;
	OTAddressPtr = ^OTAddress;
	OTAddress = RECORD
		fAddressType:			OTAddressType;							{  The address format of this address... }
		fAddress:				SInt8;									{  ... followed by protocol specific address information. }
	END;

{
   ***** OTAlloc Constants *****
   Note:
   In general, Apple recommends that you avoid the OTAlloc call because
   using it extensively causes your program to allocate and deallocate
   many memory blocks, with each extra memory allocation costing time.
}
{
   OTStructType defines the structure type to be allocated using the OTAlloc
   call.
}

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


TYPE
	OTStructType						= UInt32;
{
   These values are used in the "fields" parameter of the OTAlloc call
   to define which fields of the structure should be allocated.
}

CONST
	T_ADDR						= $01;
	T_OPT						= $02;
	T_UDATA						= $04;
	T_ALL						= $FFFF;


TYPE
	OTFieldsType						= UInt32;
{  ***** OTFlags ***** }
{
   This type is used to describe bitwise flags in OT data structures
   and parameters.  Think of it as the OT analogue to the OptionBits
   type in "MacTypes.h".
}

	OTFlags								= UInt32;
{
   These flags are used when sending and receiving data.  The
   constants defined are masks.
}

CONST
	T_MORE						= $0001;						{  More data to come in message		 }
	T_EXPEDITED					= $0002;						{  Data is expedited, if possible	 }
	T_ACKNOWLEDGED				= $0004;						{  Acknowledge transaction			 }
	T_PARTIALDATA				= $0008;						{  Partial data - more coming		 }
	T_NORECEIPT					= $0010;						{  No event on transaction done		 }
	T_TIMEDOUT					= $0020;						{  Reply timed out					 }

{  These flags are used in the TOptMgmt structure to request services. }

	T_NEGOTIATE					= $0004;
	T_CHECK						= $0008;
	T_DEFAULT					= $0010;
	T_CURRENT					= $0080;

{
   These flags are used in the TOptMgmt and TOption structures to
   return results.
}

	T_SUCCESS					= $0020;
	T_FAILURE					= $0040;
	T_PARTSUCCESS				= $0100;
	T_READONLY					= $0200;
	T_NOTSUPPORT				= $0400;

{
   ***** OTBand *****
   A band is a STREAMS concepts which defines the priority of data
   on a stream.  Although this type is defined as a 32 bit number
   for efficiency's sake, bands actually only range from 0 to 255. 
   Typically band 0 is used for normal data and band 1 for expedited data.
}

TYPE
	OTBand								= UInt32;
{  ***** Object References ***** }
{
   The C header file has a special mechanism to define these
   types so that the object hierarchy is checked by the compiler,
   at least when you engage the C++ compiler.  This special
   case is not propagated to your language of choice.  All
   OT object references are completely opaque.
   See the C header file for more details.
}
	ProviderRef = ^LONGINT; { an opaque 32-bit type }
	EndpointRef = ^LONGINT; { an opaque 32-bit type }
	MapperRef = ^LONGINT; { an opaque 32-bit type }

CONST
	kOTInvalidRef				= 0;
	kOTInvalidProviderRef		= 0;
	kOTInvalidEndpointRef		= 0;
	kOTInvalidMapperRef			= 0;

{  ***** Event Codes ***** }
{
   OT event codes values for Open Transport.  These are the event codes that
   are sent to notification routine (notifiers).
}


TYPE
	OTEventCode							= UInt32;
{
   Events are divided into numerous categories:
   
   1. (0x0000xxxx) The core XTI events have identifiers of the form
  	  T_XXXX.  These signal that an XTI event has occured on a stream.
   2. (0x1000xxxx) Private events are reserved for protocol specific
      events.  Each protocol stack defines them as appropriate for
      its own usage.
   3. (0x2000xxxxx) Completion events have identifiers of the form
      T_XXXXCOMPLETE.  These signal the completion of some asynchronous
      API routine, and are only delivered if the endpoint is in asynchronous
      mode.
   4. (0x2100xxxx) Stream events are generally encountered when programming
      the raw streams API and indicate some event on a raw stream, or
      some other event of interest in the STREAMS kernel.
   5. (0x2200xxxx) Signal events indicate that a signal has arrived on
      a raw stream.  See "Signal Values" for details.
   6. (0x2300xxxx) General provider events that might be generated by any
      provider.
   7. (0x2400xxxx) System events sent to all providers.
   8. (0x2500xxxx) System events sent to registered clients.
   9. (0x2600xxxx) System events used by configurators.
}
{
   All event codes not described here are reserved by Apple.  If you receive
   an event code you do not understand, ignore it!
}


CONST
	T_LISTEN					= $0001;						{  An connection request is available 	 }
	T_CONNECT					= $0002;						{  Confirmation of a connect request	 }
	T_DATA						= $0004;						{  Standard data is available			 }
	T_EXDATA					= $0008;						{  Expedited data is available			 }
	T_DISCONNECT				= $0010;						{  A disconnect is available			 }
	T_ERROR						= $0020;						{  obsolete/unused in library			 }
	T_UDERR						= $0040;						{  A Unit Data Error has occurred		 }
	T_ORDREL					= $0080;						{  An orderly release is available		 }
	T_GODATA					= $0100;						{  Flow control lifted on standard data	 }
	T_GOEXDATA					= $0200;						{  Flow control lifted on expedited data }
	T_REQUEST					= $0400;						{  An Incoming request is available		 }
	T_REPLY						= $0800;						{  An Incoming reply is available		 }
	T_PASSCON					= $1000;						{  State is now T_DATAXFER				 }
	T_RESET						= $2000;						{  Protocol has been reset				 }
	kPRIVATEEVENT				= $10000000;					{  Base of the private event range. }
	kCOMPLETEEVENT				= $20000000;					{  Base of the completion event range. }
	T_BINDCOMPLETE				= $20000001;					{  Bind call is complete				 }
	T_UNBINDCOMPLETE			= $20000002;					{  Unbind call is complete				 }
	T_ACCEPTCOMPLETE			= $20000003;					{  Accept call is complete				 }
	T_REPLYCOMPLETE				= $20000004;					{  SendReply call is complete			 }
	T_DISCONNECTCOMPLETE		= $20000005;					{  Disconnect call is complete			 }
	T_OPTMGMTCOMPLETE			= $20000006;					{  OptMgmt call is complete				 }
	T_OPENCOMPLETE				= $20000007;					{  An Open call is complete				 }
	T_GETPROTADDRCOMPLETE		= $20000008;					{  GetProtAddress call is complete		 }
	T_RESOLVEADDRCOMPLETE		= $20000009;					{  A ResolveAddress call is complet		 }
	T_GETINFOCOMPLETE			= $2000000A;					{  A GetInfo call is complete			 }
	T_SYNCCOMPLETE				= $2000000B;					{  A Sync call is complete				 }
	T_MEMORYRELEASED			= $2000000C;					{  No-copy memory was released			 }
	T_REGNAMECOMPLETE			= $2000000D;					{  A RegisterName call is complete		 }
	T_DELNAMECOMPLETE			= $2000000E;					{  A DeleteName call is complete		 }
	T_LKUPNAMECOMPLETE			= $2000000F;					{  A LookupName call is complete		 }
	T_LKUPNAMERESULT			= $20000010;					{  A LookupName is returning a name		 }
	kOTSyncIdleEvent			= $20000011;					{  Synchronous call Idle event			 }
	kSTREAMEVENT				= $21000000;					{  Base of the raw stream event range. }
	kOTReservedEvent1			= $21000001;					{  reserved for internal use by OT		 }
	kGetmsgEvent				= $21000002;					{  A GetMessage call is complete		 }
	kStreamReadEvent			= $21000003;					{  A Read call is complete				 }
	kStreamWriteEvent			= $21000004;					{  A Write call is complete				 }
	kStreamIoctlEvent			= $21000005;					{  An Ioctl call is complete			 }
	kOTReservedEvent2			= $21000006;					{  reserved for internal use by OT		 }
	kStreamOpenEvent			= $21000007;					{  An OpenStream call is complete		 }
	kPollEvent					= $21000008;					{  A Poll call is complete				 }
	kOTReservedEvent3			= $21000009;					{  reserved for internal use by OT		 }
	kOTReservedEvent4			= $2100000A;					{  reserved for internal use by OT		 }
	kOTReservedEvent5			= $2100000B;					{  reserved for internal use by OT		 }
	kOTReservedEvent6			= $2100000C;					{  reserved for internal use by OT		 }
	kOTReservedEvent7			= $2100000D;					{  reserved for internal use by OT		 }
	kOTReservedEvent8			= $2100000E;					{  reserved for internal use by OT		 }
	kSIGNALEVENT				= $22000000;					{  A signal has arrived on a raw stream, see "Signal Values" below. }
	kPROTOCOLEVENT				= $23000000;					{  Some event from the protocols		 }
	kOTProviderIsDisconnected	= $23000001;					{  Provider is temporarily off-line		 }
	kOTProviderIsReconnected	= $23000002;					{  Provider is now back on-line			 }
	kOTProviderWillClose		= $24000001;					{  Provider will close immediately		 }
	kOTProviderIsClosed			= $24000002;					{  Provider was closed					 }
	kOTPortDisabled				= $25000001;					{  Port is now disabled, result is 0, cookie is port ref  }
	kOTPortEnabled				= $25000002;					{  Port is now enabled, result is 0, cookie is port ref  }
	kOTPortOffline				= $25000003;					{  Port is now offline, result is 0, cookie is port ref  }
	kOTPortOnline				= $25000004;					{  Port is now online, result is 0, cookie is port ref  }
	kOTClosePortRequest			= $25000005;					{  Request to close/yield, result is reason, cookie is OTPortCloseStruct*  }
	kOTYieldPortRequest			= $25000005;					{  Request to close/yield, result is reason, cookie is OTPortCloseStruct*  }
	kOTNewPortRegistered		= $25000006;					{  New port has been registered, cookie is port ref  }
	kOTPortNetworkChange		= $25000007;					{  Port may have moved to a new network, result is 0, cookie is port ref  }
	kOTConfigurationChanged		= $26000001;					{  Protocol configuration changed		 }
	kOTSystemSleep				= $26000002;
	kOTSystemShutdown			= $26000003;
	kOTSystemAwaken				= $26000004;
	kOTSystemIdle				= $26000005;
	kOTSystemSleepPrep			= $26000006;
	kOTSystemShutdownPrep		= $26000007;
	kOTSystemAwakenPrep			= $26000008;

{
   ***** Signal Values *****
   Signals that are generated by a raw stream.  When writing a notifier
   for a raw stream, add these values to kSIGNALEVENT to determine what
   event you are receiving.
}

	kSIGHUP						= 1;
	kSIGURG						= 16;
	kSIGPOLL					= 30;

	SIGHUP						= 1;
	SIGURG						= 16;
	SIGPOLL						= 30;


{
   ***** Notifier Type Definition *****
   Open Transport notifiers must conform to the OTNotifyProcPtr prototype.
   Even though a OTNotifyUPP is a OTNotifyProcPtr on pre-Carbon system,
   use NewOTNotifyUPP() and friends to make your source code portable to OS X and Carbon.
}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	OTNotifyProcPtr = PROCEDURE(contextPtr: UNIV Ptr; code: OTEventCode; result: OTResult; cookie: UNIV Ptr);
{$ELSEC}
	OTNotifyProcPtr = ProcPtr;
{$ENDC}

	OTNotifyUPP = ^LONGINT;  { an opaque UPP }

CONST
	uppOTNotifyProcInfo = $00003FC0;

FUNCTION NewOTNotifyUPP(userRoutine: OTNotifyProcPtr): OTNotifyUPP; { old name was NewOTNotifyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeOTNotifyUPP(userUPP: OTNotifyUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeOTNotifyUPP(contextPtr: UNIV Ptr; code: OTEventCode; result: OTResult; cookie: UNIV Ptr; userRoutine: OTNotifyUPP); { old name was CallOTNotifyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{  ***** Option Management Definitions ***** }
{  The XTI Level number of a protocol. }

CONST
	XTI_GENERIC					= $FFFF;						{  level for XTI options  }


TYPE
	OTXTILevel							= UInt32;
{  The XTI name of a protocol option. }
	OTXTIName							= UInt32;
{  XTI names for options used with XTI_GENERIC above }

CONST
	XTI_DEBUG					= $0001;
	XTI_LINGER					= $0080;
	XTI_RCVBUF					= $1002;
	XTI_RCVLOWAT				= $1004;
	XTI_SNDBUF					= $1001;
	XTI_SNDLOWAT				= $1003;
	XTI_PROTOTYPE				= $1005;
	OPT_CHECKSUM				= $0600;						{  Set checksumming = UInt32 - 0 or 1) }
	OPT_RETRYCNT				= $0601;						{  Set a retry counter = UInt32 (0 = infinite) }
	OPT_INTERVAL				= $0602;						{  Set a retry interval = UInt32 milliseconds }
	OPT_ENABLEEOM				= $0603;						{  Enable the EOM indication = UInt8 (0 or 1) }
	OPT_SELFSEND				= $0604;						{  Enable Self-sending on broadcasts = UInt32 (0 or 1) }
	OPT_SERVERSTATUS			= $0605;						{  Set Server Status (format is proto dependent) }
	OPT_ALERTENABLE				= $0606;						{  Enable/Disable protocol alerts }
	OPT_KEEPALIVE				= $0008;						{  See t_keepalive structure }

{  ***** Ioctl Definitions ***** }

{
   All OT ioctl numbers are formed using the MIOC_CMD macro,
   which divides the ioctl space by protocol space (the
   first parameter) and ioctl number within that protocol
   space (the second parameter).  This macro is only available
   to C users but it's relatively easy to synthesise its
   results in other languages.
}

{  The following is a registry of the ioctls protocol spaces. }

	MIOC_STREAMIO				= 65;							{  Basic Stream ioctl() cmds - I_PUSH, I_LOOK, etc.  }
	MIOC_TMOD					= 97;							{  ioctl's for tmod test module 		 }
	MIOC_STRLOG					= 98;							{  ioctl's for Mentat's log device 		 }
	MIOC_ND						= 99;							{  ioctl's for Mentat's nd device 		 }
	MIOC_ECHO					= 100;							{  ioctl's for Mentat's echo device 	 }
	MIOC_TLI					= 101;							{  ioctl's for Mentat's timod module 	 }
	MIOC_RESERVEDf				= 102;							{  reserved, used by SVR4 FIOxxx		 }
	MIOC_SAD					= 103;							{  ioctl's for Mentat's sad module 		 }
	MIOC_ARP					= 104;							{  ioctl's for Mentat's arp module 		 }
	MIOC_HAVOC					= 72;							{  Havoc module ioctls. 				 }
	MIOC_RESERVEDi				= 105;							{  reserved, used by SVR4 SIOCxxx		 }
	MIOC_SIOC					= 106;							{  sockio.h socket ioctl's 				 }
	MIOC_TCP					= 107;							{  tcp.h ioctl's 						 }
	MIOC_DLPI					= 108;							{  dlpi.h additions 					 }
	MIOC_SOCKETS				= 109;							{  Mentat sockmod ioctl's 				 }
	MIOC_IPX					= 111;							{  ioctls for IPX						 }
	MIOC_OT						= 79;							{  ioctls for Open Transport			 }
	MIOC_ATALK					= 84;							{  ioctl's for AppleTalk				 }
	MIOC_SRL					= 85;							{  ioctl's for Serial					 }
	MIOC_RESERVEDp				= 112;							{  reserved, used by SVR4				 }
	MIOC_RESERVEDr				= 114;							{  reserved, used by SVR4				 }
	MIOC_RESERVEDs				= 115;							{  reserved, used by SVR4				 }
	MIOC_CFIG					= 122;							{  ioctl's for private configuration  }

{  OT specific ioctls. }

	I_OTGetMiscellaneousEvents	= $4F01;						{  sign up for Misc Events					 }
	I_OTSetFramingType			= $4F02;						{  Set framing option for link				 }
	kOTGetFramingValue			= $FFFFFFFF;					{  Use this value to read framing			 }
	I_OTSetRawMode				= $4F03;						{  Set raw mode for link					 }
	kOTSetRecvMode				= $01;
	kOTSendErrorPacket			= $02;
	I_OTConnect					= $4F04;						{  Generic connect request for links		 }
	I_OTDisconnect				= $4F05;						{  Generic disconnect request for links		 }
	I_OTScript					= $4F06;						{  Send a script to a module				 }

{  Structure for the I_OTScript Ioctl. }


TYPE
	OTScriptInfoPtr = ^OTScriptInfo;
	OTScriptInfo = RECORD
		fScriptType:			UInt32;
		fTheScript:				Ptr;
		fScriptLength:			UInt32;
	END;

{
   ***** XTI States *****
   These are the potential values returned by OTGetEndpointState and OTSync
   which represent the XTI state of an endpoint.
}
	OTXTIStates 				= UInt32;
CONST
	T_UNINIT					= 0;							{  addition to standard xti.h	 }
	T_UNBND						= 1;							{  unbound						 }
	T_IDLE						= 2;							{  idle							 }
	T_OUTCON					= 3;							{  outgoing connection pending	 }
	T_INCON						= 4;							{  incoming connection pending	 }
	T_DATAXFER					= 5;							{  data transfer				 }
	T_OUTREL					= 6;							{  outgoing orderly release		 }
	T_INREL						= 7;							{  incoming orderly release		 }

{
   ***** General XTI Definitions *****
   These definitions are typically used during option management.
}

	T_YES						= 1;
	T_NO						= 0;
	T_UNUSED					= -1;
	T_NULL						= 0;
	T_ABSREQ					= $8000;

	T_UNSPEC					= $FFFFFFFD;
	T_ALLOPT					= 0;

{
   ***** OTConfiguration *****
   This is a "black box" structure used to define the configuration of a
   provider or endpoint.  This file defines a very limited set of operations
   on a configuration.  "OpenTransportClient.h" extends this with extra
   operations used by protocol stacks but not typically needed by clients.
}



TYPE
	OTConfigurationRef = ^LONGINT; { an opaque 32-bit type }

CONST
	kOTNoMemoryConfigurationPtr	= 0;
	kOTInvalidConfigurationPtr	= -1;

{  ***** Option Management Structures ***** }

{  This structure describes the contents of a single option in a buffer. }


TYPE
	TOptionHeaderPtr = ^TOptionHeader;
	TOptionHeader = RECORD
		len:					ByteCount;								{  total length of option				 }
																		{  = sizeof(TOptionHeader) + length		 }
																		{ 	 of option value in bytes			 }
		level:					OTXTILevel;								{  protocol affected					 }
		name:					OTXTIName;								{  option name							 }
		status:					UInt32;									{  status value							 }
	END;

{
   This structure describes the contents of a single option in a buffer.
   It differs from TOptionHeader in that it includes the value field,
   which acts as an unbounded array representing the value of the option.
}
	TOptionPtr = ^TOption;
	TOption = RECORD
		len:					ByteCount;								{  total length of option				 }
																		{  = sizeof(TOption) + length	 }
																		{ 	 of option value in bytes			 }
		level:					OTXTILevel;								{  protocol affected					 }
		name:					OTXTIName;								{  option name							 }
		status:					UInt32;									{  status value							 }
		value:					ARRAY [0..0] OF UInt32;					{  data goes here						 }
	END;

{  Some useful constants when manipulating option buffers. }

CONST
	kOTOptionHeaderSize			= 16;
	kOTBooleanOptionDataSize	= 4;
	kOTBooleanOptionSize		= 20;
	kOTOneByteOptionSize		= 17;
	kOTTwoByteOptionSize		= 18;
	kOTFourByteOptionSize		= 20;

{  t_kpalive is used with OPT_KEEPALIVE option. }


TYPE
	t_kpalivePtr = ^t_kpalive;
	t_kpalive = RECORD
		kp_onoff:				SInt32;									{  option on/off		 }
		kp_timeout:				SInt32;									{  timeout in minutes	 }
	END;

{  t_linger is used with XTI_LINGER option. }
	t_lingerPtr = ^t_linger;
	t_linger = RECORD
		l_onoff:				SInt32;									{  option on/off  }
		l_linger:				SInt32;									{  linger time  }
	END;

{
   ***** TEndpointInfo *****
   This structure is returned from the GetEndpointInfo call and contains
   information about an endpoint.  But first, some special flags and types.
}
{  Values returned in servtype field of TEndpointInfo. }

	OTServiceType 				= UInt32;
CONST
	T_COTS						= 1;							{  Connection-mode service								 }
	T_COTS_ORD					= 2;							{  Connection service with orderly release				 }
	T_CLTS						= 3;							{  Connectionless-mode service							 }
	T_TRANS						= 5;							{  Connection-mode transaction service					 }
	T_TRANS_ORD					= 6;							{  Connection transaction service with orderly release	 }
	T_TRANS_CLTS				= 7;							{  Connectionless transaction service					 }

{  Masks for the flags field of TEndpointInfo. }

	T_SENDZERO					= $0001;						{  supports 0-length TSDU's				 }
	T_XPG4_1					= $0002;						{  supports the GetProtAddress call		 }
	T_CAN_SUPPORT_MDATA			= $10000000;					{  support M_DATAs on packet protocols	 }
	T_CAN_RESOLVE_ADDR			= $40000000;					{  Supports ResolveAddress call			 }
	T_CAN_SUPPLY_MIB			= $20000000;					{  Supports SNMP MIB data				 }

{
   Special-case values for in the tsdu, etsdu, connect, and discon
   fields of TEndpointInfo.
}

	T_INFINITE					= -1;							{  supports infinit amounts of data		 }
	T_INVALID					= -2;							{  Does not support data transmission	 }


TYPE
	OTDataSize							= SInt32;
{  Now the TEndpointInfo structure proper. }
	TEndpointInfoPtr = ^TEndpointInfo;
	TEndpointInfo = RECORD
		addr:					OTDataSize;								{  Maximum size of an address			 }
		options:				OTDataSize;								{  Maximum size of options				 }
		tsdu:					OTDataSize;								{  Standard data transmit unit size		 }
		etsdu:					OTDataSize;								{  Expedited data transmit unit size	 }
		connect:				OTDataSize;								{  Maximum data size on connect			 }
		discon:					OTDataSize;								{  Maximum data size on disconnect		 }
		servtype:				OTServiceType;							{  service type							 }
		flags:					UInt32;									{  Flags (see above for values)			 }
	END;

{
   "OpenTransport.h" no longer defines "struct t_info".  We recommend
   that you use TEndpointInfo instead.  If this is impossible, use
   the definition of "struct t_info" in "OpenTransportXTI.h".
}
{  ***** OTPortRecord ***** }

{  Unique identifier for a port. }

	OTPortRef							= UInt32;
	OTPortRefPtr						= ^OTPortRef;

CONST
	kOTInvalidPortRef			= 0;

{  Valid values for the bus type element of an OTPortRef. }


TYPE
	OTBusType 					= UInt8;
CONST
	kOTUnknownBusPort			= 0;
	kOTMotherboardBus			= 1;
	kOTNuBus					= 2;
	kOTPCIBus					= 3;
	kOTGeoPort					= 4;
	kOTPCCardBus				= 5;
	kOTFireWireBus				= 6;
	kOTLastBusIndex				= 15;

{
   A couple of special values for the device type element of an
   OTPortRef.  See "OpenTransportDevices.h" for the standard values.
}


TYPE
	OTDeviceType 				= UInt16;
CONST
	kOTNoDeviceType				= 0;
	kOTADEVDevice				= 1;							{  An Atalk ADEV		 }
	kOTMDEVDevice				= 2;							{  A TCP/IP MDEV		 }
	kOTLocalTalkDevice			= 3;							{  LocalTalk			 }
	kOTIRTalkDevice				= 4;							{  IRTalk				 }
	kOTTokenRingDevice			= 5;							{  Token Ring			 }
	kOTISDNDevice				= 6;							{  ISDN					 }
	kOTATMDevice				= 7;							{  ATM					 }
	kOTSMDSDevice				= 8;							{  SMDS					 }
	kOTSerialDevice				= 9;							{  Serial 				 }
	kOTEthernetDevice			= 10;							{  Ethernet				 }
	kOTSLIPDevice				= 11;							{  SLIP Pseudo-device	 }
	kOTPPPDevice				= 12;							{  PPP Pseudo-device	 }
	kOTModemDevice				= 13;							{  Modem Pseudo-Device	 }
	kOTFastEthernetDevice		= 14;							{  100 MB Ethernet		 }
	kOTFDDIDevice				= 15;							{  FDDI					 }
	kOTIrDADevice				= 16;							{  IrDA Infrared		 }
	kOTATMSNAPDevice			= 17;							{  ATM SNAP emulation	 }
	kOTFibreChannelDevice		= 18;							{  Fibre Channel		 }
	kOTFireWireDevice			= 19;							{  FireWire link Device	 }
	kOTPseudoDevice				= 1023;							{  used where no other defined device type will work }
	kOTLastDeviceIndex			= 1022;

{  Special case values for the slot number element of an OTPortRef. }

	kOTLastSlotNumber			= 255;
	kOTLastOtherNumber			= 255;


TYPE
	OTSlotNumber						= UInt16;
{  Accessor functions for the various elements of the OTPortRef. }
FUNCTION OTCreatePortRef(busType: ByteParameter; devType: OTDeviceType; slot: OTSlotNumber; other: UInt16): OTPortRef;
FUNCTION OTGetDeviceTypeFromPortRef(ref: OTPortRef): OTDeviceType;
FUNCTION OTGetBusTypeFromPortRef(ref: OTPortRef): UInt16;
FUNCTION OTGetSlotFromPortRef(ref: OTPortRef; VAR other: UInt16): OTSlotNumber;
FUNCTION OTSetDeviceTypeInPortRef(ref: OTPortRef; devType: OTDeviceType): OTPortRef;
FUNCTION OTSetBusTypeInPortRef(ref: OTPortRef; busType: ByteParameter): OTPortRef;
{  Name length definitions for various fields in OTPortRecord. }


CONST
	kMaxModuleNameLength		= 31;							{  max length of a STREAMS module name }
	kMaxModuleNameSize			= 32;
	kMaxProviderNameLength		= 35;							{  providers allow 4 characters for minor number }
	kMaxProviderNameSize		= 36;
	kMaxSlotIDLength			= 7;							{  PCI slot names tend to be short }
	kMaxSlotIDSize				= 8;
	kMaxResourceInfoLength		= 31;							{  max length of a configuration helper name }
	kMaxResourceInfoSize		= 32;
	kMaxPortNameLength			= 35;							{  max size allowed to define a port }
	kMaxPortNameSize			= 36;

{
   Masks for the fPortFlags field of OTPortRecord
   If no bits are set, the port is currently inactive.
}

	kOTPortIsActive				= $00000001;
	kOTPortIsDisabled			= $00000002;
	kOTPortIsUnavailable		= $00000004;
	kOTPortIsOffline			= $00000008;

{  Masks for the fInfoFlags field of the OTPortRecord. }

	kOTPortIsDLPI				= $00000001;
	kOTPortIsTPI				= $00000002;
	kOTPortCanYield				= $00000004;					{  will not be set until the port is used for the first time }
	kOTPortCanArbitrate			= $00000008;					{  will not be set until the port is used for the first time }
	kOTPortIsTransitory			= $00000010;
	kOTPortAutoConnects			= $00000020;
	kOTPortIsSystemRegistered	= $00004000;
	kOTPortIsPrivate			= $00008000;
	kOTPortIsAlias				= $80000000;

{
   One OTPortRecord is created for each instance of a port.
   For Instance 'enet' identifies an ethernet port.
   A OTPortRecord for each ethernet card it finds, with an
   OTPortRef that will uniquely allow the driver to determine which
   port it is supposed to open on.
}


TYPE
	OTPortRecordPtr = ^OTPortRecord;
	OTPortRecord = RECORD
		fRef:					OTPortRef;
		fPortFlags:				UInt32;
		fInfoFlags:				UInt32;
		fCapabilities:			UInt32;
		fNumChildPorts:			ItemCount;
		fChildPorts:			OTPortRefPtr;
		fPortName:				PACKED ARRAY [0..35] OF CHAR;
		fModuleName:			PACKED ARRAY [0..31] OF CHAR;
		fSlotID:				PACKED ARRAY [0..7] OF CHAR;
		fResourceInfo:			PACKED ARRAY [0..31] OF CHAR;
		fReserved:				PACKED ARRAY [0..163] OF CHAR;
	END;

{
   Routines for finding, registering and unregistering ports.
   IMPORTANT:
   These routines have two versions, one for the client and one
   for the kernel.  Make sure you use and link with the right ones.
}
{$IFC NOT OTKERNEL }
FUNCTION OTGetIndexedPort(VAR portRecord: OTPortRecord; index: OTItemCount): BOOLEAN;
{  Index through the ports in the system }
FUNCTION OTFindPort(VAR portRecord: OTPortRecord; portName: ConstCStringPtr): BOOLEAN;
{  Find an OTPortRecord for a port using it's name }
FUNCTION OTFindPortByRef(VAR portRecord: OTPortRecord; ref: OTPortRef): BOOLEAN;
{  Find an OTPortRecord for a port using it's OTPortRef }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTRegisterPort(VAR portRecord: OTPortRecord; ref: UNIV Ptr): OSStatus; C;
{
   Register a port. The name the port was registered under is returned in
   the fPortName field.
}
FUNCTION OTUnregisterPort(portName: ConstCStringPtr; VAR ref: UNIV Ptr): OSStatus; C;
{
   Unregister the port with the given name (If you re-register the
   port, it may get a different name - use OTChangePortState if
   that is not desireable).  Since a single OTPortRef can be registered
   with several names, the API needs to use the portName rather than
   the OTPortRef to disambiguate.
}
FUNCTION OTChangePortState(portRef: OTPortRef; theChange: OTEventCode; why: OTResult): OSStatus; C;
{  Change the state of the port. }
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{  ***** Data Buffers ***** }
{
   TNetbuf is the basic structure used to pass data back and forth
   between the Open Transport protocols and their clients
}


TYPE
	TNetbufPtr = ^TNetbuf;
	TNetbuf = RECORD
		maxlen:					ByteCount;
		len:					ByteCount;
		buf:					Ptr;
	END;

{
   Some rarely used low-level routines in this file take a strbuf
   as a parameter.  This is the raw streams equivalent of a TNetbuf.
   The key difference is that the maxlen and len fields are signed,
   which allows you to specify extra operations by providing a
   negative value.
}

	strbufPtr = ^strbuf;
	strbuf = RECORD
		maxlen:					SInt32;									{  max buffer length  }
		len:					SInt32;									{  length of data  }
		buf:					CStringPtr;								{  pointer to buffer  }
	END;

{
   OTData is used in a TNetbuf or netbuf to send
   non-contiguous data.  Set the 'len' field of the netbuf to the
   constant kNetbufDataIsOTData to signal that the 'buf' field of the
   netbuf actually points to one of these structures instead of a
   memory buffer.
}
	OTDataPtr = ^OTData;
	OTData = RECORD
		fNext:					Ptr;
		fData:					Ptr;
		fLen:					ByteCount;
	END;


CONST
	kNetbufDataIsOTData			= $FFFFFFFE;


{
   OTBuffer is used for no-copy receives.  When receiving, you can
   set the receive length to kOTNetbufDataIsOTBufferStar and then
   pass the address of an OTBuffer* as the receive buffer.  OT will
   fill it out to point to a chain of OTBuffers.
   When you are done with it, you must call the OTReleaseBuffer function.
   For best performance, you need to call OTReleaseBuffer quickly.
   Only data netbufs may use this - no netbufs for addresses or options, or the like.
   Any OTBuffer returned to you by OT is read only!
   The astute will notice that this has a high correlation with the
   STREAMS msgb data type.  The fields are commented with their
   corresponding msgb field name.
}


TYPE
	OTBufferPtr = ^OTBuffer;
	OTBuffer = RECORD
		fLink:					Ptr;									{  b_next }
		fLink2:					Ptr;									{  b_prev }
		fNext:					OTBufferPtr;							{  b_cont }
		fData:					Ptr;									{  b_rptr }
		fLen:					ByteCount;								{  b_wptr }
		fSave:					Ptr;									{  b_datap }
		fBand:					SInt8;									{  b_band }
		fType:					SInt8;									{  b_pad1 }
		fPad1:					SInt8;
		fFlags:					SInt8;									{  b_flag }
	END;


CONST
	kOTNetbufDataIsOTBufferStar	= $FFFFFFFD;

{
   OTBufferInfo is used with OTReadBuffer to keep track of where you
   are in the buffer, since the OTBuffer is "read-only".
}
{
   To initialise this structure, copy the code from the OTInitBuffer macro in
   the C header file.
}

TYPE
	OTBufferInfoPtr = ^OTBufferInfo;
	OTBufferInfo = RECORD
		fBuffer:				OTBufferPtr;
		fOffset:				ByteCount;
		fPad:					SInt8;
	END;

{
   If the endpoint supports "raw mode" (the T_CAN_SUPPORT_MDATA bit will
   be set in the TEndpointInfo::flags field), then you specify the
   raw mode packet by putting the kOTNetbufIsRawMode value in
   the udata.addr.len field when calling OTSndUData and also set the
   udata.opt.len, udata.opt.buf, and udata.addr.buf fields to 0.
}


CONST
	kOTNetbufIsRawMode			= $FFFFFFFF;

{
   ***** Standard XTI Parameter Types *****
   These structures are all used as parameters to the standard
   XTI routines.
}

{
   TBind holds binding information for calls to
   OTGetProtAddress, OTResolveAddress and OTBind.
}


TYPE
	TBindPtr = ^TBind;
	TBind = RECORD
		addr:					TNetbuf;
		qlen:					OTQLen;
	END;

{
   TDiscon is passed to RcvDisconnect to find out additional information
   about the disconnect.
}
	TDisconPtr = ^TDiscon;
	TDiscon = RECORD
		udata:					TNetbuf;
		reason:					OTReason;
		sequence:				OTSequence;
	END;

{
   TCall holds information about a connection and is a parameter to
   OTConnect, OTRcvConnect, OTListen, OTAccept, and OTSndDisconnect.
}
	TCallPtr = ^TCall;
	TCall = RECORD
		addr:					TNetbuf;
		opt:					TNetbuf;
		udata:					TNetbuf;
		sequence:				OTSequence;
	END;

{  TUnitData describes a datagram in calls to OTSndUData and OTRcvUData. }
	TUnitDataPtr = ^TUnitData;
	TUnitData = RECORD
		addr:					TNetbuf;
		opt:					TNetbuf;
		udata:					TNetbuf;
	END;

{
   TUDErr is used to get information about a datagram error using
   OTRcvUDErr.
}
	TUDErrPtr = ^TUDErr;
	TUDErr = RECORD
		addr:					TNetbuf;
		opt:					TNetbuf;
		error:					SInt32;
	END;

{  TOptMgmt is passed to the OTOptionManagement call to read or set protocol }
	TOptMgmtPtr = ^TOptMgmt;
	TOptMgmt = RECORD
		opt:					TNetbuf;
		flags:					OTFlags;
	END;

{
   ***** Transactional XTI Parameter Types *****
   These structures are all used as parameters to the OT's
   XTI-like routines for transaction protocols.
}
{
   TRequest is passed to OTSndRequest and OTRcvRequest that contains the information
   about the request.
}

	TRequestPtr = ^TRequest;
	TRequest = RECORD
		data:					TNetbuf;
		opt:					TNetbuf;
		sequence:				OTSequence;
	END;

{  TReply is passed to OTSndReply to send a reply to an incoming request. }
	TReplyPtr = ^TReply;
	TReply = RECORD
		data:					TNetbuf;
		opt:					TNetbuf;
		sequence:				OTSequence;
	END;

{
   TUnitRequest is passed to OTSndURequest and OTRcvURequest that contains
   the information about the request.
}
	TUnitRequestPtr = ^TUnitRequest;
	TUnitRequest = RECORD
		addr:					TNetbuf;
		opt:					TNetbuf;
		udata:					TNetbuf;
		sequence:				OTSequence;
	END;

{  TUnitReply is passed to OTSndUReply to send a reply to an incoming request. }
	TUnitReplyPtr = ^TUnitReply;
	TUnitReply = RECORD
		opt:					TNetbuf;
		udata:					TNetbuf;
		sequence:				OTSequence;
	END;

{
   ***** Mapper Parameter Types *****
   These structures are all used as parameters to the OT's
   mapper routines.
}
{  TRegisterRequest holds the name to register in a call to OTRegisterName. }

	TRegisterRequestPtr = ^TRegisterRequest;
	TRegisterRequest = RECORD
		name:					TNetbuf;
		addr:					TNetbuf;
		flags:					OTFlags;
	END;

{
   TRegisterReply returns information about the registered name in a call
   to OTRegisterName.
}
	TRegisterReplyPtr = ^TRegisterReply;
	TRegisterReply = RECORD
		addr:					TNetbuf;
		nameid:					OTNameID;
	END;

{  TLookupRequest holds the name to look up in a call to OTLookupName. }
	TLookupRequestPtr = ^TLookupRequest;
	TLookupRequest = RECORD
		name:					TNetbuf;
		addr:					TNetbuf;
		maxcnt:					UInt32;
		timeout:				OTTimeout;
		flags:					OTFlags;
	END;

{
   TLookupReply returns information about the found names after a call
   to OTLookupName.
}
	TLookupReplyPtr = ^TLookupReply;
	TLookupReply = RECORD
		names:					TNetbuf;
		rspcount:				UInt32;
	END;

{
   TLookupBuffer describes the contents of the names buffer pointed
   to by the TLookupReply.
}
	TLookupBufferPtr = ^TLookupBuffer;
	TLookupBuffer = RECORD
		fAddressLength:			UInt16;
		fNameLength:			UInt16;
		fAddressBuffer:			SInt8;
	END;

{  ***** Initializing and Shutting Down Open Transport ***** }

{$IFC NOT OTKERNEL }
	OTClientContextPtr = ^LONGINT; { an opaque 32-bit type }
{
   For Carbon the InitOpenTransport interface has changed so it takes a flags parameter 
   and returns a client context pointer.
   The flag passed to indicates whether OT should be initialized for application use or for some other target
   (for example, plugins that run in an application context but not the application itself.)
   Applications that are not interested in the value of the client context pointer may pass NULL
   as outClientContext -- they will pass NULL to other routines that take a OTClientContextPtr.
}
	OTInitializationFlags 		= UInt32;
CONST
	kInitOTForApplicationMask	= 1;
	kInitOTForExtensionMask		= 2;

FUNCTION InitOpenTransportInContext(flags: OTInitializationFlags; VAR outClientContext: OTClientContextPtr): OSStatus;

{
   Under Carbon, CloseOpenTransport takes a client context pointer.  Applications may pass NULL
   after calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
   valid client context.
}
PROCEDURE CloseOpenTransportInContext(clientContext: OTClientContextPtr);

{$IFC CALL_NOT_IN_CARBON }
FUNCTION InitOpenTransport: OSStatus;
FUNCTION InitOpenTransportUtilities: OSStatus;
PROCEDURE CloseOpenTransport;
FUNCTION OTRegisterAsClient(name: OTClientName; proc: OTNotifyUPP): OSStatus;
{
   This registers yourself as a client for any miscellaneous Open Transport
   notifications that come along. CloseOpenTransport will automatically do
   an OTUnregisterAsClient, if you have not already done so.
}
FUNCTION OTUnregisterAsClient: OSStatus;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC OTCARBONAPPLICATION }
{  The following macro may be used by applications only. }
{$ENDC}  {OTCARBONAPPLICATION}
{$ENDC}

{  ***** Tasking Model ***** }
{
   OTEnterInterrupt/OTLeaveInterrupt are normally used within the kernel to
   tell Open Transport we're at hardware interrupt time.  Clients can also
   them to do the same.
}

{$IFC CALL_NOT_IN_CARBON }
PROCEDURE OTEnterInterrupt;
PROCEDURE OTLeaveInterrupt;
FUNCTION OTIsAtInterruptLevel: BOOLEAN; C;
FUNCTION OTCanLoadLibraries: BOOLEAN; C;
{
   All OT task callbacks use the same prototype, shown below.
   This is only a UPP for CFM-68K clients.
}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	OTProcessProcPtr = PROCEDURE(arg: UNIV Ptr);
{$ELSEC}
	OTProcessProcPtr = ProcPtr;
{$ENDC}

	OTProcessUPP = ^LONGINT;  { an opaque UPP }

CONST
	uppOTProcessProcInfo = $000000C0;

FUNCTION NewOTProcessUPP(userRoutine: OTProcessProcPtr): OTProcessUPP; { old name was NewOTProcessProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeOTProcessUPP(userUPP: OTProcessUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeOTProcessUPP(arg: UNIV Ptr; userRoutine: OTProcessUPP); { old name was CallOTProcessProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$IFC NOT OTKERNEL }
{
   Under Carbon, OTCreateDeferredTask takes a client context pointer.  Applications may pass NULL
   after calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
   valid client context.
}
FUNCTION OTCreateDeferredTaskInContext(upp: OTProcessUPP; arg: UNIV Ptr; clientContext: OTClientContextPtr): LONGINT;
{$ENDC}

{
   OT deferred tasks are often more convenience that standard Mac OS
   although they have no significant advantages beyond convenience.
}


TYPE
	OTDeferredTaskRef					= LONGINT;
{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTCreateDeferredTask(proc: OTProcessUPP; arg: UNIV Ptr): OTDeferredTaskRef;
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION OTScheduleDeferredTask(dtCookie: OTDeferredTaskRef): BOOLEAN;
{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTScheduleInterruptTask(dtCookie: OTDeferredTaskRef): BOOLEAN;
{$ENDC}  {CALL_NOT_IN_CARBON}

FUNCTION OTDestroyDeferredTask(dtCookie: OTDeferredTaskRef): OSStatus;
{$IFC OTCARBONAPPLICATION }
{  The following macro may be used by applications only. }
{$ENDC}  {OTCARBONAPPLICATION}

{$IFC NOT OTKERNEL }
{
   OT system tasks allow you to schedule a procedure to be called
   at system task time.  Potentially useful, but it relies on someone
   calling SystemTask (or WaitNextEvent, which calls SystemTask).
   Not available to kernel code because relying on system task time
   to make progress is likely to result in deadlocks.
}

TYPE
	OTSystemTaskRef						= LONGINT;
{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTCreateSystemTask(proc: OTProcessUPP; arg: UNIV Ptr): OTSystemTaskRef;
FUNCTION OTDestroySystemTask(stCookie: OTSystemTaskRef): OSStatus;
FUNCTION OTScheduleSystemTask(stCookie: OTSystemTaskRef): BOOLEAN;
FUNCTION OTCancelSystemTask(stCookie: OTSystemTaskRef): BOOLEAN;
{$ENDC}  {CALL_NOT_IN_CARBON}
FUNCTION OTCanMakeSyncCall: BOOLEAN;
{$ENDC}

{  ***** Interface to Providers ***** }
{$IFC NOT OTKERNEL }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTAsyncOpenProvider(cfig: OTConfigurationRef; flags: OTOpenFlags; proc: OTNotifyUPP; contextPtr: UNIV Ptr): OSStatus;
FUNCTION OTOpenProvider(cfig: OTConfigurationRef; flags: OTOpenFlags; VAR errPtr: OSStatus): ProviderRef;
{$ENDC}  {CALL_NOT_IN_CARBON}
FUNCTION OTCloseProvider(ref: ProviderRef): OSStatus;
{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTTransferProviderOwnership(ref: ProviderRef; prevOwner: OTClient; VAR errPtr: OSStatus): ProviderRef;
FUNCTION OTWhoAmI: OTClient;
FUNCTION OTGetProviderPortRef(ref: ProviderRef): OTPortRef;
{$ENDC}  {CALL_NOT_IN_CARBON}
FUNCTION OTIoctl(ref: ProviderRef; cmd: UInt32; data: UNIV Ptr): SInt32;
{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTGetMessage(ref: ProviderRef; VAR ctlbuf: strbuf; VAR databuf: strbuf; VAR flagsPtr: OTFlags): OTResult;
FUNCTION OTGetPriorityMessage(ref: ProviderRef; VAR ctlbuf: strbuf; VAR databuf: strbuf; VAR bandPtr: OTBand; VAR flagsPtr: OTFlags): OTResult;
FUNCTION OTPutMessage(ref: ProviderRef; {CONST}VAR ctlbuf: strbuf; {CONST}VAR databuf: strbuf; flags: OTFlags): OSStatus;
FUNCTION OTPutPriorityMessage(ref: ProviderRef; {CONST}VAR ctlbuf: strbuf; {CONST}VAR databuf: strbuf; band: OTBand; flags: OTFlags): OSStatus;
{$ENDC}  {CALL_NOT_IN_CARBON}
FUNCTION OTSetAsynchronous(ref: ProviderRef): OSStatus;
FUNCTION OTSetSynchronous(ref: ProviderRef): OSStatus;
FUNCTION OTIsSynchronous(ref: ProviderRef): BOOLEAN;
FUNCTION OTSetBlocking(ref: ProviderRef): OSStatus;
FUNCTION OTSetNonBlocking(ref: ProviderRef): OSStatus;
FUNCTION OTIsBlocking(ref: ProviderRef): BOOLEAN;
FUNCTION OTInstallNotifier(ref: ProviderRef; proc: OTNotifyUPP; contextPtr: UNIV Ptr): OSStatus;
FUNCTION OTUseSyncIdleEvents(ref: ProviderRef; useEvents: BOOLEAN): OSStatus;
PROCEDURE OTRemoveNotifier(ref: ProviderRef);
PROCEDURE OTLeaveNotifier(ref: ProviderRef);
FUNCTION OTEnterNotifier(ref: ProviderRef): BOOLEAN;
FUNCTION OTAckSends(ref: ProviderRef): OSStatus;
FUNCTION OTDontAckSends(ref: ProviderRef): OSStatus;
FUNCTION OTIsAckingSends(ref: ProviderRef): BOOLEAN;
FUNCTION OTCancelSynchronousCalls(ref: ProviderRef; err: OSStatus): OSStatus;
{$ENDC}

{  ***** Interface to Endpoints ***** }
{$IFC NOT OTKERNEL }
{  Open/Close }
{
   Under Carbon, the OpenEndpoint routines take a client context pointer.  Applications may pass NULL after
   calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
   valid client context.
}
FUNCTION OTOpenEndpointInContext(config: OTConfigurationRef; oflag: OTOpenFlags; VAR info: TEndpointInfo; VAR err: OSStatus; clientContext: OTClientContextPtr): EndpointRef;
FUNCTION OTAsyncOpenEndpointInContext(config: OTConfigurationRef; oflag: OTOpenFlags; VAR info: TEndpointInfo; upp: OTNotifyUPP; contextPtr: UNIV Ptr; clientContext: OTClientContextPtr): OSStatus;


{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTOpenEndpoint(cfig: OTConfigurationRef; oflag: OTOpenFlags; VAR info: TEndpointInfo; VAR err: OSStatus): EndpointRef;
FUNCTION OTAsyncOpenEndpoint(cfig: OTConfigurationRef; oflag: OTOpenFlags; VAR info: TEndpointInfo; proc: OTNotifyUPP; contextPtr: UNIV Ptr): OSStatus;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC OTCARBONAPPLICATION }
{  The following macros may be used by applications only. }
{$ENDC}  {OTCARBONAPPLICATION}
{  Misc Information }

FUNCTION OTGetEndpointInfo(ref: EndpointRef; VAR info: TEndpointInfo): OSStatus;
FUNCTION OTGetEndpointState(ref: EndpointRef): OTResult;
FUNCTION OTLook(ref: EndpointRef): OTResult;
{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTSync(ref: EndpointRef): OTResult;
{$ENDC}  {CALL_NOT_IN_CARBON}
FUNCTION OTCountDataBytes(ref: EndpointRef; VAR countPtr: OTByteCount): OTResult;
FUNCTION OTGetProtAddress(ref: EndpointRef; VAR boundAddr: TBind; VAR peerAddr: TBind): OSStatus;
FUNCTION OTResolveAddress(ref: EndpointRef; VAR reqAddr: TBind; VAR retAddr: TBind; timeOut: OTTimeout): OSStatus;
{  Allocating structures }

{
   Note:
   In general, Apple recommends that you avoid the OTAlloc call because
   using it extensively causes your program to allocate and deallocate
   many memory blocks, with each extra memory allocation costing time.
}

{
   Under Carbon, OTAlloc takes a client context pointer.  Applications may pass NULL after
   calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
   valid client context.
}
FUNCTION OTAllocInContext(ref: EndpointRef; structType: OTStructType; fields: UInt32; VAR err: OSStatus; clientContext: OTClientContextPtr): Ptr;
{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTAlloc(ref: EndpointRef; structType: OTStructType; fields: OTFieldsType; VAR err: OSStatus): Ptr;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC OTCARBONAPPLICATION }
{  The following macro may be used by applications only. }
{$ENDC}  {OTCARBONAPPLICATION}
FUNCTION OTFree(ptr: UNIV Ptr; structType: OTStructType): OTResult;
{  Option management }

{  It looks simple enough... }

FUNCTION OTOptionManagement(ref: EndpointRef; VAR req: TOptMgmt; VAR ret: TOptMgmt): OSStatus;
{  ... but then the hidden complexity emerges. }

{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTCreateOptions(endPtName: ConstCStringPtr; VAR strPtr: CStringPtr; VAR buf: TNetbuf): OSStatus;
FUNCTION OTCreateOptionString(endPtName: ConstCStringPtr; VAR opt: TOptionPtr; bufEnd: UNIV Ptr; str: CStringPtr; stringSize: OTByteCount): OSStatus;
{$ENDC}  {CALL_NOT_IN_CARBON}
FUNCTION OTNextOption(VAR buffer: UInt8; buflen: UInt32; VAR prevOptPtr: TOptionPtr): OSStatus;
FUNCTION OTFindOption(VAR buffer: UInt8; buflen: UInt32; level: OTXTILevel; name: OTXTIName): TOptionPtr;
{  Bind/Unbind }

FUNCTION OTBind(ref: EndpointRef; VAR reqAddr: TBind; VAR retAddr: TBind): OSStatus;
FUNCTION OTUnbind(ref: EndpointRef): OSStatus;
{  Connection creation/tear-down }

FUNCTION OTConnect(ref: EndpointRef; VAR sndCall: TCall; VAR rcvCall: TCall): OSStatus;
FUNCTION OTRcvConnect(ref: EndpointRef; VAR call: TCall): OSStatus;
FUNCTION OTListen(ref: EndpointRef; VAR call: TCall): OSStatus;
FUNCTION OTAccept(listener: EndpointRef; worker: EndpointRef; VAR call: TCall): OSStatus;
FUNCTION OTSndDisconnect(ref: EndpointRef; VAR call: TCall): OSStatus;
FUNCTION OTSndOrderlyDisconnect(ref: EndpointRef): OSStatus;
FUNCTION OTRcvDisconnect(ref: EndpointRef; VAR discon: TDiscon): OSStatus;
FUNCTION OTRcvOrderlyDisconnect(ref: EndpointRef): OSStatus;
{  Connection-oriented send/receive }

FUNCTION OTRcv(ref: EndpointRef; buf: UNIV Ptr; nbytes: OTByteCount; VAR flags: OTFlags): OTResult;
FUNCTION OTSnd(ref: EndpointRef; buf: UNIV Ptr; nbytes: OTByteCount; flags: OTFlags): OTResult;
{  Connectionless send/receive }

FUNCTION OTSndUData(ref: EndpointRef; VAR udata: TUnitData): OSStatus;
FUNCTION OTRcvUData(ref: EndpointRef; VAR udata: TUnitData; VAR flags: OTFlags): OSStatus;
FUNCTION OTRcvUDErr(ref: EndpointRef; VAR uderr: TUDErr): OSStatus;
{  Connection-oriented transactions }

{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTSndRequest(ref: EndpointRef; VAR req: TRequest; reqFlags: OTFlags): OSStatus;
FUNCTION OTRcvReply(ref: EndpointRef; VAR reply: TReply; VAR replyFlags: OTFlags): OSStatus;
FUNCTION OTSndReply(ref: EndpointRef; VAR reply: TReply; replyFlags: OTFlags): OSStatus;
FUNCTION OTRcvRequest(ref: EndpointRef; VAR req: TRequest; VAR reqFlags: OTFlags): OSStatus;
FUNCTION OTCancelRequest(ref: EndpointRef; sequence: OTSequence): OSStatus;
FUNCTION OTCancelReply(ref: EndpointRef; sequence: OTSequence): OSStatus;
{  Connectionless transactions }

FUNCTION OTSndURequest(ref: EndpointRef; VAR req: TUnitRequest; reqFlags: OTFlags): OSStatus;
FUNCTION OTRcvUReply(ref: EndpointRef; VAR reply: TUnitReply; VAR replyFlags: OTFlags): OSStatus;
FUNCTION OTSndUReply(ref: EndpointRef; VAR reply: TUnitReply; replyFlags: OTFlags): OSStatus;
FUNCTION OTRcvURequest(ref: EndpointRef; VAR req: TUnitRequest; VAR reqFlags: OTFlags): OSStatus;
FUNCTION OTCancelURequest(ref: EndpointRef; seq: OTSequence): OSStatus;
FUNCTION OTCancelUReply(ref: EndpointRef; seq: OTSequence): OSStatus;
{  Interface to Mappers }


{
   Under Carbon, the OpenMapper routines take a client context pointer.  Applications may pass NULL after
   calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
   valid client context.
}
{$ENDC}  {CALL_NOT_IN_CARBON}
FUNCTION OTAsyncOpenMapperInContext(config: OTConfigurationRef; oflag: OTOpenFlags; upp: OTNotifyUPP; contextPtr: UNIV Ptr; clientContext: OTClientContextPtr): OSStatus;
FUNCTION OTOpenMapperInContext(config: OTConfigurationRef; oflag: OTOpenFlags; VAR err: OSStatus; clientContext: OTClientContextPtr): MapperRef;

{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTAsyncOpenMapper(cfig: OTConfigurationRef; oflag: OTOpenFlags; proc: OTNotifyUPP; contextPtr: UNIV Ptr): OSStatus;
FUNCTION OTOpenMapper(cfig: OTConfigurationRef; oflag: OTOpenFlags; VAR err: OSStatus): MapperRef;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC OTCARBONAPPLICATION }
{  The following macros may be used by applications only. }
{$ENDC}  {OTCARBONAPPLICATION}
FUNCTION OTRegisterName(ref: MapperRef; VAR req: TRegisterRequest; VAR reply: TRegisterReply): OSStatus;
FUNCTION OTDeleteName(ref: MapperRef; VAR name: TNetbuf): OSStatus;
FUNCTION OTDeleteNameByID(ref: MapperRef; nameID: OTNameID): OSStatus;
FUNCTION OTLookupName(ref: MapperRef; VAR req: TLookupRequest; VAR reply: TLookupReply): OSStatus;
{  Basic configuration manipulation }

FUNCTION OTCreateConfiguration(path: ConstCStringPtr): OTConfigurationRef;
FUNCTION OTCloneConfiguration(cfig: OTConfigurationRef): OTConfigurationRef;
PROCEDURE OTDestroyConfiguration(cfig: OTConfigurationRef);
{
   This file defines a very limited set of operations
   on a configuration.  "OpenTransportClient.h" extends this with extra
   operations used by protocol stacks but not typically needed by clients.
}

{  Interrupt-safe memory allocators }

{
   Under Carbon, OTAllocMem takes a client context pointer.  Applications may pass NULL after
   calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
   valid client context.
}
FUNCTION OTAllocMemInContext(size: OTByteCount; clientContext: OTClientContextPtr): Ptr; C;
{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTAllocMem(size: OTByteCount): Ptr; C;
{$ENDC}  {CALL_NOT_IN_CARBON}
PROCEDURE OTFreeMem(mem: UNIV Ptr); C;
{$IFC OTCARBONAPPLICATION }
{  The following macros may be used by applications only. }
{$ENDC}  {OTCARBONAPPLICATION}
{  Miscellaneous and Generic Routines }

{
   Neither of these routines should be necessary to the correct
   operation of an OT program.  If you're calling them, think again.
}

PROCEDURE OTDelay(seconds: UInt32);
PROCEDURE OTIdle;
{$ENDC}

{
   ***** Open Transport Utility Routines *****
   All of these routines are available to both client and kernel.
}
{  Memory and String Routines }

{
   These are preferable, especially in the kernel case, to the standard
   C equivalents because they don't require you to link with StdCLib.
}

PROCEDURE OTMemcpy(dest: UNIV Ptr; src: UNIV Ptr; nBytes: OTByteCount); C;
FUNCTION OTMemcmp(mem1: UNIV Ptr; mem2: UNIV Ptr; nBytes: OTByteCount): BOOLEAN; C;
PROCEDURE OTMemmove(dest: UNIV Ptr; src: UNIV Ptr; nBytes: OTByteCount); C;
PROCEDURE OTMemzero(dest: UNIV Ptr; nBytes: OTByteCount); C;
PROCEDURE OTMemset(dest: UNIV Ptr; toSet: OTUInt8Param; nBytes: OTByteCount); C;
FUNCTION OTStrLength(str: ConstCStringPtr): OTByteCount; C;
PROCEDURE OTStrCopy(dest: CStringPtr; src: ConstCStringPtr); C;
PROCEDURE OTStrCat(dest: CStringPtr; src: ConstCStringPtr); C;
FUNCTION OTStrEqual(src1: ConstCStringPtr; src2: ConstCStringPtr): BOOLEAN; C;
{  Timer Utilities }

{
   OTGetTimeStamp returns time in "tick" numbers, stored in 64 bits.
   This timestamp can be used as a base number for calculating elapsed 
   time.
   OTSubtractTimeStamps returns a pointer to the "result" parameter.
   	
   OTGetClockTimeInSecs returns time since Open Transport was initialized
   in seconds.
}


TYPE
	OTTimeStamp							= UnsignedWide;
	OTTimeStampPtr 						= ^OTTimeStamp;
PROCEDURE OTGetTimeStamp(VAR currentTime: OTTimeStamp); C;
FUNCTION OTSubtractTimeStamps(VAR result: OTTimeStamp; VAR startTime: OTTimeStamp; VAR endEnd: OTTimeStamp): OTTimeStampPtr; C;
FUNCTION OTTimeStampInMilliseconds(VAR delta: OTTimeStamp): UInt32; C;
FUNCTION OTTimeStampInMicroseconds(VAR delta: OTTimeStamp): UInt32; C;
FUNCTION OTElapsedMilliseconds(VAR startTime: OTTimeStamp): UInt32; C;
FUNCTION OTElapsedMicroseconds(VAR startTime: OTTimeStamp): UInt32; C;
FUNCTION OTGetClockTimeInSecs: UInt32; C;
{  ***** OT Link Element ***** }

{
   When using OT linked lists, all pointers to other elements are
   represented by the OTLink structure.  When operating on link
   lists, you always pass in the address of the OTLink on which
   list elements are chained.
}


TYPE
	OTLinkPtr = ^OTLink;
	OTLink = RECORD
		fNext:					OTLinkPtr;
	END;

{  OTLIFO }

{
   These are functions to implement a LIFO list that is interrupt-safe.
   The only function which is not is OTReverseList.  Normally, you create
   a LIFO list, populate it at interrupt time, and then use OTLIFOStealList
   to atomically remove the list, and OTReverseList to flip the list so that
   it is a FIFO list, which tends to be more useful.
}

	OTLIFOPtr = ^OTLIFO;
	OTLIFO = RECORD
		fHead:					OTLinkPtr;
	END;

{
   This function atomically enqueues the link onto the
   front of the list.
}
PROCEDURE OTLIFOEnqueue(VAR list: OTLIFO; VAR link: OTLink); C;
{
   This function atomically dequeues the first element
   on the list.
}
FUNCTION OTLIFODequeue(VAR list: OTLIFO): OTLinkPtr; C;
{
   This function atomically empties the list and returns a
   pointer to the first element on the list.
}
FUNCTION OTLIFOStealList(VAR list: OTLIFO): OTLinkPtr; C;
{
   This function reverses a list that was stolen by
   OTLIFOStealList.  It is NOT atomic.  It returns the
   new starting list.
}
FUNCTION OTReverseList(VAR list: OTLink): OTLinkPtr; C;
{  OTList }

{
   An OTList is a non-interrupt-safe list, but has more features than the
   OTLIFO list. It is a standard singly-linked list.
}

{
   The following is the prototype for a list element comparison function,
   which returns true if the element described by linkToCheck matches
   the client criteria (typically held in ref).
   This is only a UPP for CFM-68K clients.
}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	OTListSearchProcPtr = FUNCTION(ref: UNIV Ptr; VAR linkToCheck: OTLink): BOOLEAN; C;
{$ELSEC}
	OTListSearchProcPtr = ProcPtr;
{$ENDC}

	OTListSearchUPP = ^LONGINT;  { an opaque UPP }

CONST
	uppOTListSearchProcInfo = $000003D1;

FUNCTION NewOTListSearchUPP(userRoutine: OTListSearchProcPtr): OTListSearchUPP; { old name was NewOTListSearchProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeOTListSearchUPP(userUPP: OTListSearchUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeOTListSearchUPP(ref: UNIV Ptr; VAR linkToCheck: OTLink; userRoutine: OTListSearchUPP): BOOLEAN; { old name was CallOTListSearchProc }

TYPE
	OTListPtr = ^OTList;
	OTList = RECORD
		fHead:					OTLinkPtr;
	END;

{  Add the link to the list at the front }
PROCEDURE OTAddFirst(VAR list: OTList; VAR link: OTLink); C;
{  Add the link to the list at the end }
PROCEDURE OTAddLast(VAR list: OTList; VAR link: OTLink); C;
{  Remove the first link from the list }
FUNCTION OTRemoveFirst(VAR list: OTList): OTLinkPtr; C;
{  Remove the last link from the list }
FUNCTION OTRemoveLast(VAR list: OTList): OTLinkPtr; C;
{  Return the first link from the list }
FUNCTION OTGetFirst(VAR list: OTList): OTLinkPtr; C;
{  Return the last link from the list }
FUNCTION OTGetLast(VAR list: OTList): OTLinkPtr; C;
{  Return true if the link is present in the list }
FUNCTION OTIsInList(VAR list: OTList; VAR link: OTLink): BOOLEAN; C;
{
   Find a link in the list which matches the search criteria
   established by the search proc and the refPtr.  This is done
   by calling the search proc, passing it the refPtr and each
   link in the list, until the search proc returns true.
   NULL is returned if the search proc never returned true.
}
FUNCTION OTFindLink(VAR list: OTList; proc: OTListSearchUPP; ref: UNIV Ptr): OTLinkPtr; C;
{  Remove the specified link from the list, returning true if it was found }
FUNCTION OTRemoveLink(VAR list: OTList; VAR link: OTLink): BOOLEAN; C;
{  Similar to OTFindLink, but it also removes it from the list. }
FUNCTION OTFindAndRemoveLink(VAR list: OTList; proc: OTListSearchUPP; ref: UNIV Ptr): OTLinkPtr; C;
{  Return the "index"th link in the list }
FUNCTION OTGetIndexedLink(VAR list: OTList; index: OTItemCount): OTLinkPtr; C;
{  OTEnqueue/OTDequeue }

{
   These routines are atomic, mighty weird, and generally not
   worth the complexity.  If you need atomic list operations,
   use OTLIFO instead.
}

{
   This function puts "object" on the listHead, and places the
   previous value at listHead into the pointer at "object" plus
   linkOffset.
}
PROCEDURE OTEnqueue(VAR listHead: UNIV Ptr; object: UNIV Ptr; linkOffset: OTByteCount); C;
{
   This function returns the head object of the list, and places
   the pointer at "object" + linkOffset into the listHead
}
FUNCTION OTDequeue(VAR listHead: UNIV Ptr; linkOffset: OTByteCount): Ptr; C;
{  Atomic Operations }

{
   Note:
   The Bit operations return the previous value of the bit (0 or non-zero).
   The memory pointed to must be a single byte and only bits 0 through 7 are
   valid.  Bit 0 corresponds to a mask of 0x01, and Bit 7 to a mask of 0x80.
}

{
   WARNING!
   void* and UInt32 locations MUST be on 4-byte boundaries.
   UInt16 locations must not cross a 4-byte boundary.
}

FUNCTION OTAtomicSetBit(VAR bytePtr: UInt8; bitNumber: OTByteCount): BOOLEAN; C;
{
   bset.b d0,(a0)
   sne d0
   moveq #1,d1
   and.l d1,d0
}
FUNCTION OTAtomicClearBit(VAR bytePtr: UInt8; bitNumber: OTByteCount): BOOLEAN; C;
{
   bclr.b d0,(a0)
   sne d0
   moveq #1,d1
   and.l d1,d0
}
FUNCTION OTAtomicTestBit(VAR bytePtr: UInt8; bitNumber: OTByteCount): BOOLEAN; C;
{
   btst.b d0,(a0)
   sne d0 */
   moveq #1,d1
   and.l d1,d0 */
}
FUNCTION OTCompareAndSwapPtr(oldValue: UNIV Ptr; newValue: UNIV Ptr; VAR dest: UNIV Ptr): BOOLEAN; C;
{
   cas.l	d0,d1,(a0)	*/
   seq		d0			*/
   moveq #1,d1; and.l d1,d0 */
}
FUNCTION OTCompareAndSwap32(oldValue: UInt32; newValue: UInt32; VAR dest: UInt32): BOOLEAN; C;
{
   cas.l	d0,d1,(a0)	*/
   seq		d0			*/
   moveq #1,d1; and.l d1,d0 */
}
FUNCTION OTCompareAndSwap16(oldValue: UInt32; newValue: UInt32; VAR dest: UInt16): BOOLEAN; C;
{
   cas.w	d0,d1,(a0)	*/
   seq		d0			*/
   moveq #1,d1; and.l d1,d0 */
}
FUNCTION OTCompareAndSwap8(oldValue: UInt32; newValue: UInt32; VAR dest: UInt8): BOOLEAN; C;
{
   cas.b	d0,d1,(a0)	*/
   seq		d0			*/
   moveq #1,d1; and.l d1,d0 */
}
FUNCTION OTAtomicAdd32(toAdd: SInt32; VAR dest: SInt32): SInt32; C;
{
   move.l	d0,a1		*/
   move.l	(a0),d1		*/
   move.l	d1,d0		*/
   add.l	a1,d0		*/
   cas.l	d1,d0,(a0)	*/
   bne.s	@1			*/
}
FUNCTION OTAtomicAdd16(toAdd: SInt32; VAR dest: SInt16): SInt16; C;
{  Not used frequently enough to justify inlining. }
FUNCTION OTAtomicAdd8(toAdd: SInt32; VAR dest: SInt8): SInt8; C;
{  Not used frequently enough to justify inlining. }
{  OTLock is just a convenience type with some convenient macros. }


TYPE
	OTLock								= UInt8;


{$ifc not undefined __MWERKS and TARGET_CPU_68K}
	{$pragmac d0_pointers reset}
{$endc}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OpenTransportIncludes}

{$ENDC} {__OPENTRANSPORT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
