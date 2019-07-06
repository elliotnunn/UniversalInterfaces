{
 	File:		Editions.p
 
 	Contains:	Edition Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1989-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Editions;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __EDITIONS__}
{$SETC __EDITIONS__ := 1}

{$I+}
{$SETC EditionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __ALIASES__}
{$I Aliases.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  resource types   }
	rSectionType				= 'sect';						{  ResType of saved SectionRecords  }
																{  Finder types for edition files  }
	kPICTEditionFileType		= 'edtp';
	kTEXTEditionFileType		= 'edtt';
	ksndEditionFileType			= 'edts';
	kUnknownEditionFileType		= 'edtu';
	kPublisherDocAliasFormat	= 'alis';
	kPreviewFormat				= 'prvw';
	kFormatListFormat			= 'fmts';

																{  section types  }
	stSubscriber				= $01;
	stPublisher					= $0A;

	sumAutomatic				= 0;							{  subscriber update mode - Automatically      }
	sumManual					= 1;							{  subscriber update mode - Manually  }
	pumOnSave					= 0;							{  publisher update mode - OnSave             }
	pumManual					= 1;							{  publisher update mode - Manually  }

	kPartsNotUsed				= 0;
	kPartNumberUnknown			= -1;

	kPreviewWidth				= 120;
	kPreviewHeight				= 120;

																{  bits for formatsMask  }
	kPICTformatMask				= 1;
	kTEXTformatMask				= 2;
	ksndFormatMask				= 4;


																{  pseudo-item hits for dialogHooks the first is for NewPublisher or NewSubscriber Dialogs  }
	emHookRedrawPreview			= 150;							{  the following are for SectionOptions Dialog  }
	emHookCancelSection			= 160;
	emHookGoToPublisher			= 161;
	emHookGetEditionNow			= 162;
	emHookSendEditionNow		= 162;
	emHookManualUpdateMode		= 163;
	emHookAutoUpdateMode		= 164;


																{  the refcon field of the dialog record during a modalfilter or dialoghook contains one the following  }
	emOptionsDialogRefCon		= 'optn';
	emCancelSectionDialogRefCon	= 'cncl';
	emGoToPubErrDialogRefCon	= 'gerr';

	kFormatLengthUnknown		= -1;

{ one byte, stSubscriber or stPublisher }

TYPE
	SectionType							= SignedByte;
{ seconds since 1904 }
	TimeStamp							= UInt32;
{ similar to ResType }
	FormatType							= FourCharCode;
{ used in Edition I/O }
	EditionRefNum						= Handle;
{ update modes }
{ sumAutomatic, pumSuspend, etc }
	UpdateMode							= INTEGER;
	SectionRecordPtr = ^SectionRecord;
	SectionPtr							= ^SectionRecord;
	SectionHandle						= ^SectionPtr;
	SectionRecord = RECORD
		version:				SignedByte;								{  always 0x01 in system 7.0  }
		kind:					SectionType;							{  stSubscriber or stPublisher  }
		mode:					UpdateMode;								{  auto or manual  }
		mdDate:					TimeStamp;								{  last change in document  }
		sectionID:				LONGINT;								{  app. specific, unique per document  }
		refCon:					LONGINT;								{  application specific  }
		alias:					AliasHandle;							{  handle to Alias Record  }
		subPart:				LONGINT;								{  which part of container file  }
		nextSection:			SectionHandle;							{  for linked list of app's Sections  }
		controlBlock:			Handle;									{  used internally  }
		refNum:					EditionRefNum;							{  used internally  }
	END;

	EditionContainerSpecPtr = ^EditionContainerSpec;
	EditionContainerSpec = RECORD
		theFile:				FSSpec;
		theFileScript:			ScriptCode;
		thePart:				LONGINT;
		thePartName:			Str31;
		thePartScript:			ScriptCode;
	END;

	EditionInfoRecordPtr = ^EditionInfoRecord;
	EditionInfoRecord = RECORD
		crDate:					TimeStamp;								{  date EditionContainer was created  }
		mdDate:					TimeStamp;								{  date of last change  }
		fdCreator:				OSType;									{  file creator  }
		fdType:					OSType;									{  file type  }
		container:				EditionContainerSpec;					{  the Edition  }
	END;

	NewPublisherReplyPtr = ^NewPublisherReply;
	NewPublisherReply = RECORD
		canceled:				BOOLEAN;								{  O  }
		replacing:				BOOLEAN;
		usePart:				BOOLEAN;								{  I  }
		filler:					SInt8;
		preview:				Handle;									{  I  }
		previewFormat:			FormatType;								{  I  }
		container:				EditionContainerSpec;					{  I/O  }
	END;

	NewSubscriberReplyPtr = ^NewSubscriberReply;
	NewSubscriberReply = RECORD
		canceled:				BOOLEAN;								{  O  }
		formatsMask:			SignedByte;
		container:				EditionContainerSpec;					{ I/O }
	END;

	SectionOptionsReplyPtr = ^SectionOptionsReply;
	SectionOptionsReply = RECORD
		canceled:				BOOLEAN;								{  O  }
		changed:				BOOLEAN;								{  O  }
		sectionH:				SectionHandle;							{  I  }
		action:					ResType;								{  O  }
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	ExpModalFilterProcPtr = FUNCTION(theDialog: DialogPtr; VAR theEvent: EventRecord; itemOffset: INTEGER; VAR itemHit: INTEGER; yourDataPtr: Ptr): BOOLEAN;
{$ELSEC}
	ExpModalFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ExpDlgHookProcPtr = FUNCTION(itemOffset: INTEGER; itemHit: INTEGER; theDialog: DialogPtr; yourDataPtr: Ptr): INTEGER;
{$ELSEC}
	ExpDlgHookProcPtr = ProcPtr;
{$ENDC}

	ExpModalFilterUPP = UniversalProcPtr;
	ExpDlgHookUPP = UniversalProcPtr;

CONST
	uppExpModalFilterProcInfo = $0000FBD0;
	uppExpDlgHookProcInfo = $00003EA0;

FUNCTION NewExpModalFilterProc(userRoutine: ExpModalFilterProcPtr): ExpModalFilterUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewExpDlgHookProc(userRoutine: ExpDlgHookProcPtr): ExpDlgHookUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallExpModalFilterProc(theDialog: DialogPtr; VAR theEvent: EventRecord; itemOffset: INTEGER; VAR itemHit: INTEGER; yourDataPtr: Ptr; userRoutine: ExpModalFilterUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallExpDlgHookProc(itemOffset: INTEGER; itemHit: INTEGER; theDialog: DialogPtr; yourDataPtr: Ptr; userRoutine: ExpDlgHookUPP): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

CONST
	ioHasFormat					= 0;
	ioReadFormat				= 1;
	ioNewFormat					= 2;
	ioWriteFormat				= 3;


TYPE
	FormatIOVerb						= SignedByte;

CONST
	eoOpen						= 0;
	eoClose						= 1;
	eoOpenNew					= 2;
	eoCloseNew					= 3;
	eoCanSubscribe				= 4;


TYPE
	EditionOpenerVerb					= SignedByte;
	FormatIOParamBlockPtr = ^FormatIOParamBlock;
	FormatIOParamBlock = RECORD
		ioRefNum:				LONGINT;
		format:					FormatType;
		formatIndex:			LONGINT;
		offset:					UInt32;
		buffPtr:				Ptr;
		buffLen:				UInt32;
	END;

	EditionOpenerParamBlockPtr = ^EditionOpenerParamBlock;
{$IFC TYPED_FUNCTION_POINTERS}
	FormatIOProcPtr = FUNCTION(selector: FormatIOVerb; VAR PB: FormatIOParamBlock): INTEGER;
{$ELSEC}
	FormatIOProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	EditionOpenerProcPtr = FUNCTION(selector: EditionOpenerVerb; VAR PB: EditionOpenerParamBlock): INTEGER;
{$ELSEC}
	EditionOpenerProcPtr = ProcPtr;
{$ENDC}

	FormatIOUPP = UniversalProcPtr;
	EditionOpenerUPP = UniversalProcPtr;
	EditionOpenerParamBlock = RECORD
		info:					EditionInfoRecord;
		sectionH:				SectionHandle;
		document:				FSSpecPtr;
		fdCreator:				OSType;
		ioRefNum:				LONGINT;
		ioProc:					FormatIOUPP;
		success:				BOOLEAN;
		formatsMask:			SignedByte;
	END;


CONST
	uppFormatIOProcInfo = $00000360;
	uppEditionOpenerProcInfo = $00000360;

FUNCTION NewFormatIOProc(userRoutine: FormatIOProcPtr): FormatIOUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewEditionOpenerProc(userRoutine: EditionOpenerProcPtr): EditionOpenerUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}
{ 
 Section events now arrive in the message buffer using the AppleEvent format.
 The direct object parameter is an aeTemporaryIDParamType ('tid '). The temporary
 ID's type is rSectionType ('sect') and the 32-bit value is a SectionHandle.
 The following is a sample buffer
 
 name   	offset 	contents
 ----   	------ 	--------
 header   		0  	'aevt'
 majorVersion 	4  	0x01
 minorVersion 	6  	0x01
 endOfMetaData 	8  	';;;;' 
 directObjKey 	12  '----' 
 paramType  	16  'tid ' 
 paramLength  	20  0x0008 
 tempIDType  	24  'sect' 
 tempID    		28  the SectionHandle <-- this is want you want
}


CONST
	sectionEventMsgClass		= 'sect';
	sectionReadMsgID			= 'read';
	sectionWriteMsgID			= 'writ';
	sectionScrollMsgID			= 'scrl';
	sectionCancelMsgID			= 'cncl';

	currentEditionMgrVers		= $0011;



{ Use InitEditionPackVersion(currentEditionMgrVers) instead of InitEditionPack }
FUNCTION InitEditionPackVersion(curEditionMgrVers: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0100, $A82D;
	{$ENDC}
FUNCTION NewSection({CONST}VAR container: EditionContainerSpec; sectionDocument: ConstFSSpecPtr; kind: SectionType; sectionID: LONGINT; initalMode: UpdateMode; VAR sectionH: SectionHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A02, $A82D;
	{$ENDC}
FUNCTION RegisterSection({CONST}VAR sectionDocument: FSSpec; sectionH: SectionHandle; VAR aliasWasUpdated: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0604, $A82D;
	{$ENDC}
FUNCTION UnRegisterSection(sectionH: SectionHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0206, $A82D;
	{$ENDC}
FUNCTION IsRegisteredSection(sectionH: SectionHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0208, $A82D;
	{$ENDC}
FUNCTION AssociateSection(sectionH: SectionHandle; {CONST}VAR newSectionDocument: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040C, $A82D;
	{$ENDC}
FUNCTION CreateEditionContainerFile({CONST}VAR editionFile: FSSpec; fdCreator: OSType; editionFileNameScript: ScriptCode): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050E, $A82D;
	{$ENDC}
FUNCTION DeleteEditionContainerFile({CONST}VAR editionFile: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0210, $A82D;
	{$ENDC}
FUNCTION OpenEdition(subscriberSectionH: SectionHandle; VAR refNum: EditionRefNum): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0412, $A82D;
	{$ENDC}
FUNCTION OpenNewEdition(publisherSectionH: SectionHandle; fdCreator: OSType; publisherSectionDocument: ConstFSSpecPtr; VAR refNum: EditionRefNum): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0814, $A82D;
	{$ENDC}
FUNCTION CloseEdition(whichEdition: EditionRefNum; successful: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0316, $A82D;
	{$ENDC}
FUNCTION EditionHasFormat(whichEdition: EditionRefNum; whichFormat: FormatType; VAR formatSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0618, $A82D;
	{$ENDC}
FUNCTION ReadEdition(whichEdition: EditionRefNum; whichFormat: FormatType; buffPtr: UNIV Ptr; VAR buffLen: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $081A, $A82D;
	{$ENDC}
FUNCTION WriteEdition(whichEdition: EditionRefNum; whichFormat: FormatType; buffPtr: UNIV Ptr; buffLen: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $081C, $A82D;
	{$ENDC}
FUNCTION GetEditionFormatMark(whichEdition: EditionRefNum; whichFormat: FormatType; VAR currentMark: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $061E, $A82D;
	{$ENDC}
FUNCTION SetEditionFormatMark(whichEdition: EditionRefNum; whichFormat: FormatType; setMarkTo: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0620, $A82D;
	{$ENDC}
FUNCTION GetEditionInfo(sectionH: SectionHandle; VAR editionInfo: EditionInfoRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0422, $A82D;
	{$ENDC}
FUNCTION GoToPublisherSection({CONST}VAR container: EditionContainerSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0224, $A82D;
	{$ENDC}
FUNCTION GetLastEditionContainerUsed(VAR container: EditionContainerSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0226, $A82D;
	{$ENDC}
FUNCTION GetStandardFormats({CONST}VAR container: EditionContainerSpec; VAR previewFormat: FormatType; preview: Handle; publisherAlias: Handle; formats: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A28, $A82D;
	{$ENDC}
FUNCTION GetEditionOpenerProc(VAR opener: EditionOpenerUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022A, $A82D;
	{$ENDC}
FUNCTION SetEditionOpenerProc(opener: EditionOpenerUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022C, $A82D;
	{$ENDC}
FUNCTION CallEditionOpenerProc(selector: EditionOpenerVerb; VAR PB: EditionOpenerParamBlock; routine: EditionOpenerUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $052E, $A82D;
	{$ENDC}
FUNCTION CallFormatIOProc(selector: FormatIOVerb; VAR PB: FormatIOParamBlock; routine: FormatIOUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0530, $A82D;
	{$ENDC}
FUNCTION NewSubscriberDialog(VAR reply: NewSubscriberReply): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0232, $A82D;
	{$ENDC}
FUNCTION NewSubscriberExpDialog(VAR reply: NewSubscriberReply; where: Point; expansionDITLresID: INTEGER; dlgHook: ExpDlgHookUPP; filter: ExpModalFilterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B34, $A82D;
	{$ENDC}
FUNCTION NewPublisherDialog(VAR reply: NewPublisherReply): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0236, $A82D;
	{$ENDC}
FUNCTION NewPublisherExpDialog(VAR reply: NewPublisherReply; where: Point; expansionDITLresID: INTEGER; dlgHook: ExpDlgHookUPP; filter: ExpModalFilterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B38, $A82D;
	{$ENDC}
FUNCTION SectionOptionsDialog(VAR reply: SectionOptionsReply): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $023A, $A82D;
	{$ENDC}
FUNCTION SectionOptionsExpDialog(VAR reply: SectionOptionsReply; where: Point; expansionDITLresID: INTEGER; dlgHook: ExpDlgHookUPP; filter: ExpModalFilterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B3C, $A82D;
	{$ENDC}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := EditionsIncludes}

{$ENDC} {__EDITIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
