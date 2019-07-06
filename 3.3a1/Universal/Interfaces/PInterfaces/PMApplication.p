{
 	File:		PMApplication.p
 
 	Contains:	Carbon Printing Manager Interfaces.
 
 	Version:	Technology:	Mac OS 8.x
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1998-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT PMApplication;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PMAPPLICATION__}
{$SETC __PMAPPLICATION__ := 1}

{$I+}
{$SETC PMApplicationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Carbon printing structures }

TYPE
	PMObject = ^LONGINT; { an opaque 32-bit type }
	PMDialog = ^LONGINT; { an opaque 32-bit type }
	PMPrintSettings						= PMObject;
	PMPageFormat						= PMObject;
	PMPrintContext = ^LONGINT; { an opaque 32-bit type }
	PMResolutionPtr = ^PMResolution;
	PMResolution = RECORD
		hRes:					Double;
		vRes:					Double;
	END;

	PMLanguageInfoPtr = ^PMLanguageInfo;
	PMLanguageInfo = RECORD
		level:					Str32;
		version:				Str32;
		release:				Str32;
	END;

	PMRectPtr = ^PMRect;
	PMRect = RECORD
		top:					Double;
		left:					Double;
		bottom:					Double;
		right:					Double;
	END;

{ Callbacks }
{$IFC TYPED_FUNCTION_POINTERS}
	PMIdleProcPtr = PROCEDURE;
{$ELSEC}
	PMIdleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PMItemProcPtr = PROCEDURE(theDialog: DialogPtr; item: INTEGER);
{$ELSEC}
	PMItemProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PMPrintDialogInitProcPtr = PROCEDURE(printSettings: PMPrintSettings; VAR theDialog: PMDialog);
{$ELSEC}
	PMPrintDialogInitProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PMPageSetupDialogInitProcPtr = PROCEDURE(pageFormat: PMPageFormat; VAR theDialog: PMDialog);
{$ELSEC}
	PMPageSetupDialogInitProcPtr = ProcPtr;
{$ENDC}

	PMIdleUPP = UniversalProcPtr;
	PMItemUPP = UniversalProcPtr;
	PMPrintDialogInitUPP = UniversalProcPtr;
	PMPageSetupDialogInitUPP = UniversalProcPtr;

CONST
	uppPMIdleProcInfo = $00000000;
	uppPMItemProcInfo = $000002C0;
	uppPMPrintDialogInitProcInfo = $000003C0;
	uppPMPageSetupDialogInitProcInfo = $000003C0;

FUNCTION NewPMIdleUPP(userRoutine: PMIdleProcPtr): PMIdleUPP; { old name was NewPMIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPMItemUPP(userRoutine: PMItemProcPtr): PMItemUPP; { old name was NewPMItemProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPMPrintDialogInitUPP(userRoutine: PMPrintDialogInitProcPtr): PMPrintDialogInitUPP; { old name was NewPMPrintDialogInitProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPMPageSetupDialogInitUPP(userRoutine: PMPageSetupDialogInitProcPtr): PMPageSetupDialogInitUPP; { old name was NewPMPageSetupDialogInitProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposePMIdleUPP(userUPP: PMIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposePMItemUPP(userUPP: PMItemUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposePMPrintDialogInitUPP(userUPP: PMPrintDialogInitUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposePMPageSetupDialogInitUPP(userUPP: PMPageSetupDialogInitUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokePMIdleUPP(userRoutine: PMIdleUPP); { old name was CallPMIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokePMItemUPP(theDialog: DialogPtr; item: INTEGER; userRoutine: PMItemUPP); { old name was CallPMItemProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokePMPrintDialogInitUPP(printSettings: PMPrintSettings; VAR theDialog: PMDialog; userRoutine: PMPrintDialogInitUPP); { old name was CallPMPrintDialogInitProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokePMPageSetupDialogInitUPP(pageFormat: PMPageFormat; VAR theDialog: PMDialog; userRoutine: PMPageSetupDialogInitUPP); { old name was CallPMPageSetupDialogInitProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{ enums }

CONST
	kPMCancel					= $0080;						{  user hit cancel button in dialog  }
	kPMNoData					= 0;							{  for general use  }
	kPMDontWantSize				= 0;							{  for parameters which return size information  }
	kPMDontWantData				= 0;							{  for parameters which return data  }
	kPMDontWantBoolean			= 0;							{  for parameters which take a boolean reference  }
	kPMNoPrintSettings			= 0;							{  for parameters which take a PrintSettings reference  }
	kPMNoPageFormat				= 0;							{  for parameters which take a PageFormat reference  }
	kPMNoReference				= 0;							{  for parameters which take an address pointer  }


TYPE
	PMTag 						= UInt32;
CONST
																{  common tags  }
	kPMCurrentValue				= 'curr';						{  current setting or value  }
	kPMDefaultValue				= 'dflt';						{  default setting or value  }
	kPMMinimumValue				= 'minv';						{  the minimum setting or value  }
	kPMMaximumValue				= 'maxv';						{  the maximum setting or value  }
																{  profile tags  }
	kPMSourceProfile			= 'srcp';						{  source profile  }
																{  resolution tags  }
	kPMMinRange					= 'mnrg';						{  Min range supported by a printer  }
	kPMMaxRange					= 'mxrg';						{  Max range supported by a printer  }
	kPMMinSquareResolution		= 'mins';						{  Min with X and Y resolution equal  }
	kPMMaxSquareResolution		= 'maxs';						{  Max with X and Y resolution equal  }
	kPMDefaultResolution		= 'dftr';						{  printer default resolution  }



TYPE
	PMOrientation 				= UInt16;
CONST
	kPMPortrait					= 1;
	kPMLandscape				= 2;
	kPMReversePortrait			= 3;							{  will revert to kPortrait for current drivers  }
	kPMReverseLandscape			= 4;							{  will revert to kLandscape for current drivers  }

	kSizeOfTPrint				= 120;							{  size of old TPrint record  }

{ OSStatus return codes }
	kPMNoError					= 0;
	kPMGeneralError				= -30870;
	kPMOutOfScope				= -30871;						{  an API call is out of scope  }
	kPMInvalidParameter			= -30872;						{  a required parameter is missing or invalid  }
	kPMNotImplemented			= -30873;						{  this API call is not supported  }
	kPMNoSuchEntry				= -30874;						{  no such entry  }
	kPMInvalidPrintSettings		= -30875;						{  the printsettings reference is invalid  }
	kPMInvalidPageFormat		= -30876;						{  the pageformat reference is invalid  }
	kPMValueOutOfRange			= -30877;						{  a value passed in is out of range  }
	kPMLockIgnored				= -30878;						{  the lock value was ignored  }

{ Print loop }
FUNCTION PMBegin: OSStatus;
FUNCTION PMEnd: OSStatus;
FUNCTION PMBeginDocument(printSettings: PMPrintSettings; pageFormat: PMPageFormat; VAR printContext: PMPrintContext): OSStatus;
FUNCTION PMEndDocument(printContext: PMPrintContext): OSStatus;
FUNCTION PMBeginPage(printContext: PMPrintContext; {CONST}VAR pageFrame: PMRect): OSStatus;
FUNCTION PMEndPage(printContext: PMPrintContext): OSStatus;
FUNCTION PMSetIdleProc(idleProc: PMIdleUPP): OSStatus;
FUNCTION PMGetGrafPtr(printContext: PMPrintContext; VAR grafPort: GrafPtr): OSStatus;
{ PMPageFormat }
FUNCTION PMNewPageFormat(VAR pageFormat: PMPageFormat): OSStatus;
FUNCTION PMDisposePageFormat(pageFormat: PMPageFormat): OSStatus;
FUNCTION PMDefaultPageFormat(pageFormat: PMPageFormat): OSStatus;
FUNCTION PMValidatePageFormat(pageFormat: PMPageFormat; VAR result: BOOLEAN): OSStatus;
FUNCTION PMCopyPageFormat(formatSrc: PMPageFormat; formatDest: PMPageFormat): OSStatus;
FUNCTION PMFlattenPageFormat(pageFormat: PMPageFormat; VAR flatFormat: Handle): OSStatus;
FUNCTION PMUnflattenPageFormat(flatFormat: Handle; VAR pageFormat: PMPageFormat): OSStatus;
FUNCTION PMGetPageFormatExtendedData(pageFormat: PMPageFormat; dataID: OSType; VAR size: UInt32; theData: UNIV Ptr): OSStatus;
FUNCTION PMSetPageFormatExtendedData(pageFormat: PMPageFormat; dataID: OSType; size: UInt32; theData: UNIV Ptr): OSStatus;
{ PMPageFormat Accessors }
FUNCTION PMGetScale(pageFormat: PMPageFormat; VAR scale: Double): OSStatus;
FUNCTION PMSetScale(pageFormat: PMPageFormat; scale: Double): OSStatus;
FUNCTION PMGetResolution(pageFormat: PMPageFormat; VAR res: PMResolution): OSStatus;
FUNCTION PMSetResolution(pageFormat: PMPageFormat; {CONST}VAR res: PMResolution): OSStatus;
FUNCTION PMGetPhysicalPaperSize(pageFormat: PMPageFormat; VAR paperSize: PMRect): OSStatus;
FUNCTION PMSetPhysicalPaperSize(pageFormat: PMPageFormat; {CONST}VAR paperSize: PMRect): OSStatus;
FUNCTION PMGetPhysicalPageSize(pageFormat: PMPageFormat; VAR pageSize: PMRect): OSStatus;
FUNCTION PMGetAdjustedPaperRect(pageFormat: PMPageFormat; VAR paperRect: PMRect): OSStatus;
FUNCTION PMGetAdjustedPageRect(pageFormat: PMPageFormat; VAR pageRect: PMRect): OSStatus;
FUNCTION PMGetOrientation(pageFormat: PMPageFormat; VAR orientation: PMOrientation): OSStatus;
FUNCTION PMSetOrientation(pageFormat: PMPageFormat; orientation: PMOrientation; lock: BOOLEAN): OSStatus;
{ PMPrintSettings }
FUNCTION PMNewPrintSettings(VAR printSettings: PMPrintSettings): OSStatus;
FUNCTION PMDisposePrintSettings(printSettings: PMPrintSettings): OSStatus;
FUNCTION PMDefaultPrintSettings(printSettings: PMPrintSettings): OSStatus;
FUNCTION PMValidatePrintSettings(printSettings: PMPrintSettings; VAR result: BOOLEAN): OSStatus;
FUNCTION PMCopyPrintSettings(settingSrc: PMPrintSettings; settingDest: PMPrintSettings): OSStatus;
FUNCTION PMFlattenPrintSettings(printSettings: PMPrintSettings; VAR flatSettings: Handle): OSStatus;
FUNCTION PMUnflattenPrintSettings(flatSettings: Handle; VAR printSettings: PMPrintSettings): OSStatus;
FUNCTION PMGetPrintSettingsExtendedData(printSettings: PMPrintSettings; dataID: OSType; VAR size: UInt32; theData: UNIV Ptr): OSStatus;
FUNCTION PMSetPrintSettingsExtendedData(printSettings: PMPrintSettings; dataID: OSType; size: UInt32; theData: UNIV Ptr): OSStatus;
{ PMPrintSettings Accessors }
FUNCTION PMGetJobName(printSettings: PMPrintSettings; name: StringPtr): OSStatus;
FUNCTION PMSetJobName(printSettings: PMPrintSettings; name: StringPtr): OSStatus;
FUNCTION PMGetCopies(printSettings: PMPrintSettings; VAR copies: UInt32): OSStatus;
FUNCTION PMSetCopies(printSettings: PMPrintSettings; copies: UInt32; lock: BOOLEAN): OSStatus;
FUNCTION PMGetFirstPage(printSettings: PMPrintSettings; VAR first: UInt32): OSStatus;
FUNCTION PMSetFirstPage(printSettings: PMPrintSettings; first: UInt32; lock: BOOLEAN): OSStatus;
FUNCTION PMGetLastPage(printSettings: PMPrintSettings; VAR last: UInt32): OSStatus;
FUNCTION PMSetLastPage(printSettings: PMPrintSettings; last: UInt32; lock: BOOLEAN): OSStatus;
FUNCTION PMGetPageRange(printSettings: PMPrintSettings; VAR minPage: UInt32; VAR maxPage: UInt32): OSStatus;
FUNCTION PMSetPageRange(printSettings: PMPrintSettings; minPage: UInt32; maxPage: UInt32): OSStatus;
FUNCTION PMSetProfile(printSettings: PMPrintSettings; tag: PMTag; {CONST}VAR profile: CMProfileLocation): OSStatus;
{ Printing Dialogs }
FUNCTION PMPageSetupDialog(pageFormat: PMPageFormat; VAR accepted: BOOLEAN): OSStatus;
FUNCTION PMPrintDialog(printSettings: PMPrintSettings; constPageFormat: PMPageFormat; VAR accepted: BOOLEAN): OSStatus;
FUNCTION PMPageSetupDialogInit(pageFormat: PMPageFormat; VAR newDialog: PMDialog): OSStatus;
FUNCTION PMPrintDialogInit(printSettings: PMPrintSettings; VAR newDialog: PMDialog): OSStatus;
FUNCTION PMPrintDialogMain(printSettings: PMPrintSettings; constPageFormat: PMPageFormat; VAR accepted: BOOLEAN; myInitProc: PMPrintDialogInitUPP): OSStatus;
FUNCTION PMPageSetupDialogMain(pageFormat: PMPageFormat; VAR accepted: BOOLEAN; myInitProc: PMPageSetupDialogInitUPP): OSStatus;
{ Printing Dialog accessors }
FUNCTION PMGetDialogPtr(pmDialog: PMDialog; VAR theDialog: DialogPtr): OSStatus;
FUNCTION PMGetModalFilterProc(pmDialog: PMDialog; VAR filterProc: ModalFilterUPP): OSStatus;
FUNCTION PMSetModalFilterProc(pmDialog: PMDialog; filterProc: ModalFilterUPP): OSStatus;
FUNCTION PMGetItemProc(pmDialog: PMDialog; VAR itemProc: PMItemUPP): OSStatus;
FUNCTION PMSetItemProc(pmDialog: PMDialog; itemProc: PMItemUPP): OSStatus;
FUNCTION PMGetDialogAccepted(pmDialog: PMDialog; VAR process: BOOLEAN): OSStatus;
FUNCTION PMSetDialogAccepted(pmDialog: PMDialog; process: BOOLEAN): OSStatus;
FUNCTION PMGetDialogDone(pmDialog: PMDialog; VAR done: BOOLEAN): OSStatus;
FUNCTION PMSetDialogDone(pmDialog: PMDialog; done: BOOLEAN): OSStatus;
{ Classic Support }
FUNCTION PMGeneral(pData: Ptr): OSStatus;
FUNCTION PMConvertOldPrintRecord(printRecordHandle: Handle; VAR printSettings: PMPrintSettings; VAR pageFormat: PMPageFormat): OSStatus;
FUNCTION PMMakeOldPrintRecord(printSettings: PMPrintSettings; pageFormat: PMPageFormat; VAR printRecordHandle: Handle): OSStatus;
{ Driver Information }
FUNCTION PMIsPostScriptDriver(VAR isPostScript: BOOLEAN): OSStatus;
FUNCTION PMGetLanguageInfo(VAR info: PMLanguageInfo): OSStatus;
FUNCTION PMGetDriverCreator(VAR creator: OSType): OSStatus;
FUNCTION PMGetDriverReleaseInfo(VAR release: VersRec): OSStatus;
FUNCTION PMGetPrinterResolutionCount(VAR count: UInt32): OSStatus;
FUNCTION PMGetPrinterResolution(tag: PMTag; VAR res: PMResolution): OSStatus;
FUNCTION PMGetIndexedPrinterResolution(index: UInt32; VAR res: PMResolution): OSStatus;
{ ColorSync & PostScript Support }
FUNCTION PMEnableColorSync: OSStatus;
FUNCTION PMDisableColorSync: OSStatus;
FUNCTION PMPostScriptBegin: OSStatus;
FUNCTION PMPostScriptEnd: OSStatus;
FUNCTION PMPostScriptHandle(psHandle: Handle): OSStatus;
FUNCTION PMPostScriptData(psPtr: Ptr; len: Size): OSStatus;
FUNCTION PMPostScriptFile(VAR psFile: FSSpec): OSStatus;
{ Error }
FUNCTION PMError: OSStatus;
FUNCTION PMSetError(printError: OSStatus): OSStatus;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PMApplicationIncludes}

{$ENDC} {__PMAPPLICATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
