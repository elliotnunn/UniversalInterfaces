{
 	File:		ADSPSecure.p
 
 	Contains:	Secure AppleTalk Data Stream Protocol Interfaces.
 
 	Version:	Technology:	AOCE Toolbox 1.02
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1994-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ADSPSecure;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ADSPSECURE__}
{$SETC __ADSPSECURE__ := 1}

{$I+}
{$SETC ADSPSecureIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __ADSP__}
{$I ADSP.p}
{$ENDC}
{$IFC UNDEFINED __OCEAUTHDIR__}
{$I OCEAuthDir.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ New ADSP control codes

 * open a secure connection }

CONST
	sdspOpen					= 229;

{
For secure connections, the eom field of ioParams contains two single-bit flags
(instead of a zero/non-zero byte). They are an encrypt flag (see below), and an
eom flag.  All other bits in that field should be zero.

To write an encrypted message, you must set an encrypt bit in the eom field of
the ioParams of your write call. Note: this flag is only checked on the first
write of a message (the first write on a connection, or the first write following
a write with eom set.
}
	dspEOMBit					= 0;							{  set if EOM at end of write  }
	dspEncryptBit				= 1;							{  set to encrypt message  }

	dspEOMMask					= $01;
	dspEncryptMask				= $02;


{
Define an ADSPSecure parameter block, as used for the secure Open call.

 * size of ADSPSecure workspace }
	sdspWorkSize				= 2048;


TYPE
	TRSecureParamsPtr = ^TRSecureParams;
	TRSecureParams = RECORD
		localCID:				UInt16;									{  local connection id  }
		remoteCID:				UInt16;									{  remote connection id  }
		remoteAddress:			AddrBlock;								{  address of remote end  }
		filterAddress:			AddrBlock;								{  address filter  }
		sendSeq:				UInt32;									{  local send sequence number  }
		sendWindow:				UInt16;									{  send window size  }
		recvSeq:				UInt32;									{  receive sequence number  }
		attnSendSeq:			UInt32;									{  attention send sequence number  }
		attnRecvSeq:			UInt32;									{  attention receive sequence number  }
		ocMode:					SInt8;									{  open connection mode  }
		ocInterval:				SInt8;									{  open connection request retry interval  }
		ocMaximum:				SInt8;									{  open connection request retry maximum  }
		secure:					BOOLEAN;								{   --> TRUE if session was authenticated  }
		sessionKey:				AuthKeyPtr;								{  <--> encryption key for session  }
		credentialsSize:		UInt32;									{   --> length of credentials  }
		credentials:			Ptr;									{   --> pointer to credentials  }
		workspace:				Ptr;									{   --> pointer to workspace for connection align on even boundary and length = sdspWorkSize  }
		recipient:				AuthIdentity;							{   --> identity of recipient (or initiator if active mode  }
		issueTime:				UTCTime;								{   --> when credentials were issued  }
		expiry:					UTCTime;								{   --> when credentials expiry  }
		initiator:				RecordIDPtr;							{  <--  RecordID of initiator returned here. Must give appropriate Buffer to hold RecordID (Only for passive or accept mode)  }
		hasIntermediary:		BOOLEAN;								{  <--  will be set if credentials has an intermediary  }
		filler1:				BOOLEAN;
		intermediary:			RecordIDPtr;							{  <--  RecordID of intermediary returned here. (If intermediary is found in credentials Must give appropriate Buffer to hold RecordID (Only for passive or accept mode)  }
	END;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ADSPSecureIncludes}

{$ENDC} {__ADSPSECURE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}