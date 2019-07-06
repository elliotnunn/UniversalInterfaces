{
 	File:		OCEMessaging.p
 
 	Contains:	Apple Open Collaboration Environment Messaging Interfaces.
 
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
 UNIT OCEMessaging;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OCEMESSAGING__}
{$SETC __OCEMESSAGING__ := 1}

{$I+}
{$SETC OCEMessagingIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}

{$IFC UNDEFINED __DIGITALSIGNATURE__}
{$I DigitalSignature.p}
{$ENDC}
{$IFC UNDEFINED __OCE__}
{$I OCE.p}
{$ENDC}
{$IFC UNDEFINED __OCEAUTHDIR__}
{$I OCEAuthDir.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{****************************************************************************}
{ Definitions common to OCEMessaging and to OCEMail. These relate to addressing,
message ids and priorities, etc. }

{ Values of IPMPriority }

CONST
	kIPMAnyPriority				= 0;							{  FOR FILTER ONLY  }
	kIPMNormalPriority			= 1;
	kIPMLowPriority				= 2;
	kIPMHighPriority			= 3;


TYPE
	IPMPriority							= Byte;
{ Values of IPMAccessMode }

CONST
	kIPMAtMark					= 0;
	kIPMFromStart				= 1;
	kIPMFromLEOM				= 2;
	kIPMFromMark				= 3;


TYPE
	IPMAccessMode						= UInt16;

CONST
	kIPMUpdateMsgBit			= 4;
	kIPMNewMsgBit				= 5;
	kIPMDeleteMsgBit			= 6;

{ Values of IPMNotificationType }
	kIPMUpdateMsgMask			= $10;
	kIPMNewMsgMask				= $20;
	kIPMDeleteMsgMask			= $40;


TYPE
	IPMNotificationType					= Byte;
{ Values of IPMSenderTag }

CONST
	kIPMSenderRStringTag		= 0;
	kIPMSenderRecordIDTag		= 1;


TYPE
	IPMSenderTag						= UInt16;

CONST
	kIPMFromDistListBit			= 0;
	kIPMDummyRecBit				= 1;
	kIPMFeedbackRecBit			= 2;							{  should be redirected to feedback queue  }
	kIPMReporterRecBit			= 3;							{  should be redirected to reporter original queue  }
	kIPMBCCRecBit				= 4;							{  this recipient is blind to all recipients of message  }

{ Values of OCERecipientOffsetFlags }
	kIPMFromDistListMask		= $01;
	kIPMDummyRecMask			= $02;
	kIPMFeedbackRecMask			= $04;
	kIPMReporterRecMask			= $08;
	kIPMBCCRecMask				= $10;


TYPE
	OCERecipientOffsetFlags				= Byte;
	OCECreatorTypePtr = ^OCECreatorType;
	OCECreatorType = RECORD
		msgCreator:				OSType;
		msgType:				OSType;
	END;


CONST
	kIPMTypeWildCard			= 'ipmw';
	kIPMFamilyUnspecified		= 0;
	kIPMFamilyWildCard			= $3F3F3F3F;					{  '????' * well known signature  }
	kIPMSignature				= 'ipms';						{  base type * well known message types  }
	kIPMReportNotify			= 'rptn';						{  routing feedback * well known message block types  }
	kIPMEnclosedMsgType			= 'emsg';						{  enclosed (nested) message  }
	kIPMReportInfo				= 'rpti';						{  recipient information  }
	kIPMDigitalSignature		= 'dsig';						{  digital signature  }

{ Values of IPMMsgFormat }
	kIPMOSFormatType			= 1;
	kIPMStringFormatType		= 2;


TYPE
	IPMMsgFormat						= UInt16;
	IPMStringMsgType					= Str32;
	TheTypePtr = ^TheType;
	TheType = RECORD
		CASE INTEGER OF
		0: (
			msgOSType:			OCECreatorType;
			);
		1: (
			msgStrType:			IPMStringMsgType;
			);
	END;

	IPMMsgTypePtr = ^IPMMsgType;
	IPMMsgType = RECORD
		format:					IPMMsgFormat;							{  IPMMsgFormat }
		theType:				TheType;
	END;

{
Following are the known extension values for IPM addresses handled by Apple.
We define the definition of the entn extension below.
}

CONST
	kOCEalanXtn					= 'alan';
	kOCEentnXtn					= 'entn';						{  entn = entity name (aka DSSpec)  }
	kOCEaphnXtn					= 'aphn';

{
Following are the specific definitions for the extension for the standard
OCEMail 'entn' addresses.  [Note, the actual extension is formatted as in
IPMEntityNameExtension.]
}
{ entn extension forms }
	kOCEAddrXtn					= 'addr';
	kOCEQnamXtn					= 'qnam';
	kOCEAttrXtn					= 'attr';						{  an attribute specification  }
	kOCESpAtXtn					= 'spat';						{  specific attribute  }

{
Following are the specific definitions for standard
OCEMail 'aphn' extension value.  

All RStrings here are packed (e.g. truncated to length) and even padded (e.g.
if length odd, then a pad byte (zero) should be introduced before the next field).

The extension value is in the packed form of the following structure:
	RString		phoneNumber;
	RString		modemType;
	Str32		queueuName;

The body of phoneNumber compound RString is in the packed form of the following structure:
	short 		subType;
	RString 	countryCode;				// used when subType == kOCEUseHandyDial
	RString		areaCode;					// used when subType == kOCEUseHandyDial
	RString		phone;						// used when subType == kOCEUseHandyDial
	RString		postFix;					// used when subType == kOCEUseHandyDial
	RString		nonHandyDialString;			// used when subType == kOCEDontUseHandyDial
}
{ phoneNumber sub type constants }
	kOCEUseHandyDial			= 1;
	kOCEDontUseHandyDial		= 2;

{ FORMAT OF A PACKED FORM RECIPIENT }

TYPE
	ProtoOCEPackedRecipientPtr = ^ProtoOCEPackedRecipient;
	ProtoOCEPackedRecipient = RECORD
		dataLength:				UInt16;
	END;


CONST
	kOCEPackedRecipientMaxBytes	= 4094;


TYPE
	OCEPackedRecipientPtr = ^OCEPackedRecipient;
	OCEPackedRecipient = RECORD
		dataLength:				UInt16;
		data:					PACKED ARRAY [0..4093] OF Byte;
	END;

	IPMEntnQueueExtensionPtr = ^IPMEntnQueueExtension;
	IPMEntnQueueExtension = RECORD
		queueName:				Str32;
	END;

{ kOCEAttrXtn }
	IPMEntnAttributeExtensionPtr = ^IPMEntnAttributeExtension;
	IPMEntnAttributeExtension = RECORD
		attributeName:			AttributeType;
	END;

{ kOCESpAtXtn }
	IPMEntnSpecificAttributeExtensionPtr = ^IPMEntnSpecificAttributeExtension;
	IPMEntnSpecificAttributeExtension = RECORD
		attributeCreationID:	AttributeCreationID;
		attributeName:			AttributeType;
	END;

{ All IPM entn extensions fit within the following }
	IPMEntityNameExtensionPtr = ^IPMEntityNameExtension;
	IPMEntityNameExtension = RECORD
		subExtensionType:		OSType;
		CASE INTEGER OF
		0: (
			specificAttribute:	IPMEntnSpecificAttributeExtension;
			);
		1: (
			attribute:			IPMEntnAttributeExtension;
			);
		2: (
			queue:				IPMEntnQueueExtension;
			);
	END;

{ addresses with kIPMNBPXtn should specify this nbp type }
	IPMMsgIDPtr = ^IPMMsgID;
	IPMMsgID = RECORD
		id:						ARRAY [0..3] OF UInt32;
	END;


{ Values of IPMHeaderSelector }

CONST
	kIPMTOC						= 0;
	kIPMSender					= 1;
	kIPMProcessHint				= 2;
	kIPMMessageTitle			= 3;
	kIPMMessageType				= 4;
	kIPMFixedInfo				= 7;


TYPE
	IPMHeaderSelector					= Byte;
	TheSenderPtr = ^TheSender;
	TheSender = RECORD
		CASE INTEGER OF
		0: (
			rString:			RString;
			);
		1: (
			rid:				PackedRecordID;
			);
	END;

	IPMSenderPtr = ^IPMSender;
	IPMSender = RECORD
		sendTag:				IPMSenderTag;
		theSender:				TheSender;
	END;

{****************************************************************************}
{ Definitions specific to OCEMessaging }
	IPMContextRef						= UInt32;
	IPMQueueRef							= UInt32;
	IPMMsgRef							= UInt32;
	IPMSeqNum							= UInt32;
	IPMProcHint							= Str32;
	IPMQueueName						= Str32;
{$IFC TYPED_FUNCTION_POINTERS}
	IPMNoteProcPtr = PROCEDURE(queue: IPMQueueRef; seqNum: IPMSeqNum; notificationType: ByteParameter; userData: UInt32);
{$ELSEC}
	IPMNoteProcPtr = ProcPtr;
{$ENDC}

	IPMNoteUPP = UniversalProcPtr;

CONST
	uppIPMNoteProcInfo = $000037C0;

FUNCTION NewIPMNoteProc(userRoutine: IPMNoteProcPtr): IPMNoteUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallIPMNoteProc(queue: IPMQueueRef; seqNum: IPMSeqNum; notificationType: ByteParameter; userData: UInt32; userRoutine: IPMNoteUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	IPMFixedHdrInfoPtr = ^IPMFixedHdrInfo;
	IPMFixedHdrInfo = RECORD
		version:				UInt16;
		authenticated:			BOOLEAN;
		signatureEnclosed:		BOOLEAN;								{   digital signature enclosed  }
		msgSize:				UInt32;
		notification:			SInt8;
		priority:				SInt8;
		blockCount:				UInt16;
		originalRcptCount:		UInt16;									{ 		original number of recipients  }
		refCon:					UInt32;									{ 		Client defined data  }
		reserved:				UInt16;
		creationTime:			UTCTime;								{ 		Time when it was created  }
		msgID:					IPMMsgID;
		family:					OSType;									{  family this msg belongs (e.g. mail)  }
	END;


CONST
	kIPMDeliveryNotificationBit	= 0;
	kIPMNonDeliveryNotificationBit = 1;
	kIPMEncloseOriginalBit		= 2;
	kIPMSummaryReportBit		= 3;							{  modify enclose original to only on error  }
	kIPMOriginalOnlyOnErrorBit	= 4;

	kIPMNoNotificationMask		= $00;
	kIPMDeliveryNotificationMask = $01;
	kIPMNonDeliveryNotificationMask = $02;
	kIPMDontEncloseOriginalMask	= $00;
	kIPMEncloseOriginalMask		= $04;
	kIPMImmediateReportMask		= $00;
	kIPMSummaryReportMask		= $08;
	kIPMOriginalOnlyOnErrorMask	= $10;
	kIPMEncloseOriginalOnErrorMask = $14;

{ standard Non delivery codes }
	kIPMNoSuchRecipient			= $0001;
	kIPMRecipientMalformed		= $0002;
	kIPMRecipientAmbiguous		= $0003;
	kIPMRecipientAccessDenied	= $0004;
	kIPMGroupExpansionProblem	= $0005;
	kIPMMsgUnreadable			= $0006;
	kIPMMsgExpired				= $0007;
	kIPMMsgNoTranslatableContent = $0008;
	kIPMRecipientReqStdCont		= $0009;
	kIPMRecipientReqSnapShot	= $000A;
	kIPMNoTransferDiskFull		= $000B;
	kIPMNoTransferMsgRejectedbyDest = $000C;
	kIPMNoTransferMsgTooLarge	= $000D;

{***********************************************************************}
{
This is the structure that will be returned by enumerate and getmsginfo
This definition is just to give you a template, the position of msgType
is variable since this is a packed structure.  procHint and msgType are
packed and even length padded.

* master message info }

TYPE
	IPMMsgInfoPtr = ^IPMMsgInfo;
	IPMMsgInfo = RECORD
		sequenceNum:			IPMSeqNum;
		userData:				UInt32;
		respIndex:				UInt16;
		padByte:				SInt8;
		priority:				SInt8;
		msgSize:				UInt32;
		originalRcptCount:		UInt16;
		reserved:				UInt16;
		creationTime:			UTCTime;
		msgID:					IPMMsgID;
		family:					OSType;									{  family this msg belongs (e.g. mail)  }
		procHint:				IPMProcHint;
		filler2:				SInt8;
		msgType:				IPMMsgType;
	END;

	IPMBlockType						= OCECreatorType;
	IPMBlockTypePtr 					= ^IPMBlockType;
	IPMTOCPtr = ^IPMTOC;
	IPMTOC = RECORD
		blockType:				IPMBlockType;
		blockOffset:			LONGINT;
		blockSize:				UInt32;
		blockRefCon:			UInt32;
	END;

{
The following structure is just to describe the layout of the SingleFilter.
Each field should be packed and word aligned when passed to the IPM ToolBox.
}
	IPMSingleFilterPtr = ^IPMSingleFilter;
	IPMSingleFilter = RECORD
		priority:				SInt8;
		padByte:				SInt8;
		family:					OSType;									{  family this msg belongs (e.g. mail), '????' for all  }
		script:					ScriptCode;								{  Language Identifier  }
		hint:					IPMProcHint;
		filler2:				SInt8;
		msgType:				IPMMsgType;
	END;

	IPMFilterPtr = ^IPMFilter;
	IPMFilter = RECORD
		count:					UInt16;
		sFilters:				ARRAY [0..0] OF IPMSingleFilter;
	END;

{************************************************************************
Following structures define the “start” of a recipient report block and the
elements of the array respectively.
}
	IPMReportBlockHeaderPtr = ^IPMReportBlockHeader;
	IPMReportBlockHeader = RECORD
		msgID:					IPMMsgID;								{  message id of the original  }
		creationTime:			UTCTime;								{  creation time of the report  }
	END;

	OCERecipientReportPtr = ^OCERecipientReport;
	OCERecipientReport = RECORD
		rcptIndex:				UInt16;									{  index of recipient in original message  }
		result:					OSErr;									{  result of sending letter to this recipient }
	END;

{***********************************************************************}
	IPMParamBlockPtr = ^IPMParamBlock;
{$IFC TYPED_FUNCTION_POINTERS}
	IPMIOCompletionProcPtr = PROCEDURE(paramBlock: IPMParamBlockPtr);
{$ELSEC}
	IPMIOCompletionProcPtr = Register68kProcPtr;
{$ENDC}

	IPMIOCompletionUPP = UniversalProcPtr;
	IPMOpenContextPBPtr = ^IPMOpenContextPB;
	IPMOpenContextPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		contextRef:				IPMContextRef;							{  <--  Context reference to be used in further calls }
	END;

	IPMCloseContextPB					= IPMOpenContextPB;
	IPMCloseContextPBPtr 				= ^IPMCloseContextPB;
	IPMCreateQueuePBPtr = ^IPMCreateQueuePB;
	IPMCreateQueuePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		filler1:				LONGINT;
		queue:					OCERecipientPtr;
		identity:				AuthIdentity;							{  used only if queue is remote  }
		owner:					PackedRecordIDPtr;						{  used only if queue is remote  }
	END;

{ For createqueue and deletequeue only queue and identity are used }
	IPMDeleteQueuePB					= IPMCreateQueuePB;
	IPMDeleteQueuePBPtr 				= ^IPMDeleteQueuePB;
	IPMOpenQueuePBPtr = ^IPMOpenQueuePB;
	IPMOpenQueuePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		contextRef:				IPMContextRef;
		queue:					OCERecipientPtr;
		identity:				AuthIdentity;
		filter:					IPMFilterPtr;
		newQueueRef:			IPMQueueRef;
		notificationProc:		IPMNoteUPP;
		userData:				UInt32;
		noteType:				SInt8;
		padByte:				SInt8;
		reserved:				LONGINT;
		reserved2:				LONGINT;
	END;

	IPMCloseQueuePBPtr = ^IPMCloseQueuePB;
	IPMCloseQueuePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				IPMQueueRef;
	END;

	IPMEnumerateQueuePBPtr = ^IPMEnumerateQueuePB;
	IPMEnumerateQueuePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				IPMQueueRef;
		startSeqNum:			IPMSeqNum;
		getProcHint:			BOOLEAN;
		getMsgType:				BOOLEAN;
		filler:					INTEGER;
		filter:					IPMFilterPtr;
		numToGet:				UInt16;
		numGotten:				UInt16;
		enumCount:				UInt32;
		enumBuffer:				Ptr;									{  will be packed array of IPMMsgInfo  }
		actEnumCount:			UInt32;
	END;

	IPMChangeQueueFilterPB				= IPMEnumerateQueuePB;
	IPMChangeQueueFilterPBPtr 			= ^IPMChangeQueueFilterPB;
	IPMDeleteMsgRangePBPtr = ^IPMDeleteMsgRangePB;
	IPMDeleteMsgRangePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				IPMQueueRef;
		startSeqNum:			IPMSeqNum;
		endSeqNum:				IPMSeqNum;
		lastSeqNum:				IPMSeqNum;
	END;


	IPMOpenMsgPBPtr = ^IPMOpenMsgPB;
	IPMOpenMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				IPMQueueRef;
		sequenceNum:			IPMSeqNum;
		newMsgRef:				IPMMsgRef;
		actualSeqNum:			IPMSeqNum;
		exactMatch:				BOOLEAN;
		padByte:				SInt8;
		reserved:				LONGINT;
	END;


	IPMOpenHFSMsgPBPtr = ^IPMOpenHFSMsgPB;
	IPMOpenHFSMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		hfsPath:				FSSpecPtr;
		filler:					LONGINT;
		newMsgRef:				IPMMsgRef;
		filler2:				LONGINT;
		filler3:				SInt8;
		filler4:				BOOLEAN;
		reserved:				LONGINT;
	END;


	IPMOpenBlockAsMsgPBPtr = ^IPMOpenBlockAsMsgPB;
	IPMOpenBlockAsMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		filler:					UInt32;
		newMsgRef:				IPMMsgRef;
		filler2:				ARRAY [0..6] OF UInt16;
		blockIndex:				UInt16;
	END;


	IPMCloseMsgPBPtr = ^IPMCloseMsgPB;
	IPMCloseMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		deleteMsg:				BOOLEAN;
		filler1:				BOOLEAN;
	END;


	IPMGetMsgInfoPBPtr = ^IPMGetMsgInfoPB;
	IPMGetMsgInfoPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		info:					IPMMsgInfoPtr;
	END;


	IPMReadHeaderPBPtr = ^IPMReadHeaderPB;
	IPMReadHeaderPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		fieldSelector:			UInt16;
		offset:					LONGINT;
		count:					UInt32;
		buffer:					Ptr;
		actualCount:			UInt32;
		filler:					UInt16;
		remaining:				UInt32;
	END;


	IPMReadRecipientPBPtr = ^IPMReadRecipientPB;
	IPMReadRecipientPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		rcptIndex:				UInt16;
		offset:					LONGINT;
		count:					UInt32;
		buffer:					Ptr;
		actualCount:			UInt32;
		reserved:				INTEGER;								{  must be zero  }
		remaining:				UInt32;
		originalIndex:			UInt16;
		recipientOffsetFlags:	SInt8;
		filler1:				BOOLEAN;
	END;


{
replyQueue works like recipient. [can no longer read it via ReadHeader]
OriginalIndex is meaningless, rcptFlags are used seperately and there are
currently none defined.
}
	IPMReadReplyQueuePB					= IPMReadRecipientPB;
	IPMReadReplyQueuePBPtr 				= ^IPMReadReplyQueuePB;
	IPMGetBlkIndexPBPtr = ^IPMGetBlkIndexPB;
	IPMGetBlkIndexPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		blockType:				IPMBlockType;
		index:					UInt16;
		startingFrom:			UInt16;
		actualBlockType:		IPMBlockType;
		actualBlockIndex:		UInt16;
	END;


	IPMReadMsgPBPtr = ^IPMReadMsgPB;
	IPMReadMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		mode:					IPMAccessMode;
		offset:					LONGINT;
		count:					UInt32;
		buffer:					Ptr;
		actualCount:			UInt32;
		blockIndex:				UInt16;
		remaining:				UInt32;
	END;

	IPMVerifySignaturePBPtr = ^IPMVerifySignaturePB;
	IPMVerifySignaturePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		signatureContext:		SIGContextPtr;
	END;

	IPMNewMsgPBPtr = ^IPMNewMsgPB;
	IPMNewMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		filler:					UInt32;
		recipient:				OCERecipientPtr;
		replyQueue:				OCERecipientPtr;
		procHint:				StringPtr;
		filler2:				UInt16;
		msgType:				IPMMsgTypePtr;
		refCon:					UInt32;
		newMsgRef:				IPMMsgRef;
		filler3:				UInt16;
		filler4:				LONGINT;
		identity:				AuthIdentity;
		sender:					IPMSenderPtr;
		internalUse:			UInt32;
		internalUse2:			UInt32;
	END;

	IPMNewHFSMsgPBPtr = ^IPMNewHFSMsgPB;
	IPMNewHFSMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		hfsPath:				FSSpecPtr;
		recipient:				OCERecipientPtr;
		replyQueue:				OCERecipientPtr;
		procHint:				StringPtr;
		filler2:				UInt16;
		msgType:				IPMMsgTypePtr;
		refCon:					UInt32;
		newMsgRef:				IPMMsgRef;
		filler3:				UInt16;
		filler4:				LONGINT;
		identity:				AuthIdentity;
		sender:					IPMSenderPtr;
		internalUse:			UInt32;
		internalUse2:			UInt32;
	END;

	IPMNestMsgPBPtr = ^IPMNestMsgPB;
	IPMNestMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		filler:					ARRAY [0..8] OF UInt16;
		refCon:					UInt32;
		msgToNest:				IPMMsgRef;
		filler2:				UInt16;
		startingOffset:			LONGINT;
	END;


	IPMNewNestedMsgBlockPBPtr = ^IPMNewNestedMsgBlockPB;
	IPMNewNestedMsgBlockPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		recipient:				OCERecipientPtr;
		replyQueue:				OCERecipientPtr;
		procHint:				StringPtr;
		filler1:				UInt16;
		msgType:				IPMMsgTypePtr;
		refCon:					UInt32;
		newMsgRef:				IPMMsgRef;
		filler2:				UInt16;
		startingOffset:			LONGINT;
		identity:				AuthIdentity;
		sender:					IPMSenderPtr;
		internalUse:			UInt32;
		internalUse2:			UInt32;
	END;


	IPMEndMsgPBPtr = ^IPMEndMsgPB;
	IPMEndMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		msgID:					IPMMsgID;
		msgTitle:				RStringPtr;
		deliveryNotification:	SInt8;
		priority:				SInt8;
		cancel:					BOOLEAN;
		padByte:				SInt8;
		reserved:				LONGINT;
		signature:				SIGSignaturePtr;
		signatureSize:			Size;
		signatureContext:		SIGContextPtr;
																		{  family this msg belongs (e.g. mail) use kIPMFamilyUnspecified by default  }
		family:					OSType;
	END;


	IPMAddRecipientPBPtr = ^IPMAddRecipientPB;
	IPMAddRecipientPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		recipient:				OCERecipientPtr;
		reserved:				LONGINT;
	END;


	IPMAddReplyQueuePBPtr = ^IPMAddReplyQueuePB;
	IPMAddReplyQueuePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		filler:					LONGINT;
		replyQueue:				OCERecipientPtr;
	END;


	IPMNewBlockPBPtr = ^IPMNewBlockPB;
	IPMNewBlockPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		blockType:				IPMBlockType;
		filler:					ARRAY [0..4] OF UInt16;
		refCon:					UInt32;
		filler2:				ARRAY [0..2] OF UInt16;
		startingOffset:			LONGINT;
	END;


	IPMWriteMsgPBPtr = ^IPMWriteMsgPB;
	IPMWriteMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		mode:					IPMAccessMode;
		offset:					LONGINT;
		count:					UInt32;
		buffer:					Ptr;
		actualCount:			UInt32;
		currentBlock:			BOOLEAN;
		filler1:				BOOLEAN;
	END;



	IPMParamBlock = RECORD
		CASE INTEGER OF
		0: (
			qLink:				Ptr;
			reservedH1:			LONGINT;
			reservedH2:			LONGINT;
			ioCompletion:		IPMIOCompletionUPP;
			ioResult:			OSErr;
			saveA5:				LONGINT;
			reqCode:			INTEGER;
		   );
		1: (
			openContextPB:		IPMOpenContextPB;
			);
		2: (
			closeContextPB:		IPMCloseContextPB;
			);
		3: (
			createQueuePB:		IPMCreateQueuePB;
			);
		4: (
			deleteQueuePB:		IPMDeleteQueuePB;
			);
		5: (
			openQueuePB:		IPMOpenQueuePB;
			);
		6: (
			closeQueuePB:		IPMCloseQueuePB;
			);
		7: (
			enumerateQueuePB:	IPMEnumerateQueuePB;
			);
		8: (
			changeQueueFilterPB: IPMChangeQueueFilterPB;
			);
		9: (
			deleteMsgRangePB:	IPMDeleteMsgRangePB;
			);
		10: (
			openMsgPB:			IPMOpenMsgPB;
			);
		11: (
			openHFSMsgPB:		IPMOpenHFSMsgPB;
			);
		12: (
			openBlockAsMsgPB:	IPMOpenBlockAsMsgPB;
			);
		13: (
			closeMsgPB:			IPMCloseMsgPB;
			);
		14: (
			getMsgInfoPB:		IPMGetMsgInfoPB;
			);
		15: (
			readHeaderPB:		IPMReadHeaderPB;
			);
		16: (
			readRecipientPB:	IPMReadRecipientPB;
			);
		17: (
			readReplyQueuePB:	IPMReadReplyQueuePB;
			);
		18: (
			getBlkIndexPB:		IPMGetBlkIndexPB;
			);
		19: (
			readMsgPB:			IPMReadMsgPB;
			);
		20: (
			verifySignaturePB:	IPMVerifySignaturePB;
			);
		21: (
			newMsgPB:			IPMNewMsgPB;
			);
		22: (
			newHFSMsgPB:		IPMNewHFSMsgPB;
			);
		23: (
			nestMsgPB:			IPMNestMsgPB;
			);
		24: (
			newNestedMsgBlockPB: IPMNewNestedMsgBlockPB;
			);
		25: (
			endMsgPB:			IPMEndMsgPB;
			);
		26: (
			addRecipientPB:		IPMAddRecipientPB;
			);
		27: (
			addReplyQueuePB:	IPMAddReplyQueuePB;
			);
		28: (
			newBlockPB:			IPMNewBlockPB;
			);
		29: (
			writeMsgPB:			IPMWriteMsgPB;
			);
	END;


CONST
	uppIPMIOCompletionProcInfo = $00009802;

PROCEDURE CallIPMIOCompletionProc(paramBlock: IPMParamBlockPtr; userRoutine: IPMIOCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION NewIPMIOCompletionProc(userRoutine: IPMIOCompletionProcPtr): IPMIOCompletionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}
FUNCTION IPMOpenContext(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0400, $AA5E;
	{$ENDC}
FUNCTION IPMCloseContext(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0401, $AA5E;
	{$ENDC}
FUNCTION IPMNewMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0402, $AA5E;
	{$ENDC}
FUNCTION IPMNewBlock(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0404, $AA5E;
	{$ENDC}
FUNCTION IPMNewNestedMsgBlock(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0405, $AA5E;
	{$ENDC}
FUNCTION IPMNestMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0406, $AA5E;
	{$ENDC}
FUNCTION IPMWriteMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0407, $AA5E;
	{$ENDC}
FUNCTION IPMEndMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0408, $AA5E;
	{$ENDC}
FUNCTION IPMOpenQueue(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0409, $AA5E;
	{$ENDC}
FUNCTION IPMCloseQueue(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $040A, $AA5E;
	{$ENDC}
{ Always synchronous }
FUNCTION IPMVerifySignature(paramBlock: IPMParamBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $0422, $AA5E;
	{$ENDC}
FUNCTION IPMOpenMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $040B, $AA5E;
	{$ENDC}
FUNCTION IPMCloseMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $040C, $AA5E;
	{$ENDC}
FUNCTION IPMReadMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $040D, $AA5E;
	{$ENDC}
FUNCTION IPMReadHeader(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $040E, $AA5E;
	{$ENDC}
FUNCTION IPMOpenBlockAsMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $040F, $AA5E;
	{$ENDC}
FUNCTION IPMNewHFSMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $041E, $AA5E;
	{$ENDC}
FUNCTION IPMReadRecipient(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0410, $AA5E;
	{$ENDC}
FUNCTION IPMReadReplyQueue(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0421, $AA5E;
	{$ENDC}
FUNCTION IPMCreateQueue(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0411, $AA5E;
	{$ENDC}
FUNCTION IPMDeleteQueue(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0412, $AA5E;
	{$ENDC}
FUNCTION IPMEnumerateQueue(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0413, $AA5E;
	{$ENDC}
FUNCTION IPMChangeQueueFilter(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0414, $AA5E;
	{$ENDC}
FUNCTION IPMDeleteMsgRange(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0415, $AA5E;
	{$ENDC}
FUNCTION IPMAddRecipient(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0403, $AA5E;
	{$ENDC}
FUNCTION IPMAddReplyQueue(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $041D, $AA5E;
	{$ENDC}
FUNCTION IPMOpenHFSMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0417, $AA5E;
	{$ENDC}
FUNCTION IPMGetBlkIndex(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0418, $AA5E;
	{$ENDC}
FUNCTION IPMGetMsgInfo(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0419, $AA5E;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OCEMessagingIncludes}

{$ENDC} {__OCEMESSAGING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
