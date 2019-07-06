{
     File:       FindByContent.p
 
     Contains:   Public search interface for the Find by Content shared library
 
     Version:    Technology: 2.0
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1997-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT FindByContent;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FINDBYCONTENT__}
{$SETC __FINDBYCONTENT__ := 1}

{$I+}
{$SETC FindByContentIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
   ***************************************************************************
   Phase values
   These values are passed to the client's callback function to indicate what
   the FBC code is doing.
   ***************************************************************************
}

CONST
																{  indexing phases }
	kFBCphIndexing				= 0;
	kFBCphFlushing				= 1;
	kFBCphMerging				= 2;
	kFBCphMakingIndexAccessor	= 3;
	kFBCphCompacting			= 4;
	kFBCphIndexWaiting			= 5;							{  access phases }
	kFBCphSearching				= 6;
	kFBCphMakingAccessAccessor	= 7;
	kFBCphAccessWaiting			= 8;							{  summarization }
	kFBCphSummarizing			= 9;							{  indexing or access }
	kFBCphIdle					= 10;
	kFBCphCanceling				= 11;



{
   ***************************************************************************
   Pointer types
   These point to memory allocated by the FBC shared library, and must be deallocated
   by calls that are defined below.
   ***************************************************************************
}

{  A collection of state information for searching }

TYPE
	FBCSearchSession = ^LONGINT; { an opaque 32-bit type }
{  a FBCWordList is a pointer to an array of pointers to c-strings }
	FBCWordListRecPtr = ^FBCWordListRec;
	FBCWordListRec = RECORD
		words:					ARRAY [0..0] OF ConstCStringPtr;		{  array of pointers to c-strings }
	END;

	FBCWordList							= ^FBCWordListRec;
{
   ***************************************************************************
   Callback function type for progress reporting and cancelation during
   searching and indexing.  The client's callback function should call
   WaitNextEvent; a "sleep" value of 1 is suggested.  If the callback function
   wants to cancel the current operation (indexing, search, or doc-terms
   retrieval) it should return true.
   ***************************************************************************
}

{$IFC TYPED_FUNCTION_POINTERS}
	FBCCallbackProcPtr = FUNCTION(phase: UInt16; percentDone: Single; data: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	FBCCallbackProcPtr = ProcPtr;
{$ENDC}

	FBCCallbackUPP = ^LONGINT;  { an opaque UPP }

CONST
	uppFBCCallbackProcInfo = $00000F91;

FUNCTION NewFBCCallbackUPP(userRoutine: FBCCallbackProcPtr): FBCCallbackUPP; { old name was NewFBCCallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeFBCCallbackUPP(userUPP: FBCCallbackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeFBCCallbackUPP(phase: UInt16; percentDone: Single; data: UNIV Ptr; userRoutine: FBCCallbackUPP): BOOLEAN; { old name was CallFBCCallbackProc }
{
   ***************************************************************************
   Set the callback function for progress reporting and cancelation during
   searching and indexing, and set the amount of heap space to reserve for
   the client's use when FBC allocates memory.
   ***************************************************************************
}
PROCEDURE FBCSetCallback(fn: FBCCallbackUPP; data: UNIV Ptr); C;
PROCEDURE FBCSetHeapReservation(bytes: UInt32); C;
{
   ***************************************************************************
   Find out whether a volume is indexed, the date & time of its last
   completed  update, and its physical size.
   ***************************************************************************
}

FUNCTION FBCVolumeIsIndexed(theVRefNum: SInt16): BOOLEAN; C;
FUNCTION FBCVolumeIsRemote(theVRefNum: SInt16): BOOLEAN; C;
FUNCTION FBCVolumeIndexTimeStamp(theVRefNum: SInt16; VAR timeStamp: UInt32): OSErr; C;
FUNCTION FBCVolumeIndexPhysicalSize(theVRefNum: SInt16; VAR size: UInt32): OSErr; C;
{
   ***************************************************************************
   Create & configure a search session
   ***************************************************************************
}

FUNCTION FBCCreateSearchSession(VAR searchSession: FBCSearchSession): OSErr; C;
FUNCTION FBCAddAllVolumesToSession(theSession: FBCSearchSession; includeRemote: BOOLEAN): OSErr; C;
FUNCTION FBCSetSessionVolumes(theSession: FBCSearchSession; {CONST}VAR vRefNums: SInt16; numVolumes: UInt16): OSErr; C;
FUNCTION FBCAddVolumeToSession(theSession: FBCSearchSession; vRefNum: SInt16): OSErr; C;
FUNCTION FBCRemoveVolumeFromSession(theSession: FBCSearchSession; vRefNum: SInt16): OSErr; C;
FUNCTION FBCGetSessionVolumeCount(theSession: FBCSearchSession; VAR count: UInt16): OSErr; C;
FUNCTION FBCGetSessionVolumes(theSession: FBCSearchSession; VAR vRefNums: SInt16; VAR numVolumes: UInt16): OSErr; C;
FUNCTION FBCCloneSearchSession(original: FBCSearchSession; VAR clone: FBCSearchSession): OSErr; C;
{
   ***************************************************************************
   Execute a search
   ***************************************************************************
}

FUNCTION FBCDoQuerySearch(theSession: FBCSearchSession; queryText: CStringPtr; {CONST}VAR targetDirs: FSSpec; numTargets: UInt32; maxHits: UInt32; maxHitWords: UInt32): OSErr; C;
FUNCTION FBCDoExampleSearch(theSession: FBCSearchSession; {CONST}VAR exampleHitNums: UInt32; numExamples: UInt32; {CONST}VAR targetDirs: FSSpec; numTargets: UInt32; maxHits: UInt32; maxHitWords: UInt32): OSErr; C;
FUNCTION FBCBlindExampleSearch(VAR examples: FSSpec; numExamples: UInt32; {CONST}VAR targetDirs: FSSpec; numTargets: UInt32; maxHits: UInt32; maxHitWords: UInt32; allIndexes: BOOLEAN; includeRemote: BOOLEAN; VAR theSession: FBCSearchSession): OSErr; C;

{
   ***************************************************************************
   Get information about hits [wrapper for THitItem C++ API]
   ***************************************************************************
}

FUNCTION FBCGetHitCount(theSession: FBCSearchSession; VAR count: UInt32): OSErr; C;
FUNCTION FBCGetHitDocument(theSession: FBCSearchSession; hitNumber: UInt32; VAR theDocument: FSSpec): OSErr; C;
FUNCTION FBCGetHitScore(theSession: FBCSearchSession; hitNumber: UInt32; VAR score: Single): OSErr; C;
FUNCTION FBCGetMatchedWords(theSession: FBCSearchSession; hitNumber: UInt32; VAR wordCount: UInt32; VAR list: FBCWordList): OSErr; C;
FUNCTION FBCGetTopicWords(theSession: FBCSearchSession; hitNumber: UInt32; VAR wordCount: UInt32; VAR list: FBCWordList): OSErr; C;

{
   ***************************************************************************
   Summarize a buffer of text
   ***************************************************************************
}

FUNCTION FBCSummarize(inBuf: UNIV Ptr; inLength: UInt32; outBuf: UNIV Ptr; VAR outLength: UInt32; VAR numSentences: UInt32): OSErr; C;
{
   ***************************************************************************
   Deallocate hit lists, word arrays, and search sessions
   ***************************************************************************
}

FUNCTION FBCReleaseSessionHits(theSession: FBCSearchSession): OSErr; C;
FUNCTION FBCDestroyWordList(theList: FBCWordList; wordCount: UInt32): OSErr; C;
FUNCTION FBCDestroySearchSession(theSession: FBCSearchSession): OSErr; C;
{
   ***************************************************************************
   Index one or more files and/or folders
   ***************************************************************************
}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION FBCIndexItems(theItems: FSSpecArrayPtr; itemCount: UInt32): OSErr; C;
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FindByContentIncludes}

{$ENDC} {__FINDBYCONTENT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}