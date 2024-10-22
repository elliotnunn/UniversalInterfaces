{
 	File:		NetSprocket.p
 
 	Contains:	Games Sprockets: NetSprocket interfaces
 
 	Version:	Technology:	NetSprocket 1.0.2
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1996-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT NetSprocket;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __NETSPROCKET__}
{$SETC __NETSPROCKET__ := 1}

{$I+}
{$SETC NetSprocketIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}

{$IFC UNDEFINED __OPENTRANSPORT__}
{$I OpenTransport.p}
{$ENDC}
{$IFC UNDEFINED __OPENTPTINTERNET__}
{$I OpenTptInternet.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}


CONST
	kNSpMaxPlayerNameLen		= 31;
	kNSpMaxGroupNameLen			= 31;
	kNSpMaxPasswordLen			= 31;
	kNSpMaxGameNameLen			= 31;
	kNSpMaxDefinitionStringLen	= 255;


{ NetSprocket basic types }

TYPE
	NSpGameReference = ^LONGINT;
	NSpProtocolReference = ^LONGINT;
	NSpProtocolListReference = ^LONGINT;
	NSpAddressReference = ^LONGINT;
	NSpEventCode						= SInt32;
	NSpGameID							= SInt32;
	NSpPlayerID							= SInt32;
	NSpGroupID							= NSpPlayerID;
	NSpPlayerType						= UInt32;
	NSpFlags							= SInt32;
{ Individual player info }
	NSpPlayerInfoPtr = ^NSpPlayerInfo;
	NSpPlayerInfo = RECORD
		id:						NSpPlayerID;
		playerType:				NSpPlayerType;							{  was type }
		name:					Str31;
		groupCount:				UInt32;
		groups:					ARRAY [0..0] OF NSpGroupID;
	END;

{ list of all players }
	NSpPlayerEnumerationPtr = ^NSpPlayerEnumeration;
	NSpPlayerEnumeration = RECORD
		count:					UInt32;
		playerInfo:				ARRAY [0..0] OF NSpPlayerInfoPtr;
	END;

{ Individual group info }
	NSpGroupInfoPtr = ^NSpGroupInfo;
	NSpGroupInfo = RECORD
		id:						NSpGroupID;
		playerCount:			UInt32;
		players:				ARRAY [0..0] OF NSpPlayerID;
	END;

{ List of all groups }
	NSpGroupEnumerationPtr = ^NSpGroupEnumeration;
	NSpGroupEnumeration = RECORD
		count:					UInt32;
		groups:					ARRAY [0..0] OF NSpGroupInfoPtr;
	END;

{ Topology types }
	NSpTopology							= UInt32;

CONST
	kNSpClientServer			= $00000001;

{ Game information }

TYPE
	NSpGameInfoPtr = ^NSpGameInfo;
	NSpGameInfo = RECORD
		maxPlayers:				UInt32;
		currentPlayers:			UInt32;
		currentGroups:			UInt32;
		topology:				NSpTopology;
		reserved:				UInt32;
		name:					Str31;
		password:				Str31;
	END;

{ Structure used for sending and receiving network messages }
	NSpMessageHeaderPtr = ^NSpMessageHeader;
	NSpMessageHeader = RECORD
		version:				UInt32;									{  Used by NetSprocket.  Don't touch this  }
		what:					SInt32;									{  The kind of message (e.g. player joined)  }
		from:					NSpPlayerID;							{  ID of the sender  }
		toID:					NSpPlayerID;							{  (player or group) id of the intended recipient (was "to)  }
		id:						UInt32;									{  Unique ID for this message & (from) player  }
		when:					UInt32;									{  Timestamp for the message  }
		messageLen:				UInt32;									{  Bytes of data in the entire message (including the header)  }
	END;

{ NetSprocket-defined message structures }
	NSpErrorMessagePtr = ^NSpErrorMessage;
	NSpErrorMessage = RECORD
		header:					NSpMessageHeader;
		error:					OSStatus;
	END;

	NSpJoinRequestMessagePtr = ^NSpJoinRequestMessage;
	NSpJoinRequestMessage = RECORD
		header:					NSpMessageHeader;
		name:					Str31;
		password:				Str31;
		theType:				UInt32;
		customDataLen:			UInt32;
		customData:				SInt8;
	END;

	NSpJoinApprovedMessagePtr = ^NSpJoinApprovedMessage;
	NSpJoinApprovedMessage = RECORD
		header:					NSpMessageHeader;
	END;

	NSpJoinDeniedMessagePtr = ^NSpJoinDeniedMessage;
	NSpJoinDeniedMessage = RECORD
		header:					NSpMessageHeader;
		reason:					Str255;
	END;

	NSpPlayerJoinedMessagePtr = ^NSpPlayerJoinedMessage;
	NSpPlayerJoinedMessage = RECORD
		header:					NSpMessageHeader;
		playerCount:			UInt32;
		playerInfo:				NSpPlayerInfo;
	END;

	NSpPlayerLeftMessagePtr = ^NSpPlayerLeftMessage;
	NSpPlayerLeftMessage = RECORD
		header:					NSpMessageHeader;
		playerCount:			UInt32;
		playerID:				NSpPlayerID;
	END;

	NSpHostChangedMessagePtr = ^NSpHostChangedMessage;
	NSpHostChangedMessage = RECORD
		header:					NSpMessageHeader;
		newHost:				NSpPlayerID;
	END;

	NSpGameTerminatedMessagePtr = ^NSpGameTerminatedMessage;
	NSpGameTerminatedMessage = RECORD
		header:					NSpMessageHeader;
	END;

{ Different kinds of messages.  These can NOT be bitwise ORed together }

CONST
	kNSpSendFlag_Junk			= $00100000;					{  will be sent (try once) when there is nothing else pending  }
	kNSpSendFlag_Normal			= $00200000;					{  will be sent immediately (try once)  }
	kNSpSendFlag_Registered		= $00400000;					{  will be sent immediately (guaranteed, in order)  }


{ Options for message delivery.  These can be bitwise ORed together with each other,
		as well as with ONE of the above }
	kNSpSendFlag_FailIfPipeFull	= $00000001;
	kNSpSendFlag_SelfSend		= $00000002;
	kNSpSendFlag_Blocking		= $00000004;


{ Options for Hosting Joining, and Deleting games }
	kNSpGameFlag_DontAdvertise	= $00000001;
	kNSpGameFlag_ForceTerminateGame = $00000002;

{ Message "what" types }
{ Apple reserves all negative "what" values (anything with bit 32 set) }
	kNSpSystemMessagePrefix		= $80000000;
	kNSpError					= $FFFFFFFF;
	kNSpJoinRequest				= $80000001;
	kNSpJoinApproved			= $80000002;
	kNSpJoinDenied				= $80000003;
	kNSpPlayerJoined			= $80000004;
	kNSpPlayerLeft				= $80000005;
	kNSpHostChanged				= $80000006;
	kNSpGameTerminated			= $80000007;


{ Special TPlayerIDs  for sending messages }
	kNSpAllPlayers				= $00000000;
	kNSpHostOnly				= $FFFFFFFF;


{ NetSprocket Error Codes }
	kNSpInitializationFailedErr	= -30360;
	kNSpAlreadyInitializedErr	= -30361;
	kNSpTopologyNotSupportedErr	= -30362;
	kNSpPipeFullErr				= -30364;
	kNSpHostFailedErr			= -30365;
	kNSpProtocolNotAvailableErr	= -30366;
	kNSpInvalidGameRefErr		= -30367;
	kNSpInvalidParameterErr		= -30369;
	kNSpOTNotPresentErr			= -30370;
	kNSpOTVersionTooOldErr		= -30371;
	kNSpMemAllocationErr		= -30373;
	kNSpAlreadyAdvertisingErr	= -30374;
	kNSpNotAdvertisingErr		= -30376;
	kNSpInvalidAddressErr		= -30377;
	kNSpFreeQExhaustedErr		= -30378;
	kNSpRemovePlayerFailedErr	= -30379;
	kNSpAddressInUseErr			= -30380;
	kNSpFeatureNotImplementedErr = -30381;
	kNSpNameRequiredErr			= -30382;
	kNSpInvalidPlayerIDErr		= -30383;
	kNSpInvalidGroupIDErr		= -30384;
	kNSpNoPlayersErr			= -30385;
	kNSpNoGroupsErr				= -30386;
	kNSpNoHostVolunteersErr		= -30387;
	kNSpCreateGroupFailedErr	= -30388;
	kNSpAddPlayerFailedErr		= -30389;
	kNSpInvalidDefinitionErr	= -30390;
	kNSpInvalidProtocolRefErr	= -30391;
	kNSpInvalidProtocolListErr	= -30392;
	kNSpTimeoutErr				= -30393;
	kNSpGameTerminatedErr		= -30394;
	kNSpConnectFailedErr		= -30395;
	kNSpSendFailedErr			= -30396;
	kNSpJoinFailedErr			= -30399;




{***********************  Initialization  ***********************}
FUNCTION NSpInitialize(inStandardMessageSize: UInt32; inBufferSize: UInt32; inQElements: UInt32; inGameID: NSpGameID; inTimeout: UInt32): OSStatus; C;



{*************************  Protocols  *************************}
{ Programmatic protocol routines }
FUNCTION NSpProtocol_New(inDefinitionString: ConstCStringPtr; VAR outReference: NSpProtocolReference): OSStatus; C;
PROCEDURE NSpProtocol_Dispose(inProtocolRef: NSpProtocolReference); C;
FUNCTION NSpProtocol_ExtractDefinitionString(inProtocolRef: NSpProtocolReference; outDefinitionString: CStringPtr): OSStatus; C;

{ Protocol list routines }
FUNCTION NSpProtocolList_New(inProtocolRef: NSpProtocolReference; VAR outList: NSpProtocolListReference): OSStatus; C;
PROCEDURE NSpProtocolList_Dispose(inProtocolList: NSpProtocolListReference); C;
FUNCTION NSpProtocolList_Append(inProtocolList: NSpProtocolListReference; inProtocolRef: NSpProtocolReference): OSStatus; C;
FUNCTION NSpProtocolList_Remove(inProtocolList: NSpProtocolListReference; inProtocolRef: NSpProtocolReference): OSStatus; C;
FUNCTION NSpProtocolList_RemoveIndexed(inProtocolList: NSpProtocolListReference; inIndex: UInt32): OSStatus; C;
FUNCTION NSpProtocolList_GetCount(inProtocolList: NSpProtocolListReference): UInt32; C;
FUNCTION NSpProtocolList_GetIndexedRef(inProtocolList: NSpProtocolListReference; inIndex: UInt32): NSpProtocolReference; C;

{ Helpers }
FUNCTION NSpProtocol_CreateAppleTalk(inNBPName: ConstStr31Param; inNBPType: ConstStr31Param; inMaxRTT: UInt32; inMinThruput: UInt32): NSpProtocolReference; C;
FUNCTION NSpProtocol_CreateIP(inPort: InetPort; inMaxRTT: UInt32; inMinThruput: UInt32): NSpProtocolReference; C;

{**********************  Human Interface  ***********************}

TYPE
	NSpEventProcPtr = ProcPtr;  { FUNCTION NSpEvent(VAR inEvent: EventRecord): BOOLEAN; }

FUNCTION NSpDoModalJoinDialog(inGameType: ConstStr31Param; inEntityListLabel: ConstStr255Param; VAR ioName: Str31; VAR ioPassword: Str31; inEventProcPtr: NSpEventProcPtr): NSpAddressReference; C;
FUNCTION NSpDoModalHostDialog(ioProtocolList: NSpProtocolListReference; VAR ioGameName: Str31; VAR ioPlayerName: Str31; VAR ioPassword: Str31; inEventProcPtr: NSpEventProcPtr): BOOLEAN; C;

{********************  Hosting and Joining  *********************}
FUNCTION NSpGame_Host(VAR outGame: NSpGameReference; inProtocolList: NSpProtocolListReference; inMaxPlayers: UInt32; inGameName: ConstStr31Param; inPassword: ConstStr31Param; inPlayerName: ConstStr31Param; inPlayerType: NSpPlayerType; inTopology: NSpTopology; inFlags: NSpFlags): OSStatus; C;
FUNCTION NSpGame_Join(VAR outGame: NSpGameReference; inAddress: NSpAddressReference; inName: ConstStr31Param; inPassword: ConstStr31Param; inType: NSpPlayerType; inCustomData: UNIV Ptr; inCustomDataLen: UInt32; inFlags: NSpFlags): OSStatus; C;
FUNCTION NSpGame_EnableAdvertising(inGame: NSpGameReference; inProtocol: NSpProtocolReference; inEnable: BOOLEAN): OSStatus; C;
FUNCTION NSpGame_Dispose(inGame: NSpGameReference; inFlags: NSpFlags): OSStatus; C;
FUNCTION NSpGame_GetInfo(inGame: NSpGameReference; VAR ioInfo: NSpGameInfo): OSStatus; C;
{*************************  Messaging  *************************}
FUNCTION NSpMessage_Send(inGame: NSpGameReference; VAR inMessage: NSpMessageHeader; inFlags: NSpFlags): OSStatus; C;
FUNCTION NSpMessage_Get(inGame: NSpGameReference): NSpMessageHeaderPtr; C;
PROCEDURE NSpMessage_Release(inGame: NSpGameReference; VAR inMessage: NSpMessageHeader); C;
{ Helpers }
FUNCTION NSpMessage_SendTo(inGame: NSpGameReference; inTo: NSpPlayerID; inWhat: SInt32; inData: UNIV Ptr; inDataLen: UInt32; inFlags: NSpFlags): OSStatus; C;

{********************  Player Information  *********************}
FUNCTION NSpPlayer_GetMyID(inGame: NSpGameReference): NSpPlayerID; C;
FUNCTION NSpPlayer_GetInfo(inGame: NSpGameReference; inPlayerID: NSpPlayerID; VAR outInfo: NSpPlayerInfoPtr): OSStatus; C;
PROCEDURE NSpPlayer_ReleaseInfo(inGame: NSpGameReference; inInfo: NSpPlayerInfoPtr); C;
FUNCTION NSpPlayer_GetEnumeration(inGame: NSpGameReference; VAR outPlayers: NSpPlayerEnumerationPtr): OSStatus; C;
PROCEDURE NSpPlayer_ReleaseEnumeration(inGame: NSpGameReference; inPlayers: NSpPlayerEnumerationPtr); C;
FUNCTION NSpPlayer_GetRoundTripTime(inGame: NSpGameReference; inPlayer: NSpPlayerID): UInt32; C;
FUNCTION NSpPlayer_GetThruput(inGame: NSpGameReference; inPlayer: NSpPlayerID): UInt32; C;

{********************  Group Management  *********************}
FUNCTION NSpGroup_New(inGame: NSpGameReference; VAR outGroupID: NSpGroupID): OSStatus; C;
FUNCTION NSpGroup_Dispose(inGame: NSpGameReference; inGroupID: NSpGroupID): OSStatus; C;
FUNCTION NSpGroup_AddPlayer(inGame: NSpGameReference; inGroupID: NSpGroupID; inPlayerID: NSpPlayerID): OSStatus; C;
FUNCTION NSpGroup_RemovePlayer(inGame: NSpGameReference; inGroupID: NSpGroupID; inPlayerID: NSpPlayerID): OSStatus; C;
FUNCTION NSpGroup_GetInfo(inGame: NSpGameReference; inGroupID: NSpGroupID; VAR outInfo: NSpGroupInfoPtr): OSStatus; C;
PROCEDURE NSpGroup_ReleaseInfo(inGame: NSpGameReference; inInfo: NSpGroupInfoPtr); C;
FUNCTION NSpGroup_GetEnumeration(inGame: NSpGameReference; VAR outGroups: NSpGroupEnumerationPtr): OSStatus; C;
PROCEDURE NSpGroup_ReleaseEnumeration(inGame: NSpGameReference; inGroups: NSpGroupEnumerationPtr); C;

{*************************  Utilities  **************************}
FUNCTION NSpGetVersion: NumVersion; C;
PROCEDURE NSpClearMessageHeader(VAR inMessage: NSpMessageHeader); C;
FUNCTION NSpGetCurrentTimeStamp(inGame: NSpGameReference): UInt32; C;
FUNCTION NSpConvertOTAddrToAddressReference(VAR inAddress: OTAddress): NSpAddressReference; C;
FUNCTION NSpConvertAddressReferenceToOTAddr(inAddress: NSpAddressReference): OTAddressPtr; C;
PROCEDURE NSpReleaseAddressReference(inAddress: NSpAddressReference); C;

{*********************** Advanced/Async routines ***************}

TYPE
	NSpCallbackProcPtr = ProcPtr;  { PROCEDURE NSpCallback(inGame: NSpGameReference; inContext: UNIV Ptr; inCode: NSpEventCode; inStatus: OSStatus; inCookie: UNIV Ptr); }

FUNCTION NSpInstallCallbackHandler(inHandler: NSpCallbackProcPtr; inContext: UNIV Ptr): OSStatus; C;


TYPE
	NSpJoinRequestHandlerProcPtr = ProcPtr;  { FUNCTION NSpJoinRequestHandler(inGame: NSpGameReference; VAR inMessage: NSpJoinRequestMessage; inContext: UNIV Ptr; VAR outReason: Str255): BOOLEAN; }

FUNCTION NSpInstallJoinRequestHandler(inHandler: NSpJoinRequestHandlerProcPtr; inContext: UNIV Ptr): OSStatus; C;


TYPE
	NSpMessageHandlerProcPtr = ProcPtr;  { FUNCTION NSpMessageHandler(inGame: NSpGameReference; VAR inMessage: NSpMessageHeader; inContext: UNIV Ptr): BOOLEAN; }

FUNCTION NSpInstallAsyncMessageHandler(inHandler: NSpMessageHandlerProcPtr; inContext: UNIV Ptr): OSStatus; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := NetSprocketIncludes}

{$ENDC} {__NETSPROCKET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
