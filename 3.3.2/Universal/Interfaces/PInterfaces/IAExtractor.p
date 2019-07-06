{
     File:       IAExtractor.p
 
     Contains:   Interfaces to Find by Content Plugins that scan files
 
     Version:    Technology: Mac OS 8.6
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1999-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT IAExtractor;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __IAEXTRACTOR__}
{$SETC __IAEXTRACTOR__ := 1}

{$I+}
{$SETC IAExtractorIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ modes for IASetDocAccessorReadPositionProc }

CONST
	kIAFromStartMode			= 0;
	kIAFromCurrMode				= 1;
	kIAFromEndMode				= 2;

{ versions for plug-ins }
	kIAExtractorVersion1		= $00010001;
	kIAExtractorCurrentVersion	= $00010001;

{ types }

TYPE
	IAResult							= OSStatus;
	IAPluginRef = ^LONGINT; { an opaque 32-bit type }
	IADocAccessorRef = ^LONGINT; { an opaque 32-bit type }
	IADocRef = ^LONGINT; { an opaque 32-bit type }
{ IAPluginInitBlock functions }
{$IFC TYPED_FUNCTION_POINTERS}
	IAAllocProcPtr = FUNCTION(inSize: UInt32): Ptr; C;
{$ELSEC}
	IAAllocProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	IAFreeProcPtr = PROCEDURE(inObject: UNIV Ptr); C;
{$ELSEC}
	IAFreeProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	IAIdleProcPtr = FUNCTION: ByteParameter; C;
{$ELSEC}
	IAIdleProcPtr = ProcPtr;
{$ENDC}

	IAAllocUPP = UniversalProcPtr;
	IAFreeUPP = UniversalProcPtr;
	IAIdleUPP = UniversalProcPtr;

CONST
	uppIAAllocProcInfo = $000000F1;
	uppIAFreeProcInfo = $000000C1;
	uppIAIdleProcInfo = $00000011;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewIAAllocUPP(userRoutine: IAAllocProcPtr): IAAllocUPP; { old name was NewIAAllocProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewIAFreeUPP(userRoutine: IAFreeProcPtr): IAFreeUPP; { old name was NewIAFreeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewIAIdleUPP(userRoutine: IAIdleProcPtr): IAIdleUPP; { old name was NewIAIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeIAAllocUPP(userUPP: IAAllocUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeIAFreeUPP(userUPP: IAFreeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeIAIdleUPP(userUPP: IAIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeIAAllocUPP(inSize: UInt32; userRoutine: IAAllocUPP): Ptr; { old name was CallIAAllocProc }

PROCEDURE InvokeIAFreeUPP(inObject: UNIV Ptr; userRoutine: IAFreeUPP); { old name was CallIAFreeProc }

FUNCTION InvokeIAIdleUPP(userRoutine: IAIdleUPP): ByteParameter; { old name was CallIAIdleProc }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	IAPluginInitBlockPtr = ^IAPluginInitBlock;
	IAPluginInitBlock = RECORD
		Alloc:					IAAllocUPP;
		Free:					IAFreeUPP;
		Idle:					IAIdleUPP;
	END;

{ IADocAccessorRecord  functions }
{$IFC TYPED_FUNCTION_POINTERS}
	IADocAccessorOpenProcPtr = FUNCTION(inAccessor: IADocAccessorRef): OSStatus; C;
{$ELSEC}
	IADocAccessorOpenProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	IADocAccessorCloseProcPtr = FUNCTION(inAccessor: IADocAccessorRef): OSStatus; C;
{$ELSEC}
	IADocAccessorCloseProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	IADocAccessorReadProcPtr = FUNCTION(inAccessor: IADocAccessorRef; buffer: UNIV Ptr; VAR ioSize: UInt32): OSStatus; C;
{$ELSEC}
	IADocAccessorReadProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	IASetDocAccessorReadPositionProcPtr = FUNCTION(inAccessor: IADocAccessorRef; inMode: SInt32; inOffset: SInt32): OSStatus; C;
{$ELSEC}
	IASetDocAccessorReadPositionProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	IAGetDocAccessorReadPositionProcPtr = FUNCTION(inAccessor: IADocAccessorRef; VAR outPostion: SInt32): OSStatus; C;
{$ELSEC}
	IAGetDocAccessorReadPositionProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	IAGetDocAccessorEOFProcPtr = FUNCTION(inAccessor: IADocAccessorRef; VAR outEOF: SInt32): OSStatus; C;
{$ELSEC}
	IAGetDocAccessorEOFProcPtr = ProcPtr;
{$ENDC}

	IADocAccessorOpenUPP = UniversalProcPtr;
	IADocAccessorCloseUPP = UniversalProcPtr;
	IADocAccessorReadUPP = UniversalProcPtr;
	IASetDocAccessorReadPositionUPP = UniversalProcPtr;
	IAGetDocAccessorReadPositionUPP = UniversalProcPtr;
	IAGetDocAccessorEOFUPP = UniversalProcPtr;

CONST
	uppIADocAccessorOpenProcInfo = $000000F1;
	uppIADocAccessorCloseProcInfo = $000000F1;
	uppIADocAccessorReadProcInfo = $00000FF1;
	uppIASetDocAccessorReadPositionProcInfo = $00000FF1;
	uppIAGetDocAccessorReadPositionProcInfo = $000003F1;
	uppIAGetDocAccessorEOFProcInfo = $000003F1;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewIADocAccessorOpenUPP(userRoutine: IADocAccessorOpenProcPtr): IADocAccessorOpenUPP; { old name was NewIADocAccessorOpenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewIADocAccessorCloseUPP(userRoutine: IADocAccessorCloseProcPtr): IADocAccessorCloseUPP; { old name was NewIADocAccessorCloseProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewIADocAccessorReadUPP(userRoutine: IADocAccessorReadProcPtr): IADocAccessorReadUPP; { old name was NewIADocAccessorReadProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewIASetDocAccessorReadPositionUPP(userRoutine: IASetDocAccessorReadPositionProcPtr): IASetDocAccessorReadPositionUPP; { old name was NewIASetDocAccessorReadPositionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewIAGetDocAccessorReadPositionUPP(userRoutine: IAGetDocAccessorReadPositionProcPtr): IAGetDocAccessorReadPositionUPP; { old name was NewIAGetDocAccessorReadPositionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewIAGetDocAccessorEOFUPP(userRoutine: IAGetDocAccessorEOFProcPtr): IAGetDocAccessorEOFUPP; { old name was NewIAGetDocAccessorEOFProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeIADocAccessorOpenUPP(userUPP: IADocAccessorOpenUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeIADocAccessorCloseUPP(userUPP: IADocAccessorCloseUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeIADocAccessorReadUPP(userUPP: IADocAccessorReadUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeIASetDocAccessorReadPositionUPP(userUPP: IASetDocAccessorReadPositionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeIAGetDocAccessorReadPositionUPP(userUPP: IAGetDocAccessorReadPositionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeIAGetDocAccessorEOFUPP(userUPP: IAGetDocAccessorEOFUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeIADocAccessorOpenUPP(inAccessor: IADocAccessorRef; userRoutine: IADocAccessorOpenUPP): OSStatus; { old name was CallIADocAccessorOpenProc }

FUNCTION InvokeIADocAccessorCloseUPP(inAccessor: IADocAccessorRef; userRoutine: IADocAccessorCloseUPP): OSStatus; { old name was CallIADocAccessorCloseProc }

FUNCTION InvokeIADocAccessorReadUPP(inAccessor: IADocAccessorRef; buffer: UNIV Ptr; VAR ioSize: UInt32; userRoutine: IADocAccessorReadUPP): OSStatus; { old name was CallIADocAccessorReadProc }

FUNCTION InvokeIASetDocAccessorReadPositionUPP(inAccessor: IADocAccessorRef; inMode: SInt32; inOffset: SInt32; userRoutine: IASetDocAccessorReadPositionUPP): OSStatus; { old name was CallIASetDocAccessorReadPositionProc }

FUNCTION InvokeIAGetDocAccessorReadPositionUPP(inAccessor: IADocAccessorRef; VAR outPostion: SInt32; userRoutine: IAGetDocAccessorReadPositionUPP): OSStatus; { old name was CallIAGetDocAccessorReadPositionProc }

FUNCTION InvokeIAGetDocAccessorEOFUPP(inAccessor: IADocAccessorRef; VAR outEOF: SInt32; userRoutine: IAGetDocAccessorEOFUPP): OSStatus; { old name was CallIAGetDocAccessorEOFProc }
{$ENDC}  {CALL_NOT_IN_CARBON}

{ IADocAccessorRecord }

TYPE
	IADocAccessorRecordPtr = ^IADocAccessorRecord;
	IADocAccessorRecord = RECORD
		docAccessor:			IADocAccessorRef;
		OpenDoc:				IADocAccessorOpenUPP;
		CloseDoc:				IADocAccessorCloseUPP;
		ReadDoc:				IADocAccessorReadUPP;
		SetReadPosition:		IASetDocAccessorReadPositionUPP;
		GetReadPosition:		IAGetDocAccessorReadPositionUPP;
		GetEOF:					IAGetDocAccessorEOFUPP;
	END;

	IADocAccessorPtr					= ^IADocAccessorRecord;
{
    A Sherlock Plugin is a CFM shared library that implements the following functions:
}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION IAPluginInit(initBlock: IAPluginInitBlockPtr; VAR outPluginRef: IAPluginRef): OSStatus; C;
FUNCTION IAPluginTerm(inPluginRef: IAPluginRef): OSStatus; C;
FUNCTION IAGetExtractorVersion(inPluginRef: IAPluginRef; VAR outPluginVersion: UInt32): OSStatus; C;
FUNCTION IACountSupportedDocTypes(inPluginRef: IAPluginRef; VAR outCount: UInt32): OSStatus; C;
FUNCTION IAGetIndSupportedDocType(inPluginRef: IAPluginRef; inIndex: UInt32; VAR outMIMEType: CStringPtr): OSStatus; C;
FUNCTION IAOpenDocument(inPluginRef: IAPluginRef; VAR inDoc: IADocAccessorRecord; VAR outDoc: IADocRef): OSStatus; C;
FUNCTION IACloseDocument(inDoc: IADocRef): OSStatus; C;
FUNCTION IAGetNextTextRun(inDoc: IADocRef; buffer: UNIV Ptr; VAR ioSize: UInt32): OSStatus; C;
FUNCTION IAGetTextRunInfo(inDoc: IADocRef; VAR outEncoding: CStringPtr; VAR outLanguage: CStringPtr): OSStatus; C;






{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := IAExtractorIncludes}

{$ENDC} {__IAEXTRACTOR__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
