{
 	File:		TranslationExtensions.p
 
 	Contains:	Macintosh Easy Open Translation Extension Interfaces.
 
 	Version:	Technology:	Macintosh Easy Open 1.1
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1989-1997, 1995, 1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT TranslationExtensions;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TRANSLATIONEXTENSIONS__}
{$SETC __TRANSLATIONEXTENSIONS__ := 1}

{$I+}
{$SETC TranslationExtensionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kSupportsFileTranslation	= 1;
	kSupportsScrapTranslation	= 2;
	kTranslatorCanGenerateFilename = 4;


{  better names for 4-char codes }

TYPE
	FileType							= OSType;
	ScrapType							= ResType;
	TranslationAttributes				= LONGINT;

CONST
	taDstDocNeedsResourceFork	= 1;
	taDstIsAppTranslation		= 2;



TYPE
	FileTypeSpecPtr = ^FileTypeSpec;
	FileTypeSpec = RECORD
		format:					FileType;
		hint:					LONGINT;
		flags:					TranslationAttributes;					{  taDstDocNeedsResourceFork, taDstIsAppTranslation }
		catInfoType:			OSType;
		catInfoCreator:			OSType;
	END;

	FileTranslationListPtr = ^FileTranslationList;
	FileTranslationList = RECORD
		modDate:				LONGINT;
		groupCount:				LONGINT;
																		{  	unsigned long	group1SrcCount; }
																		{  	unsigned long	group1SrcEntrySize = sizeof(FileTypeSpec); }
																		{   FileTypeSpec	group1SrcTypes[group1SrcCount] }
																		{   unsigned long	group1DstCount; }
																		{   unsigned long	group1DstEntrySize = sizeof(FileTypeSpec); }
																		{   FileTypeSpec	group1DstTypes[group1DstCount] }
	END;

	FileTranslationListHandle			= ^FileTranslationListPtr;

	ScrapTypeSpecPtr = ^ScrapTypeSpec;
	ScrapTypeSpec = RECORD
		format:					ScrapType;
		hint:					LONGINT;
	END;

	ScrapTranslationListPtr = ^ScrapTranslationList;
	ScrapTranslationList = RECORD
		modDate:				LONGINT;
		groupCount:				LONGINT;
																		{  	unsigned long		group1SrcCount; }
																		{  	unsigned long		group1SrcEntrySize = sizeof(ScrapTypeSpec); }
																		{   ScrapTypeSpec		group1SrcTypes[group1SrcCount] }
																		{   unsigned long		group1DstCount; }
																		{  	unsigned long		group1DstEntrySize = sizeof(ScrapTypeSpec); }
																		{   ScrapTypeSpec		group1DstTypes[group1DstCount] }
	END;

	ScrapTranslationListHandle			= ^ScrapTranslationListPtr;
{  definition of callbacks to update progress dialog }
	TranslationRefNum					= LONGINT;
{****************************************************************************************
*
* This routine sets the advertisement in the top half of the progress dialog.
* It is called once at the beginning of your DoTranslateFile routine.
*
* Enter:	refNum			Translation reference supplied to DoTranslateFile.
*			advertisement	A handle to the picture to display.  This must be non-purgable.
*							Before returning from DoTranslateFile, you should dispose
*							of the memory.  (Normally, it is in the temp translation heap
*							so it is cleaned up for you.)
*
* Exit:	returns			noErr, paramErr, or memFullErr
}
FUNCTION SetTranslationAdvertisement(refNum: TranslationRefNum; advertisement: PicHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $ABFC;
	{$ENDC}

{****************************************************************************************
*
* This routine updates the progress bar in the progress dialog.
* It is called repeatedly from within your DoTranslateFile routine.
* It should be called often, so that the user will get feedback if he tries to cancel.
*
* Enter:	refNum		translation reference supplied to DoTranslateFile.
*			progress	percent complete (0-100)
*
* Exit:		canceled	TRUE if the user clicked the Cancel button, FALSE otherwise
*			returns		noErr, paramErr, or memFullErr
}
FUNCTION UpdateTranslationProgress(refNum: TranslationRefNum; percentDone: INTEGER; VAR canceled: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $ABFC;
	{$ENDC}


{  ComponentMgr selectors for routines }

CONST
	kTranslateGetFileTranslationList = 0;						{  component selectors }
	kTranslateIdentifyFile		= 1;
	kTranslateTranslateFile		= 2;
	kTranslateGetTranslatedFilename = 3;
	kTranslateGetScrapTranslationList = 10;						{  skip to scrap routines }
	kTranslateIdentifyScrap		= 11;
	kTranslateTranslateScrap	= 12;


{  Routines to implment in a file translation extension }



TYPE
	DoGetFileTranslationListProcPtr = ProcPtr;  { FUNCTION DoGetFileTranslationList(self: ComponentInstance; translationList: FileTranslationListHandle): ComponentResult; }

	DoIdentifyFileProcPtr = ProcPtr;  { FUNCTION DoIdentifyFile(self: ComponentInstance; (CONST)VAR theDocument: FSSpec; VAR docType: FileType): ComponentResult; }

	DoTranslateFileProcPtr = ProcPtr;  { FUNCTION DoTranslateFile(self: ComponentInstance; refNum: TranslationRefNum; (CONST)VAR sourceDocument: FSSpec; srcType: FileType; srcTypeHint: LONGINT; (CONST)VAR dstDoc: FSSpec; dstType: FileType; dstTypeHint: LONGINT): ComponentResult; }

	DoGetTranslatedFilenameProcPtr = ProcPtr;  { FUNCTION DoGetTranslatedFilename(self: ComponentInstance; dstType: FileType; dstTypeHint: LONGINT; VAR theDocument: FSSpec): ComponentResult; }


{  Routine to implement in a scrap translation extension }

	DoGetScrapTranslationListProcPtr = ProcPtr;  { FUNCTION DoGetScrapTranslationList(self: ComponentInstance; list: ScrapTranslationListHandle): ComponentResult; }

	DoIdentifyScrapProcPtr = ProcPtr;  { FUNCTION DoIdentifyScrap(self: ComponentInstance; dataPtr: UNIV Ptr; dataLength: Size; VAR dataFormat: ScrapType): ComponentResult; }

	DoTranslateScrapProcPtr = ProcPtr;  { FUNCTION DoTranslateScrap(self: ComponentInstance; refNum: TranslationRefNum; srcDataPtr: UNIV Ptr; srcDataLength: Size; srcType: ScrapType; srcTypeHint: LONGINT; dstData: Handle; dstType: ScrapType; dstTypeHint: LONGINT): ComponentResult; }




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TranslationExtensionsIncludes}

{$ENDC} {__TRANSLATIONEXTENSIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
