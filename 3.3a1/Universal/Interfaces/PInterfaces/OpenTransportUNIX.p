{
 	File:		OpenTransportUNIX.p
 
 	Contains:	Open Transport client interface file for UNIX compatibility clients.
 
 	Version:	Technology:	2.5
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1993-1999 by Apple Computer, Inc. and Mentat Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OpenTransportUNIX;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTRANSPORTUNIX__}
{$SETC __OPENTRANSPORTUNIX__ := 1}

{$I+}
{$SETC OpenTransportUNIXIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORTPROTOCOL__}
{$I OpenTransportProtocol.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$ifc not undefined __MWERKS and TARGET_CPU_68K}
	{$pragmac d0_pointers on}
{$endc}

{  ***** Global Variables ***** }


{  ***** XTI Structures ***** }

{
   WARNING:
   These structures will only work if "int"s are the
   same size as "size_t", "long", and "UInt32".  We left
   them this way for maximum UNIX compatibility.
}


TYPE
	size_t								= UInt32;
	netbufPtr = ^netbuf;
	netbuf = RECORD
		maxlen:					UInt32;
		len:					UInt32;
		buf:					CStringPtr;
	END;

	t_infoPtr = ^t_info;
	t_info = RECORD
		addr:					LONGINT;								{  Maximum size of an address			 }
		options:				LONGINT;								{  Maximum size of options				 }
		tsdu:					LONGINT;								{  Standard data transmit unit size		 }
		etsdu:					LONGINT;								{  Expedited data transmit unit size	 }
		connect:				LONGINT;								{  Maximum data size on connect			 }
		discon:					LONGINT;								{  Maximum data size on disconnect		 }
		servtype:				UInt32;									{  service type							 }
		flags:					UInt32;									{  Flags (see "OpenTransport.h")		 }
	END;


	ot_bindPtr = ^ot_bind;
	ot_bind = RECORD
		addr:					netbuf;
		qlen:					UInt32;
	END;

	ot_optmgmtPtr = ^ot_optmgmt;
	ot_optmgmt = RECORD
		opt:					netbuf;
		flags:					LONGINT;
	END;

	t_disconPtr = ^t_discon;
	t_discon = RECORD
		udata:					netbuf;
		reason:					LONGINT;
		sequence:				LONGINT;
	END;

	t_callPtr = ^t_call;
	t_call = RECORD
		addr:					netbuf;
		opt:					netbuf;
		udata:					netbuf;
		sequence:				LONGINT;
	END;

	t_unitdataPtr = ^t_unitdata;
	t_unitdata = RECORD
		addr:					netbuf;
		opt:					netbuf;
		udata:					netbuf;
	END;

	t_uderrPtr = ^t_uderr;
	t_uderr = RECORD
		addr:					netbuf;
		opt:					netbuf;
		error:					LONGINT;
	END;

{	-------------------------------------------------------------------------
	Transaction data structures
	------------------------------------------------------------------------- }
	t_requestPtr = ^t_request;
	t_request = RECORD
		data:					netbuf;
		opt:					netbuf;
		sequence:				LONGINT;
	END;

	t_replyPtr = ^t_reply;
	t_reply = RECORD
		data:					netbuf;
		opt:					netbuf;
		sequence:				LONGINT;
	END;

	t_unitrequestPtr = ^t_unitrequest;
	t_unitrequest = RECORD
		addr:					netbuf;
		opt:					netbuf;
		udata:					netbuf;
		sequence:				LONGINT;
	END;

	t_unitreplyPtr = ^t_unitreply;
	t_unitreply = RECORD
		opt:					netbuf;
		udata:					netbuf;
		sequence:				LONGINT;
	END;

	t_opthdrPtr = ^t_opthdr;
	t_opthdr = RECORD
		len:					UInt32;									{  total length of option = sizeof(struct t_opthdr) +	 }
																		{ 						length of option value in bytes	 }
		level:					UInt32;									{  protocol affected  }
		name:					UInt32;									{  option name  }
		status:					UInt32;									{  status value  }
																		{  followed by the option value  }
	END;

{  ***** XTI Interfaces ***** }
{$IFC NOT OTKERNEL }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION t_accept(fd: LONGINT; resfd: LONGINT; VAR call: t_call): LONGINT;
FUNCTION t_alloc(fd: LONGINT; struct_type: LONGINT; fields: LONGINT): CStringPtr;
{$ENDC}  {CALL_NOT_IN_CARBON}
{
   ••• These function names conflict with constant names, eg T_BIND,
   in "OpenTransport.i".  I have no idea how to fix this.  For the moment
   I'm going to leave these routines out of the non-C builds.  [The C
   builds are handled by the pass throughs, for other reasons.]
   pascal int 	t_bind(int fd, ot_bind* req, ot_bind* ret);
   pascal int 	t_optmgmt(int fd, ot_optmgmt* req, ot_optmgmt* ret);
}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION t_getprotaddr(fd: LONGINT; VAR boundaddr: ot_bind; VAR peeraddr: ot_bind): LONGINT;
FUNCTION t_resolveaddr(fd: LONGINT; VAR reqAddr: ot_bind; VAR retAddr: ot_bind; timeout: OTTimeout): LONGINT;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION t_close(fd: LONGINT): LONGINT;
FUNCTION t_connect(fd: LONGINT; VAR sndcall: t_call; VAR rcvcall: t_call): LONGINT;
FUNCTION t_free(ptr: CStringPtr; struct_type: LONGINT): LONGINT;
FUNCTION t_getinfo(fd: LONGINT; VAR info: t_info): LONGINT;
FUNCTION t_getstate(fd: LONGINT): LONGINT;
FUNCTION t_listen(fd: LONGINT; VAR call: t_call): LONGINT;
FUNCTION t_look(fd: LONGINT): LONGINT;
FUNCTION t_open(path: CStringPtr; oflag: LONGINT; VAR info: t_info): LONGINT;
FUNCTION t_blocking(fd: LONGINT): LONGINT;
FUNCTION t_nonblocking(fd: LONGINT): LONGINT;
FUNCTION t_rcv(fd: LONGINT; buf: CStringPtr; nbytes: size_t; VAR flags: LONGINT): LONGINT;
FUNCTION t_rcvconnect(fd: LONGINT; VAR call: t_call): LONGINT;
FUNCTION t_rcvdis(fd: LONGINT; VAR discon: t_discon): LONGINT;
FUNCTION t_rcvrel(fd: LONGINT): LONGINT;
FUNCTION t_rcvudata(fd: LONGINT; VAR unitdata: t_unitdata; VAR flags: LONGINT): LONGINT;
FUNCTION t_rcvuderr(fd: LONGINT; VAR uderr: t_uderr): LONGINT;
FUNCTION t_snd(fd: LONGINT; buf: CStringPtr; nbytes: size_t; flags: LONGINT): LONGINT;
FUNCTION t_snddis(fd: LONGINT; VAR call: t_call): LONGINT;
FUNCTION t_sndrel(fd: LONGINT): LONGINT;
FUNCTION t_sndudata(fd: LONGINT; VAR unitdata: t_unitdata): LONGINT;
FUNCTION t_sync(fd: LONGINT): LONGINT;
FUNCTION t_unbind(fd: LONGINT): LONGINT;
FUNCTION t_error(errmsg: CStringPtr): LONGINT;
{  Apple extensions }

FUNCTION t_isnonblocking(fd: LONGINT): LONGINT;
FUNCTION t_asynchronous(fd: LONGINT): LONGINT;
FUNCTION t_synchronous(fd: LONGINT): LONGINT;
FUNCTION t_issynchronous(fd: LONGINT): LONGINT;
FUNCTION t_usesyncidleevents(fd: LONGINT; useEvents: LONGINT): LONGINT;
{  Not XTI standard functions, but extensions for transaction endpoints	 }

FUNCTION t_sndrequest(fd: LONGINT; VAR req: t_request; flags: LONGINT): LONGINT;
FUNCTION t_rcvreply(fd: LONGINT; VAR rep: t_reply; VAR flags: LONGINT): LONGINT;
FUNCTION t_rcvrequest(fd: LONGINT; VAR req: t_request; VAR flags: LONGINT): LONGINT;
FUNCTION t_sndreply(fd: LONGINT; VAR rep: t_reply; flags: LONGINT): LONGINT;
FUNCTION t_cancelrequest(fd: LONGINT; sequence: LONGINT): LONGINT;
FUNCTION t_cancelreply(fd: LONGINT; sequence: LONGINT): LONGINT;
FUNCTION t_sndurequest(fd: LONGINT; VAR ureq: t_unitrequest; flags: LONGINT): LONGINT;
FUNCTION t_rcvureply(fd: LONGINT; VAR urep: t_unitreply; VAR flags: LONGINT): LONGINT;
FUNCTION t_rcvurequest(fd: LONGINT; VAR ureq: t_unitrequest; VAR flags: LONGINT): LONGINT;
FUNCTION t_sndureply(fd: LONGINT; VAR urep: t_unitreply; flags: LONGINT): LONGINT;
FUNCTION t_cancelurequest(fd: LONGINT; sequence: LONGINT): LONGINT;
FUNCTION t_cancelureply(fd: LONGINT; sequence: LONGINT): LONGINT;
FUNCTION t_cancelsynchronouscalls(fd: LONGINT): LONGINT;
FUNCTION t_installnotifier(fd: LONGINT; proc: OTNotifyProcPtr; contextPtr: UNIV Ptr): LONGINT;
PROCEDURE t_removenotifier(fd: LONGINT);
{  STREAMS Primitives }

FUNCTION getmsg(fd: LONGINT; VAR ctlbuf: strbuf; VAR databuf: strbuf; VAR flagsp: LONGINT): LONGINT;
FUNCTION putmsg(fd: LONGINT; {CONST}VAR ctlbuf: strbuf; {CONST}VAR databuf: strbuf; flags: LONGINT): LONGINT;
FUNCTION getpmsg(fd: LONGINT; VAR ctlbuf: strbuf; VAR databuf: strbuf; VAR bandp: LONGINT; VAR flagsp: LONGINT): LONGINT;
FUNCTION putpmsg(fd: LONGINT; {CONST}VAR ctlbuf: strbuf; {CONST}VAR databuf: strbuf; band: LONGINT; flags: LONGINT): LONGINT;
{  Raw streams operations. }

FUNCTION stream_installnotifier(fd: LONGINT; proc: OTNotifyProcPtr; contextPtr: UNIV Ptr): LONGINT;
FUNCTION stream_blocking(fd: LONGINT): LONGINT;
FUNCTION stream_nonblocking(fd: LONGINT): LONGINT;
FUNCTION stream_isblocking(fd: LONGINT): LONGINT;
FUNCTION stream_synchronous(fd: LONGINT): LONGINT;
FUNCTION stream_asynchronous(fd: LONGINT): LONGINT;
FUNCTION stream_issynchronous(fd: LONGINT): LONGINT;
FUNCTION stream_open(path: CStringPtr; flags: UInt32): LONGINT;
FUNCTION stream_close(fd: LONGINT): LONGINT;
FUNCTION stream_read(fd: LONGINT; buf: UNIV Ptr; len: size_t): LONGINT;
FUNCTION stream_write(fd: LONGINT; buf: UNIV Ptr; len: size_t): LONGINT;
FUNCTION stream_ioctl(fd: LONGINT; cmd: UInt32; ...): LONGINT; C;
FUNCTION stream_pipe(VAR fds: LONGINT): LONGINT;
{$ENDC}  {CALL_NOT_IN_CARBON}

TYPE
	pollfdPtr = ^pollfd;
	pollfd = RECORD
		fd:						SInt32;
		events:					INTEGER;
		revents:				INTEGER;
		_ifd:					LONGINT;								{  Internal "fd" for the benefit of the kernel  }
	END;

{$IFC CALL_NOT_IN_CARBON }
FUNCTION poll(VAR fds: pollfd; nfds: size_t; timeout: UInt32): LONGINT;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}


{$ifc not undefined __MWERKS and TARGET_CPU_68K}
	{$pragmac d0_pointers reset}
{$endc}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OpenTransportUNIXIncludes}

{$ENDC} {__OPENTRANSPORTUNIX__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
