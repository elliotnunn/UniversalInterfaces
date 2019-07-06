{
     File:       OCEMail.p
 
     Contains:   Apple Open Collaboration Environment OCEMail Interfaces.
 
     Version:    Technology: AOCE Toolbox 1.02
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1994-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OCEMail;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OCEMAIL__}
{$SETC __OCEMAIL__ := 1}

{$I+}
{$SETC OCEMailIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
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
{$IFC UNDEFINED __OCEMESSAGING__}
{$I OCEMessaging.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{************************************************************************************}
{ Common Definitions }
{************************************************************************************}

{ reference to a new or open letter or message }

TYPE
	MailMsgRef							= LONGINT;
{ reference to an open msam queue }
	MSAMQueueRef						= LONGINT;
{ identifies slots managed by a PMSAM }
	MSAMSlotID							= UInt16;
{ reference to an active mailbox }
	MailboxRef							= LONGINT;
{ identifies slots within a mailbox }
	MailSlotID							= UInt16;
{ identifies a letter in a mailbox }
	MailSeqNumPtr = ^MailSeqNum;
	MailSeqNum = RECORD
		slotID:					MailSlotID;
		seqNum:					LONGINT;
	END;

{ A MailBuffer is used to describe a buffer used for an IO operation.
The location of the buffer is pointed to by 'buffer'. 
When reading, the size of the buffer is 'bufferSize' 
and the size of data actually read is 'dataSize'.
When writing, the size of data to be written is 'bufferSize' 
and the size of data actually written is 'dataSize'.
}
	MailBufferPtr = ^MailBuffer;
	MailBuffer = RECORD
		bufferSize:				LONGINT;
		buffer:					Ptr;
		dataSize:				LONGINT;
	END;

{ A MailReply is used to describe a commonly used reply buffer format.
It contains a count of tuples followed by an array of tuples.
The format of the tuple itself depends on each particular call.
}
	MailReplyPtr = ^MailReply;
	MailReply = RECORD
		tupleCount:				UInt16;
																		{  tuple[tupleCount]  }
	END;

{ Shared Memory Communication Area used when Mail Manager sends 
High Level Events to a PMSAM. 
}
	SMCAPtr = ^SMCA;
	SMCA = RECORD
		smcaLength:				UInt16;									{  includes size of smcaLength field  }
		result:					OSErr;
		userBytes:				LONGINT;
		CASE INTEGER OF
		0: (
			slotCID:			CreationID;								{  for create/modify/delete slot calls  }
			);
		1: (
			msgHint:			LONGINT;								{  for kMailEPPCMsgOpened  }
			);
	END;

{************************************************************************************}
{ Value of creator and types fields for messages and blocks defined by MailManager }

CONST
	kMailAppleMailCreator		= 'apml';						{  message and letter block creator  }
	kMailLtrMsgType				= 'lttr';						{  message type of letters, reports  }
	kMailLtrHdrType				= 'lthd';						{  contains letter header  }
	kMailContentType			= 'body';						{  contains content of letter  }
	kMailEnclosureListType		= 'elst';						{  contains list of enclosures  }
	kMailEnclosureDesktopType	= 'edsk';						{  contains desktop mgr info for enclosures  }
	kMailEnclosureFileType		= 'asgl';						{  contains a file enclosure, format is defined by AppleSingle  }
	kMailImageBodyType			= 'imag';						{  contains image of letter  }
	kMailMSAMType				= 'gwyi';						{  contains msam specific information  }
	kMailTunnelLtrType			= 'tunl';						{  used to read a tunnelled message  }
	kMailHopInfoType			= 'hopi';						{  used to read hopInfo for a tunnelled message  }
	kMailReportType				= 'rpti';						{  contains report info  }
	kMailFamily					= 'mail';						{  Defines family of "mail" msgs: content, header, etc  }
	kMailFamilyFile				= 'file';						{  Defines family of "direct display" msgs  }

{    
kMailImageBodyType:
    format is struct TPfPgDir - in Printing.h
    *   struct TPfPgDir (
    *       short   pageCount;      - number of pages in the image.
    *       long    iPgPos[129];    - iPgPos[n] is the offset from the start of the block
    *                               - to image of page n.
    *                               - iPgPos[n+1] - iPgPos[n] is the length of page n.

kMailReportType:
Reports have the isReport bit set in MailIndications and contain a block of type kMailReport.
This block has a header, IPMReportBlockHeader,
followed by an array of elements, each of type IPMRecipientReport

Various families used by mail or related msgs
}


{************************************************************************************}

TYPE
	MailAttributeID						= UInt16;
{ Values of MailAttributeID }
{ Message store attributes - stored in the catalog }
{ Will always be present in a letter and have fixed sizes }

CONST
	kMailLetterFlagsBit			= 1;							{  MailLetterFlags  }
																{  Letter attributes - stored in the letter will always be present in a letter and have fixed sizes  }
	kMailIndicationsBit			= 3;							{  MailIndications  }
	kMailMsgTypeBit				= 4;							{  OCECreatorType  }
	kMailLetterIDBit			= 5;							{  MailLetterID  }
	kMailSendTimeStampBit		= 6;							{  MailTime  }
	kMailNestingLevelBit		= 7;							{  MailNestingLevel  }
	kMailMsgFamilyBit			= 8;							{  OSType  }
																{  Letter attributes - stored in the letter may be present in a letter and have fixed sizes  }
	kMailReplyIDBit				= 9;							{  MailLetterID  }
	kMailConversationIDBit		= 10;							{  MailLetterID  }
																{  Letter attributes - stored in the letter may be present in a letter and have variable length sizes  }
	kMailSubjectBit				= 11;							{  RString  }
	kMailFromBit				= 12;							{  MailRecipient  }
	kMailToBit					= 13;							{  MailRecipient  }
	kMailCcBit					= 14;							{  MailRecipient  }
	kMailBccBit					= 15;							{  MailRecipient  }


TYPE
	MailAttributeMask					= UInt32;
{ Values of MailAttributeMask }

CONST
	kMailLetterFlagsMask		= $00000001;
	kMailIndicationsMask		= $00000004;
	kMailMsgTypeMask			= $00000008;
	kMailLetterIDMask			= $00000010;
	kMailSendTimeStampMask		= $00000020;
	kMailNestingLevelMask		= $00000040;
	kMailMsgFamilyMask			= $00000080;
	kMailReplyIDMask			= $00000100;
	kMailConversationIDMask		= $00000200;
	kMailSubjectMask			= $00000400;
	kMailFromMask				= $00000800;
	kMailToMask					= $00001000;
	kMailCcMask					= $00002000;
	kMailBccMask				= $00004000;


TYPE
	MailAttributeBitmap					= UInt32;
{************************************************************************************}
	MailLetterSystemFlags				= UInt16;
{ Values of MailLetterSystemFlags }
{ letter is available locally (either by nature or via cache) }

CONST
	kMailIsLocalBit				= 2;

	kMailIsLocalMask			= $00000004;


TYPE
	MailLetterUserFlags					= UInt16;

CONST
	kMailReadBit				= 0;							{  this letter has been opened  }
	kMailDontArchiveBit			= 1;							{  this letter is not to be archived either because it has already been archived or it should not be archived.  }
	kMailInTrashBit				= 2;							{  this letter is in trash  }

{ Values of MailLetterUserFlags }
	kMailReadMask				= $00000001;
	kMailDontArchiveMask		= $00000002;
	kMailInTrashMask			= $00000004;


TYPE
	MailLetterFlagsPtr = ^MailLetterFlags;
	MailLetterFlags = RECORD
		sysFlags:				MailLetterSystemFlags;
		userFlags:				MailLetterUserFlags;
	END;

	MailMaskedLetterFlagsPtr = ^MailMaskedLetterFlags;
	MailMaskedLetterFlags = RECORD
		flagMask:				MailLetterFlags;						{  flags that are to be set  }
		flagValues:				MailLetterFlags;						{  and their values  }
	END;


CONST
	kMailOriginalInReportBit	= 1;
	kMailNonReceiptReportsBit	= 3;
	kMailReceiptReportsBit		= 4;
	kMailForwardedBit			= 5;
	kMailPriorityBit			= 6;
	kMailIsReportWithOriginalBit = 8;
	kMailIsReportBit			= 9;
	kMailHasContentBit			= 10;
	kMailHasSignatureBit		= 11;
	kMailAuthenticatedBit		= 12;
	kMailSentBit				= 13;
	kMailNativeContentBit		= 14;
	kMailImageContentBit		= 15;
	kMailStandardContentBit		= 16;

{ Values of MailIndications }
	kMailStandardContentMask	= $00008000;
	kMailImageContentMask		= $00004000;
	kMailNativeContentMask		= $00002000;
	kMailSentMask				= $00001000;
	kMailAuthenticatedMask		= $00000800;
	kMailHasSignatureMask		= $00000400;
	kMailHasContentMask			= $00000200;
	kMailIsReportMask			= $00000100;
	kMailIsReportWithOriginalMask = $00000080;
	kMailPriorityMask			= $00000060;
	kMailForwardedMask			= $00000010;
	kMailReceiptReportsMask		= $00000008;
	kMailNonReceiptReportsMask	= $00000004;
	kMailOriginalInReportMask	= $00000003;


TYPE
	MailIndications						= UInt32;
{ values of the field originalInReport in MailIndications }

CONST
	kMailNoOriginal				= 0;							{  do not enclose original in reports  }
	kMailEncloseOnNonReceipt	= 3;							{  enclose original in non-delivery reports  }


TYPE
	MailLetterID						= IPMMsgID;
	MailLetterIDPtr 					= ^MailLetterID;
	MailTimePtr = ^MailTime;
	MailTime = RECORD
		time:					UTCTime;								{  current UTC(GMT) time  }
		offset:					UTCOffset;								{  offset from GMT  }
	END;

{ innermost letter has nestingLevel 0 }
	MailNestingLevel					= UInt16;
	MailRecipient						= OCERecipient;
	MailRecipientPtr 					= ^MailRecipient;
{************************************************************************************}

CONST
	kMailTextSegmentBit			= 0;
	kMailPictSegmentBit			= 1;
	kMailSoundSegmentBit		= 2;
	kMailStyledTextSegmentBit	= 3;
	kMailMovieSegmentBit		= 4;


TYPE
	MailSegmentMask						= UInt16;
{ Values of MailSegmentMask }

CONST
	kMailTextSegmentMask		= $00000001;
	kMailPictSegmentMask		= $00000002;
	kMailSoundSegmentMask		= $00000004;
	kMailStyledTextSegmentMask	= $00000008;
	kMailMovieSegmentMask		= $00000010;


TYPE
	MailSegmentType						= UInt16;
{ Values of MailSegmentType }

CONST
	kMailInvalidSegmentType		= 0;
	kMailTextSegmentType		= 1;
	kMailPictSegmentType		= 2;
	kMailSoundSegmentType		= 3;
	kMailStyledTextSegmentType	= 4;
	kMailMovieSegmentType		= 5;

{************************************************************************************}
	kMailErrorLogEntryVersion	= $0101;
	kMailMSAMErrorStringListID	= 128;							{  These 'STR#' resources should be  }
	kMailMSAMActionStringListID	= 129;							{  in the PMSAM resource fork  }


TYPE
	MailLogErrorType					= UInt16;
{ Values of MailLogErrorType }

CONST
	kMailELECorrectable			= 0;
	kMailELEError				= 1;
	kMailELEWarning				= 2;
	kMailELEInformational		= 3;


TYPE
	MailLogErrorCode					= INTEGER;
{ Values of MailLogErrorCode }

CONST
	kMailMSAMErrorCode			= 0;							{  positive codes are indices into PMSAM defined strings  }
	kMailMiscError				= -1;							{  negative codes are OCE defined  }
	kMailNoModem				= -2;							{  modem required, but missing  }


TYPE
	MailErrorLogEntryInfoPtr = ^MailErrorLogEntryInfo;
	MailErrorLogEntryInfo = RECORD
		version:				INTEGER;
		timeOccurred:			UTCTime;								{  do not fill in  }
		reportingPMSAM:			Str31;									{  do not fill in  }
		reportingMSAMSlot:		Str31;									{  do not fill in  }
		errorType:				MailLogErrorType;
		errorCode:				MailLogErrorCode;
		errorResource:			INTEGER;								{  resources are valid if  }
		actionResource:			INTEGER;								{  errorCode = kMailMSAMErrorCode index starts from 1  }
		filler:					UInt32;
		filler2:				UInt16;
	END;

{************************************************************************************}
	MailBlockMode						= INTEGER;
{ Values of MailBlockMode }

CONST
	kMailFromStart				= 1;							{  write data from offset calculated from  }
	kMailFromLEOB				= 2;							{  start of block, end of block,  }
	kMailFromMark				= 3;							{  or from the current mark  }


TYPE
	MailEnclosureInfoPtr = ^MailEnclosureInfo;
	MailEnclosureInfo = RECORD
		enclosureName:			StringPtr;
		catInfo:				CInfoPBPtr;
		comment:				StringPtr;
		icon:					Ptr;
	END;

{************************************************************************************}

CONST
	kOCESetupLocationNone		= 0;							{  disconnect state  }
	kOCESetupLocationMax		= 8;							{  maximum location value  }


TYPE
	OCESetupLocation					= CHAR;
{ location state is a bitmask, 0x1=>1st location active, 
 * 0x2 => 2nd, 0x4 => 3rd, etc.
 }
	MailLocationFlags					= UInt8;
	MailLocationInfoPtr = ^MailLocationInfo;
	MailLocationInfo = RECORD
		location:				SInt8;
		active:					SInt8;
	END;

{************************************************************************************}
{ Definitions for Personal MSAMs }
{************************************************************************************}

CONST
	kMailEPPCMsgVersion			= 3;


TYPE
	MailEPPCMsgPtr = ^MailEPPCMsg;
	MailEPPCMsg = RECORD
		version:				INTEGER;
		CASE INTEGER OF
		0: (
			theSMCA:			SMCAPtr;								{  for 'crsl', 'mdsl', 'dlsl', 'sndi', 'msgo', 'admn'  }
			);
		1: (
			sequenceNumber:		LONGINT;								{  for 'inqu', 'dlom'  }
			);
		2: (
			locationInfo:		MailLocationInfo;						{  for 'locc'  }
			);
	END;

{ Values of OCE defined High Level Event message classes }

CONST
	kMailEPPCCreateSlot			= 'crsl';
	kMailEPPCModifySlot			= 'mdsl';
	kMailEPPCDeleteSlot			= 'dlsl';
	kMailEPPCShutDown			= 'quit';
	kMailEPPCMailboxOpened		= 'mbop';
	kMailEPPCMailboxClosed		= 'mbcl';
	kMailEPPCMsgPending			= 'msgp';
	kMailEPPCSendImmediate		= 'sndi';
	kMailEPPCContinue			= 'cont';
	kMailEPPCSchedule			= 'sked';
	kMailEPPCAdmin				= 'admn';
	kMailEPPCInQUpdate			= 'inqu';
	kMailEPPCMsgOpened			= 'msgo';
	kMailEPPCDeleteOutQMsg		= 'dlom';
	kMailEPPCWakeup				= 'wkup';
	kMailEPPCLocationChanged	= 'locc';


TYPE
	MailTimerPtr = ^MailTimer;
	MailTimer = RECORD
		CASE INTEGER OF
		0: (
			frequency:			LONGINT;								{  how often to connect  }
			);
		1: (
			connectTime:		LONGINT;								{  time since midnight  }
			);
	END;


CONST
	kMailTimerOff				= 0;							{  control is off  }
	kMailTimerTime				= 1;							{  specifies connect time (relative to midnight)  }
	kMailTimerFrequency			= 2;							{  specifies connect frequency  }


TYPE
	MailTimerKind						= Byte;
	MailTimersPtr = ^MailTimers;
	MailTimers = RECORD
		sendTimeKind:			SInt8;									{  either kMailTimerTime or kMailTimerFrequency  }
		receiveTimeKind:		SInt8;									{  either kMailTimerTime or kMailTimerFrequency  }
		send:					MailTimer;
		receive:				MailTimer;
	END;


	MailStandardSlotInfoAttributePtr = ^MailStandardSlotInfoAttribute;
	MailStandardSlotInfoAttribute = RECORD
		version:				INTEGER;
		active:					SInt8;									{  active if MailLocationMask(i) is set  }
		padByte:				SInt8;
		sendReceiveTimer:		MailTimers;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	MSAMIOCompletionProcPtr = PROCEDURE(VAR paramBlock: TempMSAMParam);
{$ELSEC}
	MSAMIOCompletionProcPtr = Register68kProcPtr;
{$ENDC}

	MSAMIOCompletionUPP = UniversalProcPtr;
	PMSAMGetMSAMRecordPBPtr = ^PMSAMGetMSAMRecordPB;
	PMSAMGetMSAMRecordPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msamCID:				CreationID;
	END;

	PMSAMOpenQueuesPBPtr = ^PMSAMOpenQueuesPB;
	PMSAMOpenQueuesPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		inQueueRef:				MSAMQueueRef;
		outQueueRef:			MSAMQueueRef;
		msamSlotID:				MSAMSlotID;
		filler:					ARRAY [0..1] OF LONGINT;
	END;

	PMSAMStatus							= UInt16;
{ Values of PMSAMStatus }

CONST
	kPMSAMStatusPending			= 1;							{  for inQueue and outQueue  }
	kPMSAMStatusError			= 2;							{  for inQueue and outQueue  }
	kPMSAMStatusSending			= 3;							{  for outQueue only  }
	kPMSAMStatusCaching			= 4;							{  for inQueue only  }
	kPMSAMStatusSent			= 5;							{  for outQueue only  }


TYPE
	PMSAMSetStatusPBPtr = ^PMSAMSetStatusPB;
	PMSAMSetStatusPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;
		seqNum:					LONGINT;
		msgHint:				LONGINT;								{  for posting cache error,set this to 0 when report outq status  }
		status:					PMSAMStatus;
	END;

	PMSAMLogErrorPBPtr = ^PMSAMLogErrorPB;
	PMSAMLogErrorPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msamSlotID:				MSAMSlotID;								{  0 for PMSAM errors  }
		logEntry:				MailErrorLogEntryInfoPtr;
		filler:					ARRAY [0..1] OF LONGINT;
	END;

{**************************************************************************************}

CONST
	kMailMsgSummaryVersion		= 1;


TYPE
	MailMasterDataPtr = ^MailMasterData;
	MailMasterData = RECORD
		attrMask:				MailAttributeBitmap;					{  indicates attributes present in MsgSummary  }
		messageID:				MailLetterID;
		replyID:				MailLetterID;
		conversationID:			MailLetterID;
	END;

{ Values for addressedToMe in struct MailCoreData }

CONST
	kAddressedAs_TO				= $01;
	kAddressedAs_CC				= $02;
	kAddressedAs_BCC			= $04;


TYPE
	MailCoreDataPtr = ^MailCoreData;
	MailCoreData = RECORD
		letterFlags:			MailLetterFlags;
		messageSize:			UInt32;
		letterIndications:		MailIndications;
		messageType:			OCECreatorType;
		sendTime:				MailTime;
		messageFamily:			OSType;
		reserved:				SInt8;
		addressedToMe:			SInt8;
		agentInfo:				PACKED ARRAY [0..5] OF CHAR;			{  6 bytes of special info [set to zero]  }
																		{  these are variable length and even padded  }
		sender:					RString32;								{  recipient's entityName (trunc) }
		subject:				RString32;								{  subject maybe truncated  }
	END;

	MSAMMsgSummaryPtr = ^MSAMMsgSummary;
	MSAMMsgSummary = RECORD
		version:				INTEGER;								{  following flags are defaulted by Toolbox  }
		msgDeleted:				BOOLEAN;								{  true if msg is to be deleted by PMSAM  }
		msgUpdated:				BOOLEAN;								{  true if msgSummary was updated by MailManager  }
		msgCached:				BOOLEAN;								{  true if msg is in the slot's InQueue  }
		padByte:				SInt8;
		masterData:				MailMasterData;
		coreData:				MailCoreData;
	END;

{ PMSAM can put up to 128 bytes of private msg summary data }

CONST
	kMailMaxPMSAMMsgSummaryData	= 128;


TYPE
	PMSAMCreateMsgSummaryPBPtr = ^PMSAMCreateMsgSummaryPB;
	PMSAMCreateMsgSummaryPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		inQueueRef:				MSAMQueueRef;
		seqNum:					LONGINT;								{  <- seq of the new message  }
		msgSummary:				MSAMMsgSummaryPtr;						{  attributes and mask filled in  }
		buffer:					MailBufferPtr;							{  PMSAM specific data to be appended  }
	END;


	PMSAMPutMsgSummaryPBPtr = ^PMSAMPutMsgSummaryPB;
	PMSAMPutMsgSummaryPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		inQueueRef:				MSAMQueueRef;
		seqNum:					LONGINT;
		letterFlags:			MailMaskedLetterFlagsPtr;				{  if not nil, then set msgStoreFlags  }
		buffer:					MailBufferPtr;							{  PMSAM specific data to be overwritten  }
	END;

	PMSAMGetMsgSummaryPBPtr = ^PMSAMGetMsgSummaryPB;
	PMSAMGetMsgSummaryPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		inQueueRef:				MSAMQueueRef;
		seqNum:					LONGINT;
		msgSummary:				MSAMMsgSummaryPtr;						{  if not nil, then read in the msgSummary  }
		buffer:					MailBufferPtr;							{  PMSAM specific data to be read  }
		msgSummaryOffset:		UInt16;									{  offset of PMSAM specific data from start of MsgSummary  }
	END;

{**************************************************************************************}
{ Definitions for Server MSAMs }
{************************************************************************************}
	SMSAMAdminCode						= UInt16;
{ Values of SMSAMAdminCode }

CONST
	kSMSAMNotifyFwdrSetupChange	= 1;
	kSMSAMNotifyFwdrNameChange	= 2;
	kSMSAMNotifyFwdrPwdChange	= 3;
	kSMSAMGetDynamicFwdrParams	= 4;


TYPE
	SMSAMSlotChanges					= UInt32;

CONST
	kSMSAMFwdrHomeInternetChangedBit = 0;
	kSMSAMFwdrConnectedToChangedBit = 1;
	kSMSAMFwdrForeignRLIsChangedBit = 2;
	kSMSAMFwdrMnMServerChangedBit = 3;

{ Values of SMSAMSlotChanges }
	kSMSAMFwdrEverythingChangedMask = -1;
	kSMSAMFwdrHomeInternetChangedMask = $00000001;
	kSMSAMFwdrConnectedToChangedMask = $00000002;
	kSMSAMFwdrForeignRLIsChangedMask = $00000004;
	kSMSAMFwdrMnMServerChangedMask = $00000008;

{ kSMSAMNotifyFwdrSetupChange }

TYPE
	SMSAMSetupChangePtr = ^SMSAMSetupChange;
	SMSAMSetupChange = RECORD
		whatChanged:			SMSAMSlotChanges;						{   --> bitmap of what parameters changed  }
		serverHint:				AddrBlock;								{   --> try this ADAP server first  }
	END;

{ kSMSAMNotifyFwdrNameChange }
	SMSAMNameChangePtr = ^SMSAMNameChange;
	SMSAMNameChange = RECORD
		newName:				RString;								{   --> msams new name  }
		serverHint:				AddrBlock;								{   --> try this ADAP server first  }
	END;

{ kSMSAMNotifyFwdrPasswordChange }
	SMSAMPasswordChangePtr = ^SMSAMPasswordChange;
	SMSAMPasswordChange = RECORD
		newPassword:			RString;								{   --> msams new password  }
		serverHint:				AddrBlock;								{   --> try this ADAP server first  }
	END;

{ kSMSAMGetDynamicFwdrParams }
	SMSAMDynamicParamsPtr = ^SMSAMDynamicParams;
	SMSAMDynamicParams = RECORD
		curDiskUsed:			UInt32;									{  <--  amount of disk space used by msam  }
		curMemoryUsed:			UInt32;									{  <--  amount of memory used by msam  }
	END;

	SMSAMAdminEPPCRequestPtr = ^SMSAMAdminEPPCRequest;
	SMSAMAdminEPPCRequest = RECORD
		adminCode:				SMSAMAdminCode;
		CASE INTEGER OF
		0: (
			setupChange:		SMSAMSetupChange;
			);
		1: (
			nameChange:			SMSAMNameChange;
			);
		2: (
			passwordChange:		SMSAMPasswordChange;
			);
		3: (
			dynamicParams:		SMSAMDynamicParams;
			);
	END;

	SMSAMSetupPBPtr = ^SMSAMSetupPB;
	SMSAMSetupPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		serverMSAM:				RecordIDPtr;
		password:				RStringPtr;
		gatewayType:			OSType;
		gatewayTypeDescription:	RStringPtr;
		catalogServerHint:		AddrBlock;
	END;

	SMSAMStartupPBPtr = ^SMSAMStartupPB;
	SMSAMStartupPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msamIdentity:			AuthIdentity;
		queueRef:				MSAMQueueRef;
	END;

	SMSAMShutdownPBPtr = ^SMSAMShutdownPB;
	SMSAMShutdownPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;
	END;

{**************************************************************************************}
{ Definitions for reading and writing MSAM Letters }
{**************************************************************************************}
	MSAMEnumeratePBPtr = ^MSAMEnumeratePB;
	MSAMEnumeratePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;
		startSeqNum:			LONGINT;
		nextSeqNum:				LONGINT;
																		{  buffer contains a Mail Reply. Each tuple is a MSAMEnumerateInQReply when enumerating the inQueue MSAMEnumerateOutQReply when enumerating the outQueue  }
		buffer:					MailBuffer;
	END;

	MSAMEnumerateInQReplyPtr = ^MSAMEnumerateInQReply;
	MSAMEnumerateInQReply = RECORD
		seqNum:					LONGINT;
		msgDeleted:				BOOLEAN;								{  true if msg is to be deleted by PMSAM  }
		msgUpdated:				BOOLEAN;								{  true if MsgSummary has been updated by TB  }
		msgCached:				BOOLEAN;								{  true if msg is in the incoming queue  }
		padByte:				SInt8;
	END;

	MSAMEnumerateOutQReplyPtr = ^MSAMEnumerateOutQReply;
	MSAMEnumerateOutQReply = RECORD
		seqNum:					LONGINT;
		done:					BOOLEAN;								{  true if all responsible recipients have been processed  }
		priority:				SInt8;
		msgFamily:				OSType;
		approxSize:				LONGINT;
		tunnelForm:				BOOLEAN;								{  true if this letter has to be tunnelled  }
		padByte:				SInt8;
		nextHop:				NetworkSpec;							{  valid if tunnelForm is true  }
		msgType:				OCECreatorType;
	END;

	MSAMDeletePBPtr = ^MSAMDeletePB;
	MSAMDeletePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;
		seqNum:					LONGINT;
		msgOnly:				BOOLEAN;								{  only valid for PMSAM & inQueue  }
																		{  set true to delete message but not msgSummary  }
		padByte:				SInt8;
																		{  only valid for SMSAM & tunnelled messages  }
		result:					OSErr;
	END;

	MSAMOpenPBPtr = ^MSAMOpenPB;
	MSAMOpenPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;
		seqNum:					LONGINT;
		mailMsgRef:				MailMsgRef;
	END;

	MSAMOpenNestedPBPtr = ^MSAMOpenNestedPB;
	MSAMOpenNestedPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		nestedRef:				MailMsgRef;
	END;

	MSAMClosePBPtr = ^MSAMClosePB;
	MSAMClosePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
	END;

	MSAMGetMsgHeaderPBPtr = ^MSAMGetMsgHeaderPB;
	MSAMGetMsgHeaderPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		selector:				SInt8;
		filler1:				BOOLEAN;
		offset:					UInt32;
		buffer:					MailBuffer;
		remaining:				UInt32;
	END;

{    MSAMGetAttributesPB.buffer returned will contain the attribute values of 
    the attributes indicated in responseMask, 
    from the attribute indicated by the least significant bit set
    to the attribute indicated by the most significant bit set.
    Note that recipients - from, to, cc, bcc cannot be read using
    this call. Use GetRecipients to read these. 
}
	MSAMGetAttributesPBPtr = ^MSAMGetAttributesPB;
	MSAMGetAttributesPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		requestMask:			MailAttributeBitmap;					{  kMailIndicationsBit thru kMailSubjectBit  }
		buffer:					MailBuffer;
		responseMask:			MailAttributeBitmap;
		more:					BOOLEAN;
		filler1:				BOOLEAN;
	END;

{ attrID value to get resolved recipient list }

CONST
	kMailResolvedList			= 0;


TYPE
	MailOriginalRecipientPtr = ^MailOriginalRecipient;
	MailOriginalRecipient = RECORD
		index:					INTEGER;
	END;

{ Followed by OCEPackedRecipient }


	MailResolvedRecipientPtr = ^MailResolvedRecipient;
	MailResolvedRecipient = RECORD
		index:					INTEGER;
		recipientFlags:			INTEGER;
		responsible:			BOOLEAN;
		padByte:				SInt8;
	END;

{ Followed by OCEPackedRecipient }


{    MSAMGetRecipientsPB.buffer contains a Mail Reply. Each tuple is a
    MailOriginalRecipient if getting original recipients 
                            ie the attrID is kMail[From, To, Cc, Bcc]Bit
    MailResolvedRecipient if getting resolved reicpients
                            ie the attrID is kMailResolvedList
    Both tuples are word alligned.  
}
	MSAMGetRecipientsPBPtr = ^MSAMGetRecipientsPB;
	MSAMGetRecipientsPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		attrID:					MailAttributeID;						{  kMailFromBit thru kMailBccBit  }
		startIndex:				UInt16;									{  starts at 1  }
		buffer:					MailBuffer;
		nextIndex:				UInt16;
		more:					BOOLEAN;
		filler1:				BOOLEAN;
	END;

	MSAMGetContentPBPtr = ^MSAMGetContentPB;
	MSAMGetContentPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		segmentMask:			MailSegmentMask;
		buffer:					MailBuffer;
		textScrap:				StScrpRecPtr;
		script:					ScriptCode;
		segmentType:			MailSegmentType;
		endOfScript:			BOOLEAN;
		endOfSegment:			BOOLEAN;
		endOfContent:			BOOLEAN;
		filler1:				BOOLEAN;
		segmentLength:			LONGINT;								{  NEW: <-  valid first call in a segment  }
		segmentID:				LONGINT;								{  NEW: <-> identifier for this segment  }
	END;

	MSAMGetEnclosurePBPtr = ^MSAMGetEnclosurePB;
	MSAMGetEnclosurePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		contentEnclosure:		BOOLEAN;
		padByte:				SInt8;
		buffer:					MailBuffer;
		endOfFile:				BOOLEAN;
		endOfEnclosures:		BOOLEAN;
	END;

	MailBlockInfoPtr = ^MailBlockInfo;
	MailBlockInfo = RECORD
		blockType:				OCECreatorType;
		offset:					UInt32;
		blockLength:			UInt32;
	END;

	MSAMEnumerateBlocksPBPtr = ^MSAMEnumerateBlocksPB;
	MSAMEnumerateBlocksPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		startIndex:				UInt16;									{  starts at 1  }
		buffer:					MailBuffer;
																		{     buffer contains a Mail Reply. Each tuple is a MailBlockInfo  }
		nextIndex:				UInt16;
		more:					BOOLEAN;
		filler1:				BOOLEAN;
	END;

	MSAMGetBlockPBPtr = ^MSAMGetBlockPB;
	MSAMGetBlockPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		blockType:				OCECreatorType;
		blockIndex:				UInt16;
		buffer:					MailBuffer;
		dataOffset:				UInt32;
		endOfBlock:				BOOLEAN;
		padByte:				SInt8;
		remaining:				UInt32;
	END;

{ YOU SHOULD BE USING THE NEW FORM OF MARK RECIPIENTS
 * THIS VERSION IS MUCH SLOWER AND KEPT FOR COMPATIBILITY
 * REASONS.
}
{ not valid for tunnel form letters }
	MSAMMarkRecipientsPBPtr = ^MSAMMarkRecipientsPB;
	MSAMMarkRecipientsPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;
		seqNum:					LONGINT;
		buffer:					MailBuffer;								{     buffer contains a Mail Reply. Each tuple is an unsigned short, the index of a recipient to be marked.  }
	END;

{ 
 * same as MSAMMarkRecipients except it takes a mailMsgRef instead of 
 * queueRef, seqNum 
}
{ not valid for tunnel form letters }
	MSAMnMarkRecipientsPBPtr = ^MSAMnMarkRecipientsPB;
	MSAMnMarkRecipientsPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		buffer:					MailBuffer;								{     buffer contains a Mail Reply. Each tuple is an unsigned short, the index of a recipient to be marked.  }
	END;

{**************************************************************************************}
	MSAMCreatePBPtr = ^MSAMCreatePB;
	MSAMCreatePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;
		asLetter:				BOOLEAN;								{  indicate if we should create as letter or msg  }
		filler1:				BOOLEAN;
		msgType:				IPMMsgType;								{  up to application discretion: must be of IPMSenderTag  kIPMOSFormatType for asLetter=true  }
		refCon:					LONGINT;								{  for messages only  }
		seqNum:					LONGINT;								{  set if creating message in the inQueue  }
		tunnelForm:				BOOLEAN;								{  if true tunnelForm else newForm  }
		bccRecipients:			BOOLEAN;								{  true if creating letter with bcc recipients  }
		newRef:					MailMsgRef;
	END;

	MSAMBeginNestedPBPtr = ^MSAMBeginNestedPB;
	MSAMBeginNestedPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		refCon:					LONGINT;								{  for messages only  }
		msgType:				IPMMsgType;
	END;

	MSAMEndNestedPBPtr = ^MSAMEndNestedPB;
	MSAMEndNestedPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
	END;

	MSAMSubmitPBPtr = ^MSAMSubmitPB;
	MSAMSubmitPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		submitFlag:				BOOLEAN;
		padByte:				SInt8;
		msgID:					MailLetterID;
	END;

	MSAMPutMsgHeaderPBPtr = ^MSAMPutMsgHeaderPB;
	MSAMPutMsgHeaderPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		replyQueue:				OCERecipientPtr;
		sender:					IPMSenderPtr;
		deliveryNotification:	SInt8;
		priority:				SInt8;
	END;

	MSAMPutAttributePBPtr = ^MSAMPutAttributePB;
	MSAMPutAttributePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		attrID:					MailAttributeID;						{  kMailIndicationsBit thru kMailSubjectBit  }
		buffer:					MailBuffer;
	END;

	MSAMPutRecipientPBPtr = ^MSAMPutRecipientPB;
	MSAMPutRecipientPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		attrID:					MailAttributeID;						{  kMailFromBit thru kMailBccBit  }
		recipient:				MailRecipientPtr;
		responsible:			BOOLEAN;								{  valid for server and message msams only  }
		filler1:				BOOLEAN;
	END;

	MSAMPutContentPBPtr = ^MSAMPutContentPB;
	MSAMPutContentPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		segmentType:			MailSegmentType;
		append:					BOOLEAN;
		padByte:				SInt8;
		buffer:					MailBuffer;
		textScrap:				StScrpRecPtr;
		startNewScript:			BOOLEAN;
		filler1:				BOOLEAN;
		script:					ScriptCode;								{  valid only if startNewScript is true  }
	END;

	MSAMPutEnclosurePBPtr = ^MSAMPutEnclosurePB;
	MSAMPutEnclosurePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		contentEnclosure:		BOOLEAN;
		padByte:				SInt8;
		hfs:					BOOLEAN;								{  true => in file system, false => in memory  }
		append:					BOOLEAN;
		buffer:					MailBuffer;								{  Unused if hfs == true  }
		enclosure:				FSSpec;
		addlInfo:				MailEnclosureInfo;
	END;

	MSAMPutBlockPBPtr = ^MSAMPutBlockPB;
	MSAMPutBlockPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		refCon:					LONGINT;								{  for messages only  }
		blockType:				OCECreatorType;
		append:					BOOLEAN;
		filler1:				BOOLEAN;
		buffer:					MailBuffer;
		mode:					MailBlockMode;							{  if blockType is kMailTunnelLtrType or kMailHopInfoType  mode is assumed to be kMailFromMark  }
		offset:					UInt32;
	END;

{**************************************************************************************}
	MSAMCreateReportPBPtr = ^MSAMCreateReportPB;
	MSAMCreateReportPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;							{  to distinguish personal and server MSAMs  }
		mailMsgRef:				MailMsgRef;
		msgID:					MailLetterID;							{  kMailLetterIDBit of letter being reported upon  }
		sender:					MailRecipientPtr;						{  sender of the letter you are creating report on  }
	END;

	MSAMPutRecipientReportPBPtr = ^MSAMPutRecipientReportPB;
	MSAMPutRecipientReportPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		recipientIndex:			INTEGER;								{  recipient index in the original letter  }
		result:					OSErr;									{  result of sending the recipient  }
	END;

{**************************************************************************************}
	MailWakeupPMSAMPBPtr = ^MailWakeupPMSAMPB;
	MailWakeupPMSAMPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		pmsamCID:				CreationID;
		mailSlotID:				MailSlotID;
	END;

	MailCreateMailSlotPBPtr = ^MailCreateMailSlotPB;
	MailCreateMailSlotPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailboxRef:				MailboxRef;
		timeout:				LONGINT;
		pmsamCID:				CreationID;
		smca:					SMCA;
	END;

	MailModifyMailSlotPBPtr = ^MailModifyMailSlotPB;
	MailModifyMailSlotPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailboxRef:				MailboxRef;
		timeout:				LONGINT;
		pmsamCID:				CreationID;
		smca:					SMCA;
	END;

	MSAMParamPtr = ^MSAMParam;
	MSAMParam = RECORD
		CASE INTEGER OF
		0: (
			qLink:				Ptr;
			reservedH1:			LONGINT;
			reservedH2:			LONGINT;
			ioCompletion:		MSAMIOCompletionUPP;
			ioResult:			OSErr;
			saveA5:				LONGINT;
			reqCode:			INTEGER;
		   );
		1: (
			pmsamGetMSAMRecord:	PMSAMGetMSAMRecordPB;
			);
		2: (
			pmsamOpenQueues:	PMSAMOpenQueuesPB;
			);
		3: (
			pmsamSetStatus:		PMSAMSetStatusPB;
			);
		4: (
			pmsamLogError:		PMSAMLogErrorPB;
			);
		5: (
			smsamSetup:			SMSAMSetupPB;
			);
		6: (
			smsamStartup:		SMSAMStartupPB;
			);
		7: (
			smsamShutdown:		SMSAMShutdownPB;
			);
		8: (
			msamEnumerate:		MSAMEnumeratePB;
			);
		9: (
			msamDelete:			MSAMDeletePB;
			);
		10: (
			msamOpen:			MSAMOpenPB;
			);
		11: (
			msamOpenNested:		MSAMOpenNestedPB;
			);
		12: (
			msamClose:			MSAMClosePB;
			);
		13: (
			msamGetMsgHeader:	MSAMGetMsgHeaderPB;
			);
		14: (
			msamGetAttributes:	MSAMGetAttributesPB;
			);
		15: (
			msamGetRecipients:	MSAMGetRecipientsPB;
			);
		16: (
			msamGetContent:		MSAMGetContentPB;
			);
		17: (
			msamGetEnclosure:	MSAMGetEnclosurePB;
			);
		18: (
			msamEnumerateBlocks: MSAMEnumerateBlocksPB;
			);
		19: (
			msamGetBlock:		MSAMGetBlockPB;
			);
		20: (
			msamMarkRecipients:	MSAMMarkRecipientsPB;
			);
		21: (
			msamnMarkRecipients: MSAMnMarkRecipientsPB;
			);
		22: (
			msamCreate:			MSAMCreatePB;
			);
		23: (
			msamBeginNested:	MSAMBeginNestedPB;
			);
		24: (
			msamEndNested:		MSAMEndNestedPB;
			);
		25: (
			msamSubmit:			MSAMSubmitPB;
			);
		26: (
			msamPutMsgHeader:	MSAMPutMsgHeaderPB;
			);
		27: (
			msamPutAttribute:	MSAMPutAttributePB;
			);
		28: (
			msamPutRecipient:	MSAMPutRecipientPB;
			);
		29: (
			msamPutContent:		MSAMPutContentPB;
			);
		30: (
			msamPutEnclosure:	MSAMPutEnclosurePB;						{  this field is SYSTEM8_DEPRECATED }
			);
		31: (
			msamPutBlock:		MSAMPutBlockPB;
			);
		32: (
			msamCreateReport:	MSAMCreateReportPB;						{  Reports and Error Handling Calls  }
			);
		33: (
			msamPutRecipientReport: MSAMPutRecipientReportPB;
			);
		34: (
			pmsamCreateMsgSummary: PMSAMCreateMsgSummaryPB;
			);
		35: (
			pmsamPutMsgSummary:	PMSAMPutMsgSummaryPB;
			);
		36: (
			pmsamGetMsgSummary:	PMSAMGetMsgSummaryPB;
			);
		37: (
			wakeupPMSAM:		MailWakeupPMSAMPB;
			);
		38: (
			createMailSlot:		MailCreateMailSlotPB;
			);
		39: (
			modifyMailSlot:		MailModifyMailSlotPB;
			);
	END;

TempMSAMParam   =   MSAMParam;

CONST
	uppMSAMIOCompletionProcInfo = $00009802;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewMSAMIOCompletionUPP(userRoutine: MSAMIOCompletionProcPtr): MSAMIOCompletionUPP; { old name was NewMSAMIOCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeMSAMIOCompletionUPP(userUPP: MSAMIOCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeMSAMIOCompletionUPP(VAR paramBlock: TempMSAMParam; userRoutine: MSAMIOCompletionUPP); { old name was CallMSAMIOCompletionProc }
{$ENDC}  {CALL_NOT_IN_CARBON}

{ ASYNCHRONOUS ONLY, client must call WaitNextEvent }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION MailCreateMailSlot(VAR paramBlock: MSAMParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $1F00, $3F3C, $052B, $AA5E;
	{$ENDC}
{ ASYNCHRONOUS ONLY, client must call WaitNextEvent }
FUNCTION MailModifyMailSlot(VAR paramBlock: MSAMParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $1F00, $3F3C, $052C, $AA5E;
	{$ENDC}
{ ASYNCHRONOUS ONLY, client must call WaitNextEvent }
FUNCTION MailWakeupPMSAM(VAR paramBlock: MSAMParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $1F00, $3F3C, $0507, $AA5E;
	{$ENDC}
{ Personal MSAM Glue Routines }
FUNCTION PMSAMOpenQueues(VAR paramBlock: MSAMParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $0500, $AA5E;
	{$ENDC}
FUNCTION PMSAMSetStatus(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0527, $AA5E;
	{$ENDC}
{ SYNC ONLY }
FUNCTION PMSAMGetMSAMRecord(VAR paramBlock: MSAMParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $0506, $AA5E;
	{$ENDC}
{ Server MSAM Glue Routines }
{ SYNC ONLY }
FUNCTION SMSAMSetup(VAR paramBlock: MSAMParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $0523, $AA5E;
	{$ENDC}
{ SYNC ONLY }
FUNCTION SMSAMStartup(VAR paramBlock: MSAMParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $0501, $AA5E;
	{$ENDC}
FUNCTION SMSAMShutdown(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0502, $AA5E;
	{$ENDC}
{ Get Interface Glue Routines }
FUNCTION MSAMEnumerate(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0503, $AA5E;
	{$ENDC}
FUNCTION MSAMDelete(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0504, $AA5E;
	{$ENDC}
FUNCTION MSAMMarkRecipients(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0505, $AA5E;
	{$ENDC}
FUNCTION MSAMnMarkRecipients(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0512, $AA5E;
	{$ENDC}
FUNCTION MSAMOpen(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0508, $AA5E;
	{$ENDC}
FUNCTION MSAMOpenNested(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0509, $AA5E;
	{$ENDC}
FUNCTION MSAMClose(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $050A, $AA5E;
	{$ENDC}
FUNCTION MSAMGetRecipients(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $050C, $AA5E;
	{$ENDC}
FUNCTION MSAMGetAttributes(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $050B, $AA5E;
	{$ENDC}
FUNCTION MSAMGetContent(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $050D, $AA5E;
	{$ENDC}
FUNCTION MSAMGetEnclosure(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $050E, $AA5E;
	{$ENDC}
FUNCTION MSAMEnumerateBlocks(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $050F, $AA5E;
	{$ENDC}
FUNCTION MSAMGetBlock(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0510, $AA5E;
	{$ENDC}
FUNCTION MSAMGetMsgHeader(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0511, $AA5E;
	{$ENDC}
{ Put Interface Glue Routines }
FUNCTION MSAMCreate(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0514, $AA5E;
	{$ENDC}
FUNCTION MSAMBeginNested(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0515, $AA5E;
	{$ENDC}
FUNCTION MSAMEndNested(VAR paramBlock: MSAMParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $0516, $AA5E;
	{$ENDC}
{  SYNCHRONOUS ONLY }
FUNCTION MSAMSubmit(VAR paramBlock: MSAMParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $0517, $AA5E;
	{$ENDC}
FUNCTION MSAMPutAttribute(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0518, $AA5E;
	{$ENDC}
FUNCTION MSAMPutRecipient(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0519, $AA5E;
	{$ENDC}
FUNCTION MSAMPutContent(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $051A, $AA5E;
	{$ENDC}
{  SYNCHRONOUS ONLY }
FUNCTION MSAMPutEnclosure(VAR paramBlock: MSAMParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $051B, $AA5E;
	{$ENDC}
FUNCTION MSAMPutBlock(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $051C, $AA5E;
	{$ENDC}
FUNCTION MSAMPutMsgHeader(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $051D, $AA5E;
	{$ENDC}
{ Reports and Error Handling Glue Routines }
FUNCTION MSAMCreateReport(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $051F, $AA5E;
	{$ENDC}
FUNCTION MSAMPutRecipientReport(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0520, $AA5E;
	{$ENDC}
FUNCTION PMSAMLogError(VAR paramBlock: MSAMParam): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $0521, $AA5E;
	{$ENDC}
{ MsgSummary Glue Routines }
FUNCTION PMSAMCreateMsgSummary(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0522, $AA5E;
	{$ENDC}
FUNCTION PMSAMPutMsgSummary(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0525, $AA5E;
	{$ENDC}
FUNCTION PMSAMGetMsgSummary(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0526, $AA5E;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OCEMailIncludes}

{$ENDC} {__OCEMAIL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
