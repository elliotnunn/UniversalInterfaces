{
 	File:		OCEStandardMail.p
 
 	Contains:	Apple Open Collaboration Environment Standard Mail Interfaces.
 
 	Version:	Technology:	AOCE Toolbox 1.02
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1994-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OCEStandardMail;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OCESTANDARDMAIL__}
{$SETC __OCESTANDARDMAIL__ := 1}

{$I+}
{$SETC OCEStandardMailIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}

{$IFC UNDEFINED __OCEAUTHDIR__}
{$I OCEAuthDir.p}
{$ENDC}
{$IFC UNDEFINED __OCEMAIL__}
{$I OCEMail.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kSMPVersion					= 1;

	kSMPNativeFormatName		= 'natv';


TYPE
	LetterSpecPtr = ^LetterSpec;
	LetterSpec = RECORD
		spec:					ARRAY [0..2] OF UInt32;
	END;


CONST
	typeLetterSpec				= 'lttr';

{	Wildcard used for filtering letter types. }
	FilterAnyLetter				= 'ltr*';
	FilterAppleLetterContent	= 'ltc*';
	FilterImageContent			= 'lti*';



TYPE
	LetterDescriptorPtr = ^LetterDescriptor;
	LetterDescriptor = RECORD
		onDisk:					BOOLEAN;
		filler1:				BOOLEAN;
		CASE INTEGER OF
		0: (
			fileSpec:			FSSpec;
			);
		1: (
			mailboxSpec:		LetterSpec;
			);
	END;

{
SMPPSendAs values.  You may add the following values together to determine how the
file is sent, but you may not set both kSMPSendAsEnclosureMask and kSMPSendFileOnlyMask.  This
will allow you to send the letter as an image so that it will work with fax gateways
and send as an enclosure as well.
}

CONST
	kSMPSendAsEnclosureBit		= 0;							{  Appears as letter with enclosures  }
	kSMPSendFileOnlyBit			= 1;							{  Appears as a file in mailbox.  }
	kSMPSendAsImageBit			= 2;							{  Content imaged in letter  }

{ Values of SMPPSendAs }
	kSMPSendAsEnclosureMask		= $01;
	kSMPSendFileOnlyMask		= $02;
	kSMPSendAsImageMask			= $04;


TYPE
	SMPPSendAs							= Byte;
{ Send Package Structures }
{$IFC TYPED_FUNCTION_POINTERS}
	SMPDrawImageProcPtr = PROCEDURE(refcon: LONGINT; inColor: BOOLEAN);
{$ELSEC}
	SMPDrawImageProcPtr = ProcPtr;
{$ENDC}

	SMPDrawImageUPP = UniversalProcPtr;

CONST
	uppSMPDrawImageProcInfo = $000001C0;

FUNCTION NewSMPDrawImageProc(userRoutine: SMPDrawImageProcPtr): SMPDrawImageUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallSMPDrawImageProc(refcon: LONGINT; inColor: BOOLEAN; userRoutine: SMPDrawImageUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	SMPRecipientDescriptorPtr = ^SMPRecipientDescriptor;
	SMPRecipientDescriptor = RECORD
		next:					SMPRecipientDescriptorPtr;				{   Q-Link.  }
		result:					OSErr;									{   result code when using the object.  }
		recipient:				OCEPackedRecipientPtr;					{   Pointer to a Packed Address.  }
		size:					UInt32;									{   length of recipient in bytes.  }
		theAddress:				MailRecipient;							{   structure points into recipient and theRID.  }
		theRID:					RecordID;								{   structure points into recipient.  }
	END;

	SMPEnclosureDescriptorPtr = ^SMPEnclosureDescriptor;
	SMPEnclosureDescriptor = RECORD
		next:					SMPEnclosureDescriptorPtr;
		result:					OSErr;
		fileSpec:				FSSpec;
		fileCreator:			OSType;									{   Creator of this enclosure.  }
		fileType:				OSType;									{   File Type of this enclosure.  }
	END;

	SMPLetterPBPtr = ^SMPLetterPB;
	SMPLetterPB = RECORD
		result:					OSErr;									{  result of operation  }
		subject:				RStringPtr;								{  RString  }
		senderIdentity:			AuthIdentity;							{  Letter is sent from this Identity  }
		toList:					SMPRecipientDescriptorPtr;				{  Pointer to linked list  }
		ccList:					SMPRecipientDescriptorPtr;				{  Pointer to linked list  }
		bccList:				SMPRecipientDescriptorPtr;				{  Pointer to linked list  }
		script:					ScriptCode;								{  Identifier for language  }
		textSize:				Size;									{  length of body data  }
		textBuffer:				Ptr;									{  body of the letter  }
		sendAs:					SInt8;									{  Send as Letter,Enclosure,Image  }
		padByte:				SInt8;
		enclosures:				SMPEnclosureDescriptorPtr;				{  files to be enclosed  }
		drawImageProc:			SMPDrawImageUPP;						{  For imaging  }
		imageRefCon:			LONGINT;								{  For imaging  }
		supportsColor:			BOOLEAN;								{  For imaging - set to true if you application supports color imaging  }
		filler1:				BOOLEAN;
	END;


CONST
	kSMPAppMustHandleEventBit	= 0;
	kSMPAppShouldIgnoreEventBit	= 1;
	kSMPContractedBit			= 2;
	kSMPExpandedBit				= 3;
	kSMPMailerBecomesTargetBit	= 4;
	kSMPAppBecomesTargetBit		= 5;
	kSMPCursorOverMailerBit		= 6;
	kSMPCreateCopyWindowBit		= 7;
	kSMPDisposeCopyWindowBit	= 8;

{ Values of SMPMailerResult }
	kSMPAppMustHandleEventMask	= $01;
	kSMPAppShouldIgnoreEventMask = $02;
	kSMPContractedMask			= $04;
	kSMPExpandedMask			= $08;
	kSMPMailerBecomesTargetMask	= $10;
	kSMPAppBecomesTargetMask	= $20;
	kSMPCursorOverMailerMask	= $40;
	kSMPCreateCopyWindowMask	= $80;
	kSMPDisposeCopyWindowMask	= $0100;


TYPE
	SMPMailerResult						= UInt32;
{ Values of SMPMailerComponent}

CONST
	kSMPOther					= -1;
	kSMPFrom					= 32;
	kSMPTo						= 20;
	kSMPRegarding				= 22;
	kSMPSendDateTime			= 29;
	kSMPAttachments				= 26;
	kSMPAddressOMatic			= 16;


TYPE
	SMPMailerComponent					= UInt32;


CONST
	kSMPToAddress				= 13;
	kSMPCCAddress				= 14;
	kSMPBCCAddress				= 15;


TYPE
	SMPAddressType						= MailAttributeID;


CONST
	kSMPUndoCommand				= 0;
	kSMPCutCommand				= 1;
	kSMPCopyCommand				= 2;
	kSMPPasteCommand			= 3;
	kSMPClearCommand			= 4;
	kSMPSelectAllCommand		= 5;


TYPE
	SMPEditCommand						= UInt16;

CONST
	kSMPUndoDisabled			= 0;
	kSMPAppMayUndo				= 1;
	kSMPMailerUndo				= 2;


TYPE
	SMPUndoState						= UInt16;
{
SMPSendFormatMask:

Bitfield indicating which combinations of formats are included in,
should be included or, or can be included in a letter.
}

CONST
	kSMPNativeBit				= 0;
	kSMPImageBit				= 1;
	kSMPStandardInterchangeBit	= 2;

{ Values of SMPSendFormatMask }
	kSMPNativeMask				= $01;
	kSMPImageMask				= $02;
	kSMPStandardInterchangeMask	= $04;


TYPE
	SMPSendFormatMask					= UInt32;

{
	Pseudo-events passed to the clients filter proc for initialization and cleanup.
}

CONST
	kSMPSendOptionsStart		= -1;
	kSMPSendOptionsEnd			= -2;


{
SMPSendFormatMask:

Structure describing the format of a letter.  If kSMPNativeMask bit is set, the whichNativeFormat field indicates which of the client-defined formats to use.
}


TYPE
	SMPSendFormatPtr = ^SMPSendFormat;
	SMPSendFormat = RECORD
		whichFormats:			SMPSendFormatMask;
		whichNativeFormat:		INTEGER;								{  0 based  }
	END;



	SMPLetterInfoPtr = ^SMPLetterInfo;
	SMPLetterInfo = RECORD
		letterCreator:			OSType;
		letterType:				OSType;
		subject:				RString32;
		sender:					RString32;
	END;



CONST
	kSMPSave					= 0;
	kSMPSaveAs					= 1;
	kSMPSaveACopy				= 2;


TYPE
	SMPSaveType							= UInt16;
{$IFC TYPED_FUNCTION_POINTERS}
	FrontWindowProcPtr = FUNCTION(clientData: LONGINT): WindowPtr;
{$ELSEC}
	FrontWindowProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PrepareMailerForDrawingProcPtr = PROCEDURE(window: WindowPtr; clientData: LONGINT);
{$ELSEC}
	PrepareMailerForDrawingProcPtr = ProcPtr;
{$ENDC}

	FrontWindowUPP = UniversalProcPtr;
	PrepareMailerForDrawingUPP = UniversalProcPtr;

CONST
	uppFrontWindowProcInfo = $000000F0;
	uppPrepareMailerForDrawingProcInfo = $000003C0;

FUNCTION NewFrontWindowProc(userRoutine: FrontWindowProcPtr): FrontWindowUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPrepareMailerForDrawingProc(userRoutine: PrepareMailerForDrawingProcPtr): PrepareMailerForDrawingUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallFrontWindowProc(clientData: LONGINT; userRoutine: FrontWindowUPP): WindowPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallPrepareMailerForDrawingProc(window: WindowPtr; clientData: LONGINT; userRoutine: PrepareMailerForDrawingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	SendOptionsFilterProcPtr = FUNCTION(theDialog: DialogPtr; VAR theEvent: EventRecord; itemHit: INTEGER; clientData: LONGINT): BOOLEAN;
{$ELSEC}
	SendOptionsFilterProcPtr = ProcPtr;
{$ENDC}

	SendOptionsFilterUPP = UniversalProcPtr;

CONST
	uppSendOptionsFilterProcInfo = $00003BD0;

FUNCTION NewSendOptionsFilterProc(userRoutine: SendOptionsFilterProcPtr): SendOptionsFilterUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallSendOptionsFilterProc(theDialog: DialogPtr; VAR theEvent: EventRecord; itemHit: INTEGER; clientData: LONGINT; userRoutine: SendOptionsFilterUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	SMPMailerStatePtr = ^SMPMailerState;
	SMPMailerState = RECORD
		mailerCount:			INTEGER;
		currentMailer:			INTEGER;
		upperLeft:				Point;
		hasBeenReceived:		BOOLEAN;
		isTarget:				BOOLEAN;
		isExpanded:				BOOLEAN;
		canMoveToTrash:			BOOLEAN;
		canTag:					BOOLEAN;
		padByte2:				SInt8;
		changeCount:			UInt32;
		targetComponent:		SMPMailerComponent;
		canCut:					BOOLEAN;
		canCopy:				BOOLEAN;
		canPaste:				BOOLEAN;
		canClear:				BOOLEAN;
		canSelectAll:			BOOLEAN;
		padByte3:				SInt8;
		undoState:				SMPUndoState;
		undoWhat:				Str63;
	END;


	SMPSendOptionsPtr = ^SMPSendOptions;
	SMPSendOptions = RECORD
		signWhenSent:			BOOLEAN;
		priority:				SInt8;
	END;

	SMPSendOptionsHandle				= ^SMPSendOptionsPtr;

	SMPCloseOptionsPtr = ^SMPCloseOptions;
	SMPCloseOptions = RECORD
		moveToTrash:			BOOLEAN;
		addTag:					BOOLEAN;
		tag:					RString32;
	END;


{----------------------------------------------------------------------------------------
	Send Package Routines
----------------------------------------------------------------------------------------}
FUNCTION SMPSendLetter(theLetter: SMPLetterPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0002, $01F4, $AA5D;
	{$ENDC}
FUNCTION SMPNewPage(VAR newHeader: OpenCPicParams): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0002, $0834, $AA5D;
	{$ENDC}
FUNCTION SMPImageErr: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0835, $AA5D;
	{$ENDC}
FUNCTION SMPResolveToRecipient(dsSpec: PackedDSSpecPtr; VAR recipientList: SMPRecipientDescriptorPtr; identity: AuthIdentity): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0006, $044C, $AA5D;
	{$ENDC}


FUNCTION SMPInitMailer(mailerVersion: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0002, $1285, $AA5D;
	{$ENDC}
FUNCTION SMPGetDimensions(VAR width: INTEGER; VAR contractedHeight: INTEGER; VAR expandedHeight: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0006, $125C, $AA5D;
	{$ENDC}
FUNCTION SMPGetTabInfo(VAR firstTab: SMPMailerComponent; VAR lastTab: SMPMailerComponent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $1274, $AA5D;
	{$ENDC}
FUNCTION SMPNewMailer(window: WindowPtr; upperLeft: Point; canContract: BOOLEAN; initiallyExpanded: BOOLEAN; identity: AuthIdentity; prepareMailerForDrawingCB: PrepareMailerForDrawingUPP; clientData: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $125D, $AA5D;
	{$ENDC}
FUNCTION SMPPrepareToClose(window: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0002, $1287, $AA5D;
	{$ENDC}
FUNCTION SMPCloseOptionsDialog(window: WindowPtr; closeOptions: SMPCloseOptionsPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $1288, $AA5D;
	{$ENDC}
FUNCTION SMPTagDialog(window: WindowPtr; VAR theTag: RString32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $128B, $AA5D;
	{$ENDC}
FUNCTION SMPDisposeMailer(window: WindowPtr; closeOptions: SMPCloseOptionsPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $125E, $AA5D;
	{$ENDC}
FUNCTION SMPMailerEvent({CONST}VAR event: EventRecord; VAR whatHappened: SMPMailerResult; frontWindowCB: FrontWindowUPP; clientData: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $125F, $AA5D;
	{$ENDC}
FUNCTION SMPClearUndo(window: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0002, $1275, $AA5D;
	{$ENDC}
FUNCTION SMPMailerEditCommand(window: WindowPtr; command: SMPEditCommand; VAR whatHappened: SMPMailerResult): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0005, $1260, $AA5D;
	{$ENDC}
FUNCTION SMPMailerForward(window: WindowPtr; from: AuthIdentity): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $1261, $AA5D;
	{$ENDC}
FUNCTION SMPMailerReply(originalLetter: WindowPtr; newLetter: WindowPtr; replyToAll: BOOLEAN; upperLeft: Point; canContract: BOOLEAN; initiallyExpanded: BOOLEAN; identity: AuthIdentity; prepareMailerForDrawingCB: PrepareMailerForDrawingUPP; clientData: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000F, $1262, $AA5D;
	{$ENDC}
FUNCTION SMPGetMailerState(window: WindowPtr; VAR itsState: SMPMailerState): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $1263, $AA5D;
	{$ENDC}
FUNCTION SMPSendOptionsDialog(window: WindowPtr; VAR documentName: Str255; VAR nativeFormatNames: StringPtr; nameCount: UInt16; canSend: SMPSendFormatMask; VAR currentFormat: SMPSendFormat; filterProc: SendOptionsFilterUPP; clientData: LONGINT; VAR shouldSend: SMPSendFormat; sendOptions: SMPSendOptionsPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0013, $1388, $AA5D;
	{$ENDC}

FUNCTION SMPPrepareCoverPages(window: WindowPtr; VAR pageCount: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $1264, $AA5D;
	{$ENDC}
FUNCTION SMPDrawNthCoverPage(window: WindowPtr; pageNumber: INTEGER; doneDrawingCoverPages: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $1265, $AA5D;
	{$ENDC}
FUNCTION SMPPrepareToChange(window: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0002, $1289, $AA5D;
	{$ENDC}
FUNCTION SMPContentChanged(window: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0002, $126F, $AA5D;
	{$ENDC}
FUNCTION SMPBeginSave(window: WindowPtr; {CONST}VAR diskLetter: FSSpec; creator: OSType; fileType: OSType; saveType: SMPSaveType; VAR mustAddContent: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000B, $1266, $AA5D;
	{$ENDC}
FUNCTION SMPEndSave(window: WindowPtr; okToSave: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0003, $1270, $AA5D;
	{$ENDC}
FUNCTION SMPBeginSend(window: WindowPtr; creator: OSType; fileType: OSType; sendOptions: SMPSendOptionsPtr; VAR mustAddContent: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000A, $1267, $AA5D;
	{$ENDC}
FUNCTION SMPEndSend(window: WindowPtr; okToSend: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0003, $1271, $AA5D;
	{$ENDC}
FUNCTION SMPOpenLetter({CONST}VAR letter: LetterDescriptor; window: WindowPtr; upperLeft: Point; canContract: BOOLEAN; initiallyExpanded: BOOLEAN; prepareMailerForDrawingCB: PrepareMailerForDrawingUPP; clientData: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $1268, $AA5D;
	{$ENDC}
FUNCTION SMPAddMainEnclosure(window: WindowPtr; {CONST}VAR enclosure: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $127D, $AA5D;
	{$ENDC}
FUNCTION SMPGetMainEnclosureFSSpec(window: WindowPtr; VAR enclosureDir: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $127E, $AA5D;
	{$ENDC}
FUNCTION SMPAddContent(window: WindowPtr; segmentType: MailSegmentType; appendFlag: BOOLEAN; buffer: UNIV Ptr; bufferSize: UInt32; textScrap: StScrpPtr; startNewScript: BOOLEAN; script: ScriptCode): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $127A, $AA5D;
	{$ENDC}
FUNCTION SMPReadContent(window: WindowPtr; segmentTypeMask: MailSegmentMask; buffer: UNIV Ptr; bufferSize: UInt32; VAR dataSize: UInt32; textScrap: StScrpPtr; VAR script: ScriptCode; VAR segmentType: MailSegmentType; VAR endOfScript: BOOLEAN; VAR endOfSegment: BOOLEAN; VAR endOfContent: BOOLEAN; VAR segmentLength: LONGINT; VAR segmentID: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0019, $127B, $AA5D;
	{$ENDC}
FUNCTION SMPGetFontNameFromLetter(window: WindowPtr; fontNum: INTEGER; VAR fontName: Str255; doneWithFontTable: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0006, $127C, $AA5D;
	{$ENDC}
FUNCTION SMPAddBlock(window: WindowPtr; {CONST}VAR blockType: OCECreatorType; append: BOOLEAN; buffer: UNIV Ptr; bufferSize: UInt32; mode: MailBlockMode; offset: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $127F, $AA5D;
	{$ENDC}
FUNCTION SMPReadBlock(window: WindowPtr; {CONST}VAR blockType: OCECreatorType; blockIndex: UInt16; buffer: UNIV Ptr; bufferSize: UInt32; dataOffset: UInt32; VAR dataSize: UInt32; VAR endOfBlock: BOOLEAN; VAR remaining: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0011, $1280, $AA5D;
	{$ENDC}
FUNCTION SMPEnumerateBlocks(window: WindowPtr; startIndex: UInt16; buffer: UNIV Ptr; bufferSize: UInt32; VAR dataSize: UInt32; VAR nextIndex: UInt16; VAR more: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000D, $1281, $AA5D;
	{$ENDC}
FUNCTION SMPDrawMailer(window: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0002, $1269, $AA5D;
	{$ENDC}

FUNCTION SMPSetSubject(window: WindowPtr; {CONST}VAR text: RString): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $126B, $AA5D;
	{$ENDC}
FUNCTION SMPSetFromIdentity(window: WindowPtr; from: AuthIdentity): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $126C, $AA5D;
	{$ENDC}
FUNCTION SMPAddAddress(window: WindowPtr; addrType: SMPAddressType; VAR address: OCEPackedRecipient): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0005, $126D, $AA5D;
	{$ENDC}
FUNCTION SMPAddAttachment(window: WindowPtr; {CONST}VAR attachment: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $126E, $AA5D;
	{$ENDC}
FUNCTION SMPAttachDialog(window: WindowPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0002, $1276, $AA5D;
	{$ENDC}

FUNCTION SMPExpandOrContract(window: WindowPtr; expand: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0003, $1272, $AA5D;
	{$ENDC}

FUNCTION SMPMoveMailer(window: WindowPtr; dh: INTEGER; dv: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $126A, $AA5D;
	{$ENDC}

FUNCTION SMPBecomeTarget(window: WindowPtr; becomeTarget: BOOLEAN; whichField: SMPMailerComponent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0005, $1273, $AA5D;
	{$ENDC}

FUNCTION SMPGetComponentSize(window: WindowPtr; whichMailer: UInt16; whichField: SMPMailerComponent; VAR size: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0007, $1277, $AA5D;
	{$ENDC}

FUNCTION SMPGetComponentInfo(window: WindowPtr; whichMailer: UInt16; whichField: SMPMailerComponent; buffer: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0007, $1278, $AA5D;
	{$ENDC}

FUNCTION SMPGetListItemInfo(window: WindowPtr; whichMailer: UInt16; whichField: SMPMailerComponent; buffer: UNIV Ptr; bufferLength: UInt32; startItem: UInt16; VAR itemCount: UInt16; VAR nextItem: UInt16; VAR more: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $1279, $AA5D;
	{$ENDC}
FUNCTION SMPImage(window: WindowPtr; drawImageProc: SMPDrawImageUPP; imageRefCon: LONGINT; supportsColor: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0007, $1282, $AA5D;
	{$ENDC}
FUNCTION SMPGetNextLetter(VAR typesList: OSType; numTypes: INTEGER; VAR adjacentLetter: LetterDescriptor): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0005, $1286, $AA5D;
	{$ENDC}
FUNCTION SMPGetLetterInfo(VAR mailboxSpec: LetterSpec; VAR info: SMPLetterInfo): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $128A, $AA5D;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OCEStandardMailIncludes}

{$ENDC} {__OCESTANDARDMAIL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
