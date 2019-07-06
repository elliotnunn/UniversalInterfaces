{
 	File:		GXPrinting.p
 
 	Contains:	This file contains all printing APIs except for driver/extension specific ones.
 
 	Version:	Technology:	Quickdraw GX 1.1
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1994-1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT GXPrinting;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GXPRINTING__}
{$SETC __GXPRINTING__ := 1}

{$I+}
{$SETC GXPrintingIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __COLLECTIONS__}
{$I Collections.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __GXFONTS__}
{$I GXFonts.p}
{$ENDC}
{$IFC UNDEFINED __GXMATH__}
{$I GXMath.p}
{$ENDC}
{$IFC UNDEFINED __GXTYPES__}
{$I GXTypes.p}
{$ENDC}
{$IFC UNDEFINED __LISTS__}
{$I Lists.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __GXMESSAGES__}
{$I GXMessages.p}
{$ENDC}
{$IFC UNDEFINED __PRINTING__}
{$I Printing.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{*******************************************************************
					Start of old "GXPrintingManager.h/a/p" interface file.
			********************************************************************}
{ ------------------------------------------------------------------------------

							Printing Manager API Contants and Types

-------------------------------------------------------------------------------- }


TYPE
	gxOwnerSignature					= UInt32;
{$IFC OLDROUTINENAMES }
	Signature							= UInt32;
{$ENDC}  {OLDROUTINENAMES}

{

	ABSTRACT DATA TYPES

}
{
   typedef struct gxPrivatePrinterRecord *gxPrinter;
   typedef struct gxPrivateJobRecord *gxJob;
   typedef struct gxPrivateFormatRecord *gxFormat;
   typedef struct gxPrivatePaperTypeRecord *gxPaperType;
   typedef struct gxPrivatePrintFileRecord *gxPrintFile;
}

	gxPrinter = ^LONGINT; { an opaque 32-bit type }
	gxJob = ^LONGINT; { an opaque 32-bit type }
	gxFormat = ^LONGINT; { an opaque 32-bit type }
	gxPaperType = ^LONGINT; { an opaque 32-bit type }
	gxPrintFile = ^LONGINT; { an opaque 32-bit type }
{ Possible values for LoopStatus }
	gxLoopStatus						= BOOLEAN;

CONST
	gxStopLooping				= false;
	gxKeepLooping				= true;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	GXViewDeviceProcPtr = FUNCTION(aViewDevice: gxViewDevice; refCon: UNIV Ptr): ByteParameter;
{$ELSEC}
	GXViewDeviceProcPtr = ProcPtr;
{$ENDC}

	GXViewDeviceUPP = UniversalProcPtr;

CONST
	uppGXViewDeviceProcInfo = $000003D0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewGXViewDeviceUPP(userRoutine: GXViewDeviceProcPtr): GXViewDeviceUPP; { old name was NewGXViewDeviceProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeGXViewDeviceUPP(userUPP: GXViewDeviceUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeGXViewDeviceUPP(aViewDevice: gxViewDevice; refCon: UNIV Ptr; userRoutine: GXViewDeviceUPP): ByteParameter; { old name was CallGXViewDeviceProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	GXFormatProcPtr = FUNCTION(aFormat: gxFormat; refCon: UNIV Ptr): ByteParameter;
{$ELSEC}
	GXFormatProcPtr = ProcPtr;
{$ENDC}

	GXFormatUPP = UniversalProcPtr;

CONST
	uppGXFormatProcInfo = $000003D0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewGXFormatUPP(userRoutine: GXFormatProcPtr): GXFormatUPP; { old name was NewGXFormatProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeGXFormatUPP(userUPP: GXFormatUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeGXFormatUPP(aFormat: gxFormat; refCon: UNIV Ptr; userRoutine: GXFormatUPP): ByteParameter; { old name was CallGXFormatProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	GXPaperTypeProcPtr = FUNCTION(aPapertype: gxPaperType; refCon: UNIV Ptr): ByteParameter;
{$ELSEC}
	GXPaperTypeProcPtr = ProcPtr;
{$ENDC}

	GXPaperTypeUPP = UniversalProcPtr;

CONST
	uppGXPaperTypeProcInfo = $000003D0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewGXPaperTypeUPP(userRoutine: GXPaperTypeProcPtr): GXPaperTypeUPP; { old name was NewGXPaperTypeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeGXPaperTypeUPP(userUPP: GXPaperTypeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeGXPaperTypeUPP(aPapertype: gxPaperType; refCon: UNIV Ptr; userRoutine: GXPaperTypeUPP): ByteParameter; { old name was CallGXPaperTypeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	GXPrintingFlattenProcPtr = FUNCTION(size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr): OSErr;
{$ELSEC}
	GXPrintingFlattenProcPtr = ProcPtr;
{$ENDC}

	GXPrintingFlattenUPP = UniversalProcPtr;

CONST
	uppGXPrintingFlattenProcInfo = $00000FE0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewGXPrintingFlattenUPP(userRoutine: GXPrintingFlattenProcPtr): GXPrintingFlattenUPP; { old name was NewGXPrintingFlattenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeGXPrintingFlattenUPP(userUPP: GXPrintingFlattenUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeGXPrintingFlattenUPP(size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr; userRoutine: GXPrintingFlattenUPP): OSErr; { old name was CallGXPrintingFlattenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC OLDROUTINENAMES }

TYPE
	gxViewDeviceProc					= GXViewDeviceProcPtr;
	gxFormatProc						= GXFormatProcPtr;
	gxPaperTypeProc						= GXPaperTypeProcPtr;
	gxPrintingFlattenProc				= GXPrintingFlattenProcPtr;
{$ENDC}  {OLDROUTINENAMES}

{
	The following constants are used to set collection item flags in printing
	collections. The Printing Manager purges certain items whenever a driver
	switch occurs. If the formatting driver changes, all items marked as
	gxVolatileFormattingDriverCategory will be purged.  If the output driver
	changes, all items marked as gxVolatileOutputDriverCategory will be purged.
	Note that to prevent items from being flattened when GXFlattenJob is called,
	you should unset the collectionPersistenceBit (defined in Collections.h),
	which is on by default.
}
{ Structure stored in collection items' user attribute bits }

TYPE
	gxCollectionCategory				= INTEGER;

CONST
	gxNoCollectionCategory		= $0000;
	gxOutputDriverCategory		= $0001;
	gxFormattingDriverCategory	= $0002;
	gxDriverVolatileCategory	= $0004;
	gxVolatileOutputDriverCategory = $0005;
	gxVolatileFormattingDriverCategory = $0006;


{

	>>>>>> JOB COLLECTION ITEMS <<<<<<

}

{ gxJobInfo COLLECTION ITEM }
	gxJobTag					= 'job ';


TYPE
	gxJobInfoPtr = ^gxJobInfo;
	gxJobInfo = RECORD
		numPages:				LONGINT;								{  Number of pages in the document  }
		priority:				LONGINT;								{  Priority of this job plus "is it on hold?"  }
		timeToPrint:			UInt32;									{  When to print job, if scheduled  }
		jobTimeout:				LONGINT;								{  Timeout value, in ticks  }
		firstPageToPrint:		LONGINT;								{  Start printing from this page  }
		jobAlert:				INTEGER;								{  How to alert user when printing  }
		appName:				Str31;									{  Which application printed the document  }
		documentName:			Str31;									{  The name of the document being printed  }
		userName:				Str31;									{  The owner name of the machine that printed the document  }
	END;

{ gxPDDDefaultSettingTag COLLECTION ITEM }

CONST
	gxPDDDefaultSettingTag		= 'pdds';


TYPE
	gxPDDDefaultSettingInfoPtr = ^gxPDDDefaultSettingInfo;
	gxPDDDefaultSettingInfo = RECORD
		useDefaultSetting:		BOOLEAN;								{  true if PDD default setting should be used  }
		pad:					SInt8;
	END;

{ priority field constants }

CONST
	gxPrintJobHoldingBit		= $00001000;					{  This bit is set if the job is on hold.  }

	gxPrintJobUrgent			= $00000001;
	gxPrintJobAtTime			= $00000002;
	gxPrintJobASAP				= $00000003;
	gxPrintJobHolding			= $00001003;
	gxPrintJobHoldingAtTime		= $00001002;
	gxPrintJobHoldingUrgent		= $00001001;

{ jobAlert field constants }
	gxNoPrintTimeAlert			= 0;							{  Don't alert user when we print  }
	gxAlertBefore				= 1;							{  Alert user before we print  }
	gxAlertAfter				= 2;							{  Alert user after we print  }
	gxAlertBothTimes			= 3;							{  Alert before and after we print  }

{ jobTimeout field constants }
	gxThirtySeconds				= 1800;							{  30 seconds in ticks  }
	gxTwoMinutes				= 7200;							{  2 minutes in ticks  }


{ gxCollationTag COLLECTION ITEM }
	gxCollationTag				= 'sort';


TYPE
	gxCollationInfoPtr = ^gxCollationInfo;
	gxCollationInfo = RECORD
		collation:				BOOLEAN;								{  True if copies are to be collated  }
		padByte:				SInt8;
	END;


{ gxCopiesTag COLLECTION ITEM }

CONST
	gxCopiesTag					= 'copy';


TYPE
	gxCopiesInfoPtr = ^gxCopiesInfo;
	gxCopiesInfo = RECORD
		copies:					LONGINT;								{  Number of copies of the document to print  }
	END;


{ gxPageRangeTag COLLECTION ITEM }

CONST
	gxPageRangeTag				= 'rang';


TYPE
	gxSimplePageRangeInfoPtr = ^gxSimplePageRangeInfo;
	gxSimplePageRangeInfo = RECORD
		optionChosen:			SInt8;									{  From options listed below  }
		printAll:				BOOLEAN;								{  True if user wants to print all pages  }
		fromPage:				LONGINT;								{  For gxDefaultPageRange, current value  }
		toPage:					LONGINT;								{  For gxDefaultPageRange, current value  }
	END;

	gxPageRangeInfoPtr = ^gxPageRangeInfo;
	gxPageRangeInfo = RECORD
		simpleRange:			gxSimplePageRangeInfo;					{  Info which will be returned for GetJobPageRange  }
		fromString:				Str31;									{  For gxCustomizePageRange, current value  }
		toString:				Str31;									{  For gxCustomizePageRange, current value  }
		minFromPage:			LONGINT;								{  For gxDefaultPageRange, we parse with this, ignored if nil  }
		maxToPage:				LONGINT;								{  For gxDefaultPageRange, we parse with this, ignored if nil  }
		replaceString:			SInt8;									{  For gxReplacePageRange, string to display  }
	END;


{ optionChosen field constants for SimplePageRangeInfo }

CONST
	gxDefaultPageRange			= 0;
	gxReplacePageRange			= 1;
	gxCustomizePageRange		= 2;


{ gxQualityTag COLLECTION ITEM }
	gxQualityTag				= 'qual';


TYPE
	gxQualityInfoPtr = ^gxQualityInfo;
	gxQualityInfo = RECORD
		disableQuality:			BOOLEAN;								{  True to disable standard quality controls  }
		padByte:				SInt8;
		defaultQuality:			INTEGER;								{  The default quality value  }
		currentQuality:			INTEGER;								{  The current quality value  }
		qualityCount:			INTEGER;								{  The number of quality menu items in popup menu  }
		qualityNames:			SInt8;									{  An array of packed pascal strings for popup menu titles  }
	END;


{ gxFileDestinationTag COLLECTION ITEM }

CONST
	gxFileDestinationTag		= 'dest';


TYPE
	gxFileDestinationInfoPtr = ^gxFileDestinationInfo;
	gxFileDestinationInfo = RECORD
		toFile:					BOOLEAN;								{  True if destination is a file  }
		padByte:				SInt8;
	END;


{ gxFileLocationTag COLLECTION ITEM }

CONST
	gxFileLocationTag			= 'floc';


TYPE
	gxFileLocationInfoPtr = ^gxFileLocationInfo;
	gxFileLocationInfo = RECORD
		fileSpec:				FSSpec;									{  Location to put file, if destination is file  }
	END;


{ gxFileFormatTag COLLECTION ITEM }

CONST
	gxFileFormatTag				= 'ffmt';


TYPE
	gxFileFormatInfoPtr = ^gxFileFormatInfo;
	gxFileFormatInfo = RECORD
		fileFormatName:			Str31;									{  Name of file format (e.g. "PostScript") if destination is file  }
	END;


{ gxFileFontsTag COLLECTION ITEM }

CONST
	gxFileFontsTag				= 'incf';


TYPE
	gxFileFontsInfoPtr = ^gxFileFontsInfo;
	gxFileFontsInfo = RECORD
		includeFonts:			SInt8;									{  Which fonts to include, if destination is file  }
		padByte:				SInt8;
	END;

{ includeFonts field constants }

CONST
	gxIncludeNoFonts			= 1;							{  Include no fonts  }
	gxIncludeAllFonts			= 2;							{  Include all fonts  }
	gxIncludeNonStandardFonts	= 3;							{  Include only fonts that aren't in the standard LW set  }


{ gxPaperFeedTag COLLECTION ITEM }
	gxPaperFeedTag				= 'feed';


TYPE
	gxPaperFeedInfoPtr = ^gxPaperFeedInfo;
	gxPaperFeedInfo = RECORD
		autoFeed:				BOOLEAN;								{  True if automatic feed, false if manual  }
		padByte:				SInt8;
	END;


{ gxTrayFeedTag COLLECTION ITEM }

CONST
	gxTrayFeedTag				= 'tray';


TYPE
	gxTrayIndex							= LONGINT;
	gxTrayFeedInfoPtr = ^gxTrayFeedInfo;
	gxTrayFeedInfo = RECORD
		feedTrayIndex:			gxTrayIndex;							{  Tray to feed paper from  }
		manualFeedThisPage:		BOOLEAN;								{  Signals manual feeding for the page  }
		padByte:				SInt8;
	END;


{ gxManualFeedTag COLLECTION ITEM }

CONST
	gxManualFeedTag				= 'manf';


TYPE
	gxManualFeedInfoPtr = ^gxManualFeedInfo;
	gxManualFeedInfo = RECORD
		numPaperTypeNames:		LONGINT;								{  Number of paperTypes to manually feed  }
		paperTypeNames:			ARRAY [0..0] OF Str31;					{  Array of names of paperTypes to manually feed  }
	END;


{ gxNormalMappingTag COLLECTION ITEM }

CONST
	gxNormalMappingTag			= 'nmap';


TYPE
	gxNormalMappingInfoPtr = ^gxNormalMappingInfo;
	gxNormalMappingInfo = RECORD
		normalPaperMapping:		BOOLEAN;								{  True if not overriding normal paper mapping  }
		padByte:				SInt8;
	END;


{ gxSpecialMappingTag COLLECTION ITEM }

CONST
	gxSpecialMappingTag			= 'smap';


TYPE
	gxSpecialMappingInfoPtr = ^gxSpecialMappingInfo;
	gxSpecialMappingInfo = RECORD
		specialMapping:			SInt8;									{  Enumerated redirect, scale or tile setting  }
		padByte:				SInt8;
	END;

{ specialMapping field constants }

CONST
	gxRedirectPages				= 1;							{  Redirect pages to a papertype and clip if necessary  }
	gxScalePages				= 2;							{  Scale pages if necessary  }
	gxTilePages					= 3;							{  Tile pages if necessary  }


{ gxTrayMappingTag COLLECTION ITEM }
	gxTrayMappingTag			= 'tmap';


TYPE
	gxTrayMappingInfoPtr = ^gxTrayMappingInfo;
	gxTrayMappingInfo = RECORD
		mapPaperToTray:			gxTrayIndex;							{  Tray to map all paper to  }
	END;


{ gxPaperMappingTag COLLECTION ITEM }
{ This collection item contains a flattened paper type resource }

CONST
	gxPaperMappingTag			= 'pmap';


{ gxPrintPanelTag COLLECTION ITEM }
	gxPrintPanelTag				= 'ppan';


TYPE
	gxPrintPanelInfoPtr = ^gxPrintPanelInfo;
	gxPrintPanelInfo = RECORD
		startPanelName:			Str31;									{  Name of starting panel in Print dialog  }
	END;


{ gxFormatPanelTag COLLECTION ITEM }

CONST
	gxFormatPanelTag			= 'fpan';


TYPE
	gxFormatPanelInfoPtr = ^gxFormatPanelInfo;
	gxFormatPanelInfo = RECORD
		startPanelName:			Str31;									{  Name of starting panel in Format dialog  }
	END;


{ gxTranslatedDocumentTag COLLECTION ITEM }

CONST
	gxTranslatedDocumentTag		= 'trns';


TYPE
	gxTranslatedDocumentInfoPtr = ^gxTranslatedDocumentInfo;
	gxTranslatedDocumentInfo = RECORD
		translatorInfo:			LONGINT;								{  Information from the translation process  }
	END;


{ gxCoverPageTag COLLECTION ITEM }

CONST
	gxCoverPageTag				= 'cvpg';



TYPE
	gxCoverPageInfoPtr = ^gxCoverPageInfo;
	gxCoverPageInfo = RECORD
		coverPage:				LONGINT;								{  Use same enum values as for PrintRecord field in GXPrinterDrivers.h  }
	END;

{

	>>>>>> FORMAT COLLECTION ITEMS <<<<<<

}
{ gxPaperTypeLockTag COLLECTION ITEM }

CONST
	gxPaperTypeLockTag			= 'ptlk';


TYPE
	gxPaperTypeLockInfoPtr = ^gxPaperTypeLockInfo;
	gxPaperTypeLockInfo = RECORD
		paperTypeLocked:		BOOLEAN;								{  True if format's paperType is locked  }
		padByte:				SInt8;
	END;


{ gxOrientationTag COLLECTION ITEM }

CONST
	gxOrientationTag			= 'layo';


TYPE
	gxOrientationInfoPtr = ^gxOrientationInfo;
	gxOrientationInfo = RECORD
		orientation:			SInt8;									{  An enumerated orientation value  }
		padByte:				SInt8;
	END;

{ orientation field constants }

CONST
	gxPortraitLayout			= 0;							{  Portrait  }
	gxLandscapeLayout			= 1;							{  Landscape  }
	gxRotatedPortraitLayout		= 2;							{  Portrait, rotated 180°  }
	gxRotatedLandscapeLayout	= 3;							{  Landscape, rotated 180°   }


{ gxScalingTag COLLECTION ITEM }
	gxScalingTag				= 'scal';


TYPE
	gxScalingInfoPtr = ^gxScalingInfo;
	gxScalingInfo = RECORD
		horizontalScaleFactor:	Fixed;									{  Current horizontal scaling factor  }
		verticalScaleFactor:	Fixed;									{  Current vertical scaling factor  }
		minScaling:				INTEGER;								{  Minimum scaling allowed  }
		maxScaling:				INTEGER;								{  Maximum scaling allowed  }
	END;


{ gxDirectModeTag COLLECTION ITEM }

CONST
	gxDirectModeTag				= 'dirm';


TYPE
	gxDirectModeInfoPtr = ^gxDirectModeInfo;
	gxDirectModeInfo = RECORD
		directModeOn:			BOOLEAN;								{  True if a direct mode is enabled  }
		padByte:				SInt8;
	END;


{ gxFormatHalftoneTag COLLECTION ITEM }

CONST
	gxFormatHalftoneTag			= 'half';


TYPE
	gxFormatHalftoneInfoPtr = ^gxFormatHalftoneInfo;
	gxFormatHalftoneInfo = RECORD
		numHalftones:			LONGINT;								{  Number of halftone records  }
		halftones:				ARRAY [0..0] OF gxHalftone;				{  The halftone records  }
	END;


{ gxInvertPageTag COLLECTION ITEM }

CONST
	gxInvertPageTag				= 'invp';


TYPE
	gxInvertPageInfoPtr = ^gxInvertPageInfo;
	gxInvertPageInfo = RECORD
		padByte:				SInt8;
		invert:					BOOLEAN;								{  If true, invert page  }
	END;


{ gxFlipPageHorizontalTag COLLECTION ITEM }

CONST
	gxFlipPageHorizontalTag		= 'flph';


TYPE
	gxFlipPageHorizontalInfoPtr = ^gxFlipPageHorizontalInfo;
	gxFlipPageHorizontalInfo = RECORD
		padByte:				SInt8;
		flipHorizontal:			BOOLEAN;								{  If true, flip x coordinates on page  }
	END;


{ gxFlipPageVerticalTag COLLECTION ITEM }

CONST
	gxFlipPageVerticalTag		= 'flpv';


TYPE
	gxFlipPageVerticalInfoPtr = ^gxFlipPageVerticalInfo;
	gxFlipPageVerticalInfo = RECORD
		padByte:				SInt8;
		flipVertical:			BOOLEAN;								{  If true, flip y coordinates on page  }
	END;


{ gxPreciseBitmapsTag COLLECTION ITEM }

CONST
	gxPreciseBitmapsTag			= 'pbmp';


TYPE
	gxPreciseBitmapInfoPtr = ^gxPreciseBitmapInfo;
	gxPreciseBitmapInfo = RECORD
		preciseBitmaps:			BOOLEAN;								{  If true, scale page by 96%  }
		padByte:				SInt8;
	END;


{

	>>>>>> PAPERTYPE COLLECTION ITEMS <<<<<<

}
{ gxBaseTag COLLECTION ITEM }

CONST
	gxBaseTag					= 'base';


TYPE
	gxBaseInfoPtr = ^gxBaseInfo;
	gxBaseInfo = RECORD
		baseType:				LONGINT;								{  PaperType's base type  }
	END;

{ baseType field constants }

CONST
	gxUnknownBase				= 0;							{  Base paper type from which this paper type is  }
	gxUSLetterBase				= 1;							{  derived.  This is not a complete set.  }
	gxUSLegalBase				= 2;
	gxA4LetterBase				= 3;
	gxB5LetterBase				= 4;
	gxTabloidBase				= 5;


{ gxCreatorTag COLLECTION ITEM }
	gxCreatorTag				= 'crea';


TYPE
	gxCreatorInfoPtr = ^gxCreatorInfo;
	gxCreatorInfo = RECORD
		creator:				OSType;									{  PaperType's creator  }
	END;

{ gxUnitsTag COLLECTION ITEM }

CONST
	gxUnitsTag					= 'unit';


TYPE
	gxUnitsInfoPtr = ^gxUnitsInfo;
	gxUnitsInfo = RECORD
		units:					SInt8;									{  PaperType's units (used by PaperType Editor).  }
		padByte:				SInt8;
	END;

{ units field constants }

CONST
	gxPicas						= 0;							{  Pica measurement  }
	gxMMs						= 1;							{  Millimeter measurement  }
	gxInches					= 2;							{  Inches measurement  }


{ gxFlagsTag COLLECTION ITEM }
	gxFlagsTag					= 'flag';


TYPE
	gxFlagsInfoPtr = ^gxFlagsInfo;
	gxFlagsInfo = RECORD
		flags:					LONGINT;								{  PaperType's flags  }
	END;

{ flags field constants }

CONST
	gxOldPaperTypeFlag			= $00800000;					{  Indicates a paper type for compatibility printing  }
	gxNewPaperTypeFlag			= $00400000;					{  Indicates a paper type for QuickDraw GX-aware printing  }
	gxOldAndNewFlag				= $00C00000;					{  Indicates a paper type that's both old and new  }
	gxDefaultPaperTypeFlag		= $00100000;					{  Indicates the default paper type in the group  }


{ gxCommentTag COLLECTION ITEM }
	gxCommentTag				= 'cmnt';


TYPE
	gxCommentInfoPtr = ^gxCommentInfo;
	gxCommentInfo = RECORD
		comment:				Str255;									{  PaperType's comment  }
	END;


{

	>>>>>> PRINTER VIEWDEVICE TAGS <<<<<<

}
{ gxPenTableTag COLLECTION ITEM }

CONST
	gxPenTableTag				= 'pent';


TYPE
	gxPenTableEntryPtr = ^gxPenTableEntry;
	gxPenTableEntry = RECORD
		penName:				Str31;									{  Name of the pen  }
		penColor:				gxColor;								{  Color to use from the color set  }
		penThickness:			Fixed;									{  Size of the pen  }
		penUnits:				INTEGER;								{  Specifies units in which pen thickness is defined  }
		penPosition:			INTEGER;								{  Pen position in the carousel, -1 (kPenNotLoaded) if not loaded  }
	END;

	gxPenTablePtr = ^gxPenTable;
	gxPenTable = RECORD
		numPens:				LONGINT;								{  Number of pen entries in the following array  }
		pens:					ARRAY [0..0] OF gxPenTableEntry;		{  Array of pen entries  }
	END;

	gxPenTableHdl						= ^gxPenTablePtr;
{ penUnits field constants }

CONST
	gxDeviceUnits				= 0;
	gxMMUnits					= 1;
	gxInchesUnits				= 2;

{ penPosition field constants }
	gxPenNotLoaded				= -1;


{

	>>>>>> DIALOG-RELATED CONSTANTS AND TYPES <<<<<<

}

TYPE
	gxDialogResult						= LONGINT;

CONST
	gxCancelSelected			= 0;
	gxOKSelected				= 1;
	gxRevertSelected			= 2;



TYPE
	gxEditMenuRecordPtr = ^gxEditMenuRecord;
	gxEditMenuRecord = RECORD
		editMenuID:				INTEGER;
		cutItem:				INTEGER;
		copyItem:				INTEGER;
		pasteItem:				INTEGER;
		clearItem:				INTEGER;
		undoItem:				INTEGER;
	END;


{

	>>>>>> JOB FORMAT MODE CONSTANTS AND TYPES <<<<<<

}
	gxJobFormatMode						= OSType;
	gxJobFormatModeTablePtr = ^gxJobFormatModeTable;
	gxJobFormatModeTable = RECORD
		numModes:				LONGINT;								{  Number of job format modes to choose from  }
		modes:					ARRAY [0..0] OF gxJobFormatMode;		{  The job format modes  }
	END;

	gxJobFormatModeTableHdl				= ^gxJobFormatModeTablePtr;

CONST
	gxGraphicsJobFormatMode		= 'grph';
	gxTextJobFormatMode			= 'text';
	gxPostScriptJobFormatMode	= 'post';


TYPE
	gxQueryType							= LONGINT;

CONST
	gxGetJobFormatLineConstraintQuery = 0;
	gxGetJobFormatFontsQuery	= 1;
	gxGetJobFormatFontCommonStylesQuery = 2;
	gxGetJobFormatFontConstraintQuery = 3;
	gxSetStyleJobFormatCommonStyleQuery = 4;


{ Structures used for Text mode field constants }

TYPE
	gxPositionConstraintTablePtr = ^gxPositionConstraintTable;
	gxPositionConstraintTable = RECORD
		phase:					gxPoint;								{  Position phase  }
		offset:					gxPoint;								{  Position offset  }
		numSizes:				LONGINT;								{  Number of available font sizes  }
		sizes:					ARRAY [0..0] OF Fixed;					{  The available font sizes  }
	END;

	gxPositionConstraintTableHdl		= ^gxPositionConstraintTablePtr;
{ numSizes field constants }

CONST
	gxConstraintRange			= -1;


TYPE
	gxStyleNameTablePtr = ^gxStyleNameTable;
	gxStyleNameTable = RECORD
		numStyleNames:			LONGINT;								{  Number of style names  }
		styleNames:				ARRAY [0..0] OF Str255;					{  The style names  }
	END;

	gxStyleNameTableHdl					= ^gxStyleNameTablePtr;
	gxFontTablePtr = ^gxFontTable;
	gxFontTable = RECORD
		numFonts:				LONGINT;								{  Number of font references  }
		fonts:					ARRAY [0..0] OF gxFont;					{  The font references  }
	END;

	gxFontTableHdl						= ^gxFontTablePtr;
{ ------------------------------------------------------------------------------

								Printing Manager API Functions

-------------------------------------------------------------------------------- }
{
	Global Routines
}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION GXInitPrinting: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0000, $ABFE;
	{$ENDC}
FUNCTION GXExitPrinting: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0001, $ABFE;
	{$ENDC}

{
	Error-Handling Routines
}
FUNCTION GXGetJobError(aJob: gxJob): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $000E, $ABFE;
	{$ENDC}
PROCEDURE GXSetJobError(aJob: gxJob; anErr: OSErr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $000F, $ABFE;
	{$ENDC}

{
	Job Routines
}
FUNCTION GXNewJob(VAR aJob: gxJob): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0002, $ABFE;
	{$ENDC}
FUNCTION GXDisposeJob(aJob: gxJob): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0003, $ABFE;
	{$ENDC}
PROCEDURE GXFlattenJob(aJob: gxJob; flattenProc: GXPrintingFlattenUPP; aVoid: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0004, $ABFE;
	{$ENDC}
FUNCTION GXUnflattenJob(aJob: gxJob; flattenProc: GXPrintingFlattenUPP; aVoid: UNIV Ptr): gxJob;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0005, $ABFE;
	{$ENDC}
FUNCTION GXFlattenJobToHdl(aJob: gxJob; aHdl: Handle): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0006, $ABFE;
	{$ENDC}
FUNCTION GXUnflattenJobFromHdl(aJob: gxJob; aHdl: Handle): gxJob;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0007, $ABFE;
	{$ENDC}
PROCEDURE GXInstallApplicationOverride(aJob: gxJob; messageID: INTEGER; override: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0008, $ABFE;
	{$ENDC}
FUNCTION GXGetJobCollection(aJob: gxJob): Collection;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $001D, $ABFE;
	{$ENDC}
FUNCTION GXGetJobRefCon(aJob: gxJob): Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $001E, $ABFE;
	{$ENDC}
PROCEDURE GXSetJobRefCon(aJob: gxJob; refCon: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $001F, $ABFE;
	{$ENDC}
FUNCTION GXCopyJob(srcJob: gxJob; dstJob: gxJob): gxJob;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0020, $ABFE;
	{$ENDC}
PROCEDURE GXSelectJobFormattingPrinter(aJob: gxJob; VAR printerName: Str31);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0021, $ABFE;
	{$ENDC}
PROCEDURE GXSelectJobOutputPrinter(aJob: gxJob; VAR printerName: Str31);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0022, $ABFE;
	{$ENDC}
PROCEDURE GXForEachJobFormatDo(aJob: gxJob; formatProc: GXFormatUPP; refCon: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0023, $ABFE;
	{$ENDC}
FUNCTION GXCountJobFormats(aJob: gxJob): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0024, $ABFE;
	{$ENDC}
FUNCTION GXUpdateJob(aJob: gxJob): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0025, $ABFE;
	{$ENDC}
PROCEDURE GXConvertPrintRecord(aJob: gxJob; hPrint: THPrint);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0026, $ABFE;
	{$ENDC}
PROCEDURE GXIdleJob(aJob: gxJob);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0057, $ABFE;
	{$ENDC}

{
	Job Format Modes Routines
}
PROCEDURE GXSetAvailableJobFormatModes(aJob: gxJob; formatModeTable: gxJobFormatModeTableHdl);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $003B, $ABFE;
	{$ENDC}
FUNCTION GXGetPreferredJobFormatMode(aJob: gxJob; VAR directOnly: BOOLEAN): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $003C, $ABFE;
	{$ENDC}
FUNCTION GXGetJobFormatMode(aJob: gxJob): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $003D, $ABFE;
	{$ENDC}
PROCEDURE GXSetJobFormatMode(aJob: gxJob; formatMode: gxJobFormatMode);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $003E, $ABFE;
	{$ENDC}
PROCEDURE GXJobFormatModeQuery(aJob: gxJob; aQueryType: gxQueryType; srcData: UNIV Ptr; dstData: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $003F, $ABFE;
	{$ENDC}

{
	Format Routines
}
FUNCTION GXNewFormat(aJob: gxJob): gxFormat;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0009, $ABFE;
	{$ENDC}
PROCEDURE GXDisposeFormat(aFormat: gxFormat);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $000A, $ABFE;
	{$ENDC}
FUNCTION GXGetJobFormat(aJob: gxJob; whichFormat: LONGINT): gxFormat;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0013, $ABFE;
	{$ENDC}
FUNCTION GXGetFormatJob(aFormat: gxFormat): gxJob;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0014, $ABFE;
	{$ENDC}
FUNCTION GXGetFormatPaperType(aFormat: gxFormat): gxPaperType;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0015, $ABFE;
	{$ENDC}
PROCEDURE GXGetFormatDimensions(aFormat: gxFormat; VAR pageSize: gxRectangle; VAR paperSize: gxRectangle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0016, $ABFE;
	{$ENDC}
FUNCTION GXGetFormatCollection(aFormat: gxFormat): Collection;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0033, $ABFE;
	{$ENDC}
PROCEDURE GXChangedFormat(aFormat: gxFormat);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0034, $ABFE;
	{$ENDC}
FUNCTION GXCopyFormat(srcFormat: gxFormat; dstFormat: gxFormat): gxFormat;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0035, $ABFE;
	{$ENDC}
FUNCTION GXCloneFormat(aFormat: gxFormat): gxFormat;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0036, $ABFE;
	{$ENDC}
FUNCTION GXCountFormatOwners(aFormat: gxFormat): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0037, $ABFE;
	{$ENDC}
PROCEDURE GXGetFormatMapping(aFormat: gxFormat; VAR fmtMapping: gxMapping);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0038, $ABFE;
	{$ENDC}
FUNCTION GXGetFormatForm(aFormat: gxFormat; VAR mask: gxShape): gxShape;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0039, $ABFE;
	{$ENDC}
PROCEDURE GXSetFormatForm(aFormat: gxFormat; form: gxShape; mask: gxShape);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $003A, $ABFE;
	{$ENDC}

{
	PaperType Routines
}
FUNCTION GXNewPaperType(aJob: gxJob; VAR name: Str31; VAR pageSize: gxRectangle; VAR paperSize: gxRectangle): gxPaperType;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $000B, $ABFE;
	{$ENDC}
PROCEDURE GXDisposePaperType(aPaperType: gxPaperType);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $000C, $ABFE;
	{$ENDC}
FUNCTION GXGetNewPaperType(aJob: gxJob; resID: INTEGER): gxPaperType;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $000D, $ABFE;
	{$ENDC}
FUNCTION GXCountJobPaperTypes(aJob: gxJob; forFormatDevice: BOOLEAN): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0042, $ABFE;
	{$ENDC}
FUNCTION GXGetJobPaperType(aJob: gxJob; whichPaperType: LONGINT; forFormatDevice: BOOLEAN; aPaperType: gxPaperType): gxPaperType;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0043, $ABFE;
	{$ENDC}
PROCEDURE GXForEachJobPaperTypeDo(aJob: gxJob; aProc: GXPaperTypeUPP; refCon: UNIV Ptr; forFormattingPrinter: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0044, $ABFE;
	{$ENDC}
FUNCTION GXCopyPaperType(srcPaperType: gxPaperType; dstPaperType: gxPaperType): gxPaperType;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0045, $ABFE;
	{$ENDC}
PROCEDURE GXGetPaperTypeName(aPaperType: gxPaperType; VAR papertypeName: Str31);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0046, $ABFE;
	{$ENDC}
PROCEDURE GXGetPaperTypeDimensions(aPaperType: gxPaperType; VAR pageSize: gxRectangle; VAR paperSize: gxRectangle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0047, $ABFE;
	{$ENDC}
FUNCTION GXGetPaperTypeJob(aPaperType: gxPaperType): gxJob;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0048, $ABFE;
	{$ENDC}
FUNCTION GXGetPaperTypeCollection(aPaperType: gxPaperType): Collection;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0049, $ABFE;
	{$ENDC}

{
	Printer Routines
}
FUNCTION GXGetJobFormattingPrinter(aJob: gxJob): gxPrinter;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0027, $ABFE;
	{$ENDC}
FUNCTION GXGetJobOutputPrinter(aJob: gxJob): gxPrinter;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0028, $ABFE;
	{$ENDC}
FUNCTION GXGetJobPrinter(aJob: gxJob): gxPrinter;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0029, $ABFE;
	{$ENDC}
FUNCTION GXGetPrinterJob(aPrinter: gxPrinter): gxJob;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $002A, $ABFE;
	{$ENDC}
PROCEDURE GXForEachPrinterViewDeviceDo(aPrinter: gxPrinter; aProc: GXViewDeviceUPP; refCon: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $002B, $ABFE;
	{$ENDC}
FUNCTION GXCountPrinterViewDevices(aPrinter: gxPrinter): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $002C, $ABFE;
	{$ENDC}
FUNCTION GXGetPrinterViewDevice(aPrinter: gxPrinter; whichViewDevice: LONGINT): gxViewDevice;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $002D, $ABFE;
	{$ENDC}
PROCEDURE GXSelectPrinterViewDevice(aPrinter: gxPrinter; whichViewDevice: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $002E, $ABFE;
	{$ENDC}
PROCEDURE GXGetPrinterName(aPrinter: gxPrinter; VAR printerName: Str31);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $002F, $ABFE;
	{$ENDC}
FUNCTION GXGetPrinterType(aPrinter: gxPrinter): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0030, $ABFE;
	{$ENDC}
PROCEDURE GXGetPrinterDriverName(aPrinter: gxPrinter; VAR driverName: Str31);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0031, $ABFE;
	{$ENDC}
FUNCTION GXGetPrinterDriverType(aPrinter: gxPrinter): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0032, $ABFE;
	{$ENDC}

{
	Dialog Routines
}
FUNCTION GXJobDefaultFormatDialog(aJob: gxJob; VAR anEditMenuRec: gxEditMenuRecord): gxDialogResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0010, $ABFE;
	{$ENDC}
FUNCTION GXJobPrintDialog(aJob: gxJob; VAR anEditMenuRec: gxEditMenuRecord): gxDialogResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0011, $ABFE;
	{$ENDC}
FUNCTION GXFormatDialog(aFormat: gxFormat; VAR anEditMenuRec: gxEditMenuRecord; title: StringPtr): gxDialogResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0012, $ABFE;
	{$ENDC}
PROCEDURE GXEnableJobScalingPanel(aJob: gxJob; enabled: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0040, $ABFE;
	{$ENDC}
PROCEDURE GXGetJobPanelDimensions(aJob: gxJob; VAR panelArea: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0041, $ABFE;
	{$ENDC}

{
	Spooling Routines
}
PROCEDURE GXGetJobPageRange(theJob: gxJob; VAR firstPage: LONGINT; VAR lastPage: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0017, $ABFE;
	{$ENDC}
PROCEDURE GXStartJob(theJob: gxJob; docName: StringPtr; pageCount: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0018, $ABFE;
	{$ENDC}
PROCEDURE GXPrintPage(theJob: gxJob; pageNumber: LONGINT; theFormat: gxFormat; thePage: gxShape);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0019, $ABFE;
	{$ENDC}
FUNCTION GXStartPage(theJob: gxJob; pageNumber: LONGINT; theFormat: gxFormat; numViewPorts: LONGINT; VAR viewPortList: gxViewPort): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $001A, $ABFE;
	{$ENDC}
PROCEDURE GXFinishPage(theJob: gxJob);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $001B, $ABFE;
	{$ENDC}
PROCEDURE GXFinishJob(theJob: gxJob);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $001C, $ABFE;
	{$ENDC}

{
	PrintFile Routines
}
FUNCTION GXOpenPrintFile(theJob: gxJob; anFSSpec: FSSpecPtr; permission: ByteParameter): gxPrintFile;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $004A, $ABFE;
	{$ENDC}
PROCEDURE GXClosePrintFile(aPrintFile: gxPrintFile);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $004B, $ABFE;
	{$ENDC}
FUNCTION GXGetPrintFileJob(aPrintFile: gxPrintFile): gxJob;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $004C, $ABFE;
	{$ENDC}
FUNCTION GXCountPrintFilePages(aPrintFile: gxPrintFile): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $004D, $ABFE;
	{$ENDC}
PROCEDURE GXReadPrintFilePage(aPrintFile: gxPrintFile; pageNumber: LONGINT; numViewPorts: LONGINT; VAR viewPortList: gxViewPort; VAR pgFormat: gxFormat; VAR pgShape: gxShape);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $004E, $ABFE;
	{$ENDC}
PROCEDURE GXReplacePrintFilePage(aPrintFile: gxPrintFile; pageNumber: LONGINT; aFormat: gxFormat; aShape: gxShape);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $004F, $ABFE;
	{$ENDC}
PROCEDURE GXInsertPrintFilePage(aPrintFile: gxPrintFile; atPageNumber: LONGINT; pgFormat: gxFormat; pgShape: gxShape);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0050, $ABFE;
	{$ENDC}
PROCEDURE GXDeletePrintFilePageRange(aPrintFile: gxPrintFile; fromPageNumber: LONGINT; toPageNumber: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0051, $ABFE;
	{$ENDC}
PROCEDURE GXSavePrintFile(aPrintFile: gxPrintFile; VAR anFSSpec: FSSpec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0052, $ABFE;
	{$ENDC}

{
	ColorSync Routines
}
FUNCTION GXFindPrinterProfile(aPrinter: gxPrinter; searchData: UNIV Ptr; index: LONGINT; VAR returnedProfile: gxColorProfile): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0053, $ABFE;
	{$ENDC}
FUNCTION GXFindFormatProfile(aFormat: gxFormat; searchData: UNIV Ptr; index: LONGINT; VAR returnedProfile: gxColorProfile): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0054, $ABFE;
	{$ENDC}
PROCEDURE GXSetPrinterProfile(aPrinter: gxPrinter; oldProfile: gxColorProfile; newProfile: gxColorProfile);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0055, $ABFE;
	{$ENDC}
PROCEDURE GXSetFormatProfile(aFormat: gxFormat; oldProfile: gxColorProfile; newProfile: gxColorProfile);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0056, $ABFE;
	{$ENDC}

{***********************************************************************
						Start of old "GXPrintingResEquates.h/a/p" interface file.
				************************************************************************}
{	------------------------------------
				Basic client types
	------------------------------------ }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	gxPrintingManagerType		= 'pmgr';
	gxImagingSystemType			= 'gxis';
	gxPrinterDriverType			= 'pdvr';
	gxPrintingExtensionType		= 'pext';
	gxUnknownPrinterType		= 'none';
	gxAnyPrinterType			= 'univ';
	gxQuickdrawPrinterType		= 'qdrw';
	gxPortableDocPrinterType	= 'gxpd';
	gxRasterPrinterType			= 'rast';
	gxPostscriptPrinterType		= 'post';
	gxVectorPrinterType			= 'vect';

{ All pre-defined printing collection items have this ID }
	gxPrintingTagID				= -28672;


{	----------------------------------------------------------------------

		Resource types and IDs used by both extension and driver writers

	---------------------------------------------------------------------- }
{ Resources in a printer driver or extension must be based off of these IDs }
	gxPrintingDriverBaseID		= -27648;
	gxPrintingExtensionBaseID	= -27136;

{	Override resources tell the system what messages a driver or extension
		is overriding.  A driver may have a series of these resources. }
{  Override resource type for 68k resource-based code: }

	gxOverrideType				= 'over';


{  Override resource type for PowerPC datafork-based code: }

	gxNativeOverrideType		= 'povr';


{	--------------------------------------------------------------

		Message ID definitions by both extension and driver writers

	--------------------------------------------------------------- }
{ Identifiers for universal message overrides. }
	gxInitializeMsg				= 0;
	gxShutDownMsg				= 1;
	gxJobIdleMsg				= 2;
	gxJobStatusMsg				= 3;
	gxPrintingEventMsg			= 4;
	gxJobDefaultFormatDialogMsg	= 5;
	gxFormatDialogMsg			= 6;
	gxJobPrintDialogMsg			= 7;
	gxFilterPanelEventMsg		= 8;
	gxHandlePanelEventMsg		= 9;
	gxParsePageRangeMsg			= 10;
	gxDefaultJobMsg				= 11;
	gxDefaultFormatMsg			= 12;
	gxDefaultPaperTypeMsg		= 13;
	gxDefaultPrinterMsg			= 14;
	gxCreateSpoolFileMsg		= 15;
	gxSpoolPageMsg				= 16;
	gxSpoolDataMsg				= 17;
	gxSpoolResourceMsg			= 18;
	gxCompleteSpoolFileMsg		= 19;
	gxCountPagesMsg				= 20;
	gxDespoolPageMsg			= 21;
	gxDespoolDataMsg			= 22;
	gxDespoolResourceMsg		= 23;
	gxCloseSpoolFileMsg			= 24;
	gxStartJobMsg				= 25;
	gxFinishJobMsg				= 26;
	gxStartPageMsg				= 27;
	gxFinishPageMsg				= 28;
	gxPrintPageMsg				= 29;
	gxSetupImageDataMsg			= 30;
	gxImageJobMsg				= 31;
	gxImageDocumentMsg			= 32;
	gxImagePageMsg				= 33;
	gxRenderPageMsg				= 34;
	gxCreateImageFileMsg		= 35;
	gxOpenConnectionMsg			= 36;
	gxCloseConnectionMsg		= 37;
	gxStartSendPageMsg			= 38;
	gxFinishSendPageMsg			= 39;
	gxWriteDataMsg				= 40;
	gxBufferDataMsg				= 41;
	gxDumpBufferMsg				= 42;
	gxFreeBufferMsg				= 43;
	gxCheckStatusMsg			= 44;
	gxGetDeviceStatusMsg		= 45;
	gxFetchTaggedDataMsg		= 46;
	gxGetDTPMenuListMsg			= 47;
	gxDTPMenuSelectMsg			= 48;
	gxHandleAlertFilterMsg		= 49;
	gxJobFormatModeQueryMsg		= 50;
	gxWriteStatusToDTPWindowMsg	= 51;
	gxInitializeStatusAlertMsg	= 52;
	gxHandleAlertStatusMsg		= 53;
	gxHandleAlertEventMsg		= 54;
	gxCleanupStartJobMsg		= 55;
	gxCleanupStartPageMsg		= 56;
	gxCleanupOpenConnectionMsg	= 57;
	gxCleanupStartSendPageMsg	= 58;
	gxDefaultDesktopPrinterMsg	= 59;
	gxCaptureOutputDeviceMsg	= 60;
	gxOpenConnectionRetryMsg	= 61;
	gxExamineSpoolFileMsg		= 62;
	gxFinishSendPlaneMsg		= 63;
	gxDoesPaperFitMsg			= 64;
	gxChooserMessageMsg			= 65;
	gxFindPrinterProfileMsg		= 66;
	gxFindFormatProfileMsg		= 67;
	gxSetPrinterProfileMsg		= 68;
	gxSetFormatProfileMsg		= 69;
	gxHandleAltDestinationMsg	= 70;
	gxSetupPageImageDataMsg		= 71;


{ Identifiers for Quickdraw message overrides. }
	gxPrOpenDocMsg				= 0;
	gxPrCloseDocMsg				= 1;
	gxPrOpenPageMsg				= 2;
	gxPrClosePageMsg			= 3;
	gxPrintDefaultMsg			= 4;
	gxPrStlDialogMsg			= 5;
	gxPrJobDialogMsg			= 6;
	gxPrStlInitMsg				= 7;
	gxPrJobInitMsg				= 8;
	gxPrDlgMainMsg				= 9;
	gxPrValidateMsg				= 10;
	gxPrJobMergeMsg				= 11;
	gxPrGeneralMsg				= 12;
	gxConvertPrintRecordToMsg	= 13;
	gxConvertPrintRecordFromMsg	= 14;
	gxPrintRecordToJobMsg		= 15;


{ Identifiers for raster imaging message overrides. }
	gxRasterDataInMsg			= 0;
	gxRasterLineFeedMsg			= 1;
	gxRasterPackageBitmapMsg	= 2;


{ Identifiers for PostScript imaging message overrides. }
	gxPostscriptQueryPrinterMsg	= 0;
	gxPostscriptInitializePrinterMsg = 1;
	gxPostscriptResetPrinterMsg	= 2;
	gxPostscriptExitServerMsg	= 3;
	gxPostscriptGetStatusTextMsg = 4;
	gxPostscriptGetPrinterTextMsg = 5;
	gxPostscriptScanStatusTextMsg = 6;
	gxPostscriptScanPrinterTextMsg = 7;
	gxPostscriptGetDocumentProcSetListMsg = 8;
	gxPostscriptDownloadProcSetListMsg = 9;
	gxPostscriptGetPrinterGlyphsInformationMsg = 10;
	gxPostscriptStreamFontMsg	= 11;
	gxPostscriptDoDocumentHeaderMsg = 12;
	gxPostscriptDoDocumentSetUpMsg = 13;
	gxPostscriptDoDocumentTrailerMsg = 14;
	gxPostscriptDoPageSetUpMsg	= 15;
	gxPostscriptSelectPaperTypeMsg = 16;
	gxPostscriptDoPageTrailerMsg = 17;
	gxPostscriptEjectPageMsg	= 18;
	gxPostscriptProcessShapeMsg	= 19;
	gxPostScriptEjectPendingPageMsg = 20;


{ Identifiers for Vector imaging message overrides. }
	gxVectorPackageDataMsg		= 0;
	gxVectorLoadPensMsg			= 1;
	gxVectorVectorizeShapeMsg	= 2;


{ Dialog related resource types }
	gxPrintingAlertType			= 'plrt';
	gxStatusType				= 'stat';
	gxExtendedDITLType			= 'xdtl';
	gxPrintPanelType			= 'ppnl';
	gxCollectionType			= 'cltn';


{ Communication resource types }
{
	The looker resource is used by the Chooser PACK to determine what kind
	of communications this driver supports. (In order to generate/handle the 
	pop-up menu for "Connect via:".
	
	The looker resource is also used by PrinterShare to determine the AppleTalk NBP Type
	for servers created for this driver.
}
	gxLookerType				= 'look';
	gxLookerID					= -4096;


{ The communications method and private data used to connect to the printer }
	gxDeviceCommunicationsType	= 'comm';

{	-------------------------------------------------

	Resource types and IDs used by extension writers

	------------------------------------------------- }
	gxExtensionUniversalOverrideID = -27136;

	gxExtensionImagingOverrideSelectorID = -27136;

	gxExtensionScopeType		= 'scop';
	gxDriverScopeID				= -27136;
	gxPrinterScopeID			= -27135;
	gxPrinterExceptionScopeID	= -27134;

	gxExtensionLoadType			= 'load';
	gxExtensionLoadID			= -27136;

	gxExtensionLoadFirst		= $00000100;
	gxExtensionLoadAnywhere		= $7FFFFFFF;
	gxExtensionLoadLast			= $FFFFFF00;

	gxExtensionOptimizationType	= 'eopt';
	gxExtensionOptimizationID	= -27136;


{	-----------------------------------------------

	Resource types and IDs used by driver writers

	----------------------------------------------- }
	gxDriverUniversalOverrideID	= -27648;
	gxDriverImagingOverrideID	= -27647;
	gxDriverCompatibilityOverrideID = -27646;

	gxDriverFileFormatType		= 'pfil';
	gxDriverFileFormatID		= -27648;


	gxDestinationAdditionType	= 'dsta';
	gxDestinationAdditionID		= -27648;


{ IMAGING RESOURCES }
{	The imaging system resource specifies which imaging system a printer
		driver wishes to use. }

	gxImagingSystemSelectorType	= 'isys';
	gxImagingSystemSelectorID	= -27648;


{ 'exft' resource ID -- exclude font list }
	kExcludeFontListType		= 'exft';
	kExcludeFontListID			= -27648;

{ Resource for type for color matching }
	gxColorMatchingDataType		= 'prof';
	gxColorMatchingDataID		= -27648;


{ Resource type and id for the tray count }
	gxTrayCountDataType			= 'tray';
	gxTrayCountDataID			= -27648;


{ Resource type for the tray names }
	gxTrayNameDataType			= 'tryn';


{ Resource type for manual feed preferences, stored in DTP. }
	gxManualFeedAlertPrefsType	= 'mfpr';
	gxManualFeedAlertPrefsID	= -27648;

{ Resource type for desktop printer output characteristics, stored in DTP. }
	gxDriverOutputType			= 'outp';
	gxDriverOutputTypeID		= 1;


{ IO Resources }
{ Resource type and ID for default IO and buffering resources }
	gxUniversalIOPrefsType		= 'iobm';
	gxUniversalIOPrefsID		= -27648;


{	Resource types and IDs for default implementation of CaptureOutputDevice.
		The default implementation of CaptureOutputDevice only handles PAP devices }
	gxCaptureType				= 'cpts';
	gxCaptureStringID			= -27648;
	gxReleaseStringID			= -27647;
	gxUncapturedAppleTalkType	= -27646;
	gxCapturedAppleTalkType		= -27645;


{ Resource type and ID for custom halftone matrix }
	gxCustomMatrixType			= 'dmat';
	gxCustomMatrixID			= -27648;

{ Resource type and ID for raster driver rendering preferences }
	gxRasterPrefsType			= 'rdip';
	gxRasterPrefsID				= -27648;


{ Resource type for specifiying a colorset }
	gxColorSetResType			= 'crst';


{ Resource type and ID for raster driver packaging preferences }
	gxRasterPackType			= 'rpck';
	gxRasterPackID				= -27648;


{ Resource type and ID for raster driver packaging options }

	gxRasterNumNone				= 0;							{  Number isn't output at all  }
	gxRasterNumDirect			= 1;							{  Lowest minWidth bytes as data  }
	gxRasterNumToASCII			= 2;							{  minWidth ASCII characters  }


	gxRasterPackOptionsType		= 'ropt';
	gxRasterPackOptionsID		= -27648;


{ Resource type for the PostScript imaging system procedure set control resource }
	gxPostscriptProcSetControlType = 'prec';


{ Resource type for the PostScript imaging system printer font resource }
	gxPostscriptPrinterFontType	= 'pfnt';


{ Resource type and ID for the PostScript imaging system imaging preferences }
	gxPostscriptPrefsType		= 'pdip';
	gxPostscriptPrefsID			= -27648;

{ Resource type and ID for the PostScript imaging system default scanning code }
	gxPostscriptScanningType	= 'scan';
	gxPostscriptScanningID		= -27648;


{ Old Application Support Resources }
	gxCustType					= 'cust';
	gxCustID					= -8192;


	gxReslType					= 'resl';
	gxReslID					= -8192;


	gxDiscreteResolution		= 0;


	gxStlDialogResID			= -8192;


	gxJobDialogResID			= -8191;


	gxScaleTableType			= 'stab';
	gxDITLControlType			= 'dctl';

{	The default implementation of gxPrintDefault loads and
	PrValidates a print record stored in the following driver resource. }
	gxPrintRecordType			= 'PREC';
	gxDefaultPrintRecordID		= 0;


{
	-----------------------------------------------

	Resource types and IDs used in papertype files

	-----------------------------------------------
}
{ Resource type and ID for driver papertypes placed in individual files }
	gxSignatureType				= 'sig ';
	gxPapertypeSignatureID		= 0;


{ Papertype creator types }
	gxDrvrPaperType				= 'drpt';
	gxSysPaperType				= 'sypt';						{  System paper type creator  }
	gxUserPaperType				= 'uspt';						{  User paper type creator  }
																{  Driver creator types == driver file's creator value  }
	gxPaperTypeType				= 'ptyp';


{********************************************************************
					Start of old "GXPrintingMessages.h/a/p" interface file.
			*********************************************************************}
{ ------------------------------------------------------------------------------

									Constants and Types

-------------------------------------------------------------------------------- }
{

	ABSTRACT DATA TYPES

}

TYPE
	gxSpoolFile = ^LONGINT; { an opaque 32-bit type }
{

	DIALOG PANEL CONSTANTS AND TYPES

}
	gxPanelEvent						= LONGINT;
{ Dialog panel event equates }

CONST
	gxPanelNoEvt				= 0;
	gxPanelOpenEvt				= 1;							{  Initialize and draw  }
	gxPanelCloseEvt				= 2;							{  Your panel is going away (panel switchL, confirm or cancel)  }
	gxPanelHitEvt				= 3;							{  There's a hit in your panel  }
	gxPanelActivateEvt			= 4;							{  The dialog window has just been activated  }
	gxPanelDeactivateEvt		= 5;							{  The dialog window is about to be deactivated  }
	gxPanelIconFocusEvt			= 6;							{  The focus changes from the panel to the icon list  }
	gxPanelPanelFocusEvt		= 7;							{  The focus changes from the icon list to the panel  }
	gxPanelFilterEvt			= 8;							{  Every event is filtered  }
	gxPanelCancelEvt			= 9;							{  The user has cancelled the dialog  }
	gxPanelConfirmEvt			= 10;							{  The user has confirmed the dialog  }
	gxPanelDialogEvt			= 11;							{  Event to be handle by dialoghandler  }
	gxPanelOtherEvt				= 12;							{  osEvts, etc.  }
	gxPanelUserWillConfirmEvt	= 13;							{  User has selected confirm, time to parse panel interdependencies  }


{ Constants for panel responses to dialog handler calls }

TYPE
	gxPanelResult						= LONGINT;

CONST
	gxPanelNoResult				= 0;
	gxPanelCancelConfirmation	= 1;							{  Only valid from panelUserWillConfirmEvt - used to keep the dialog from going away  }


{ Panel event info record for FilterPanelEvent and HandlePanelEvent messages }

TYPE
	gxPanelInfoRecordPtr = ^gxPanelInfoRecord;
	gxPanelInfoRecord = RECORD
		panelEvt:				gxPanelEvent;							{  Why we were called  }
		panelResId:				INTEGER;								{  'ppnl' resource ID of current panel  }
		pDlg:					DialogPtr;								{  Pointer to dialog  }
		theEvent:				EventRecordPtr;							{  Pointer to event  }
		itemHit:				INTEGER;								{  Actual item number as Dialog Mgr thinks  }
		itemCount:				INTEGER;								{  Number of items before your items  }
		evtAction:				INTEGER;								{  Once this event is processed, the action that will result  }
																		{  (evtAction is only meaningful during filtering)  }
		errorStringId:			INTEGER;								{  STR ID of string to put in error alert (0 means no string)  }
		theFormat:				gxFormat;								{  The current format (only meaningful in a format dialog)  }
		refCon:					Ptr;									{  refCon passed in PanelSetupRecord  }
	END;

{ Constants for the evtAction field in PanelInfoRecord }

CONST
	gxOtherAction				= 0;							{  Current item will not change  }
	gxClosePanelAction			= 1;							{  Panel will be closed  }
	gxCancelDialogAction		= 2;							{  Dialog will be cancelled  }
	gxConfirmDialogAction		= 3;							{  Dialog will be confirmed  }


{ Constants for the panelKind field in gxPanelSetupRecord }

TYPE
	gxPrintingPanelKind					= LONGINT;
{ The gxPanelSetupInfo structure is passed to GXSetupDialogPanel }
	gxPanelSetupRecordPtr = ^gxPanelSetupRecord;
	gxPanelSetupRecord = RECORD
		panelKind:				gxPrintingPanelKind;
		panelResId:				INTEGER;
		resourceRefNum:			INTEGER;
		refCon:					Ptr;
	END;


CONST
	gxApplicationPanel			= 0;
	gxExtensionPanel			= 1;
	gxDriverPanel				= 2;


{ Constants returned by gxParsePageRange message }

TYPE
	gxParsePageRangeResult				= LONGINT;

CONST
	gxRangeNotParsed			= 0;							{  Default initial value  }
	gxRangeParsed				= 1;							{  Range has been parsed  }
	gxRangeBadFromValue			= 2;							{  From value is bad  }
	gxRangeBadToValue			= 3;							{  To value is bad  }

{

	STATUS-RELATED CONSTANTS AND TYPES

}

{ Structure for status messages }

TYPE
	gxStatusRecordPtr = ^gxStatusRecord;
	gxStatusRecord = RECORD
		statusType:				UInt16;									{  One of the ids listed above (nonFatalError, etc. )  }
		statusId:				UInt16;									{  Specific status (out of paper, etc.)  }
		statusAlertId:			UInt16;									{ 	Printing alert ID (if any) for status  }
		statusOwner:			gxOwnerSignature;						{  Creator type of status owner  }
		statResId:				INTEGER;								{  ID for 'stat' resource  }
		statResIndex:			INTEGER;								{  Index into 'stat' resource for this status  }
		dialogResult:			INTEGER;								{  ID of button string selected on dismissal of printing alert  }
		bufferLen:				UInt16;									{  Number of bytes in status buffer - total record size must be <= 512  }
		statusBuffer:			SInt8;									{  User response from alert  }
	END;


{ Constants for statusType field of gxStatusRecord }

CONST
	gxNonFatalError				= 1;							{  An error occurred, but the job can continue  }
	gxFatalError				= 2;							{  A fatal error occurred-- halt job  }
	gxPrinterReady				= 3;							{  Tells QDGX to leave alert mode  }
	gxUserAttention				= 4;							{  Signals initiation of a modal alert  }
	gxUserAlert					= 5;							{  Signals initiation of a moveable modal alert  }
	gxPageTransmission			= 6;							{  Signals page sent to printer, increments page count in strings to user  }
	gxOpenConnectionStatus		= 7;							{  Signals QDGX to begin animation on printer icon  }
	gxInformationalStatus		= 8;							{  Default status type, no side effects  }
	gxSpoolingPageStatus		= 9;							{  Signals page spooled, increments page count in spooling dialog  }
	gxEndStatus					= 10;							{  Signals end of spooling  }
	gxPercentageStatus			= 11;							{  Signals QDGX as to the amount of the job which is currently complete  }


{ Structure for gxWriteStatusToDTPWindow message }

TYPE
	gxDisplayRecordPtr = ^gxDisplayRecord;
	gxDisplayRecord = RECORD
		useText:				BOOLEAN;								{  Use text as opposed to a picture  }
		padByte:				SInt8;
		hPicture:				Handle;									{  if !useText, the picture handle  }
		theText:				Str255;									{  if useText, the text  }
	END;


{-----------------------------------------------}
{ paper mapping-related constants and types...  }
{-----------------------------------------------}

	gxTrayMapping						= LONGINT;

CONST
	gxDefaultTrayMapping		= 0;
	gxConfiguredTrayMapping		= 1;



{ ------------------------------------------------------------------------------

				API Functions callable only from within message overrides

-------------------------------------------------------------------------------- }

{
	Message Sending API Routines
}
{

	How to use the GXPRINTINGDISPATCH macro...
	
	If your driver or extension is large, you may want to segment it
	across smaller boundaries than is permitted by the messaging system.
	Without using the Printing Manager's segmentation manager directly,
	the smallest segment you can create consists of the code to override
	a single message.  If you are overriding workhorse messages such as
	RenderPage, you may want to divide up the work among many functions
	distributed across several segments.  Here's how...
	
	The Printing Manager segment scheme involves the construction of a
	single 32-bit dispatch selector, which contains all the information
	necessary for the dispatcher to find a single routine.  It contains the
	segment's resource ID, and the offset within the segment which contains
	the start of the routine.  The GXPRINTINGDISPATCH macro will construct the
	dispatch selector for you, as well as the code to do the dispatch.
	
	Usually, it is convenient to start your segment with a long aligned jump table,
	beginning after the 4 byte header required by the Printing Manager.  The
	macro assumes this is the case and takes a 1-based routine selector from
	which it conmstructs the offset.
	
	For example, if your code is in resource 'pdvr' (print driver), ID=2
	at offset=12 (third routine in segment), you would declare your
	routine as follows:
	
	OSErr MyRenderingRoutine (long param1, Ptr param2)
		= GXPRINTINGDISPATCH(2, 3);
		
	Remember, ALL segment dispatches must return OSErr.  If your routine
	does not generate errors, you must still declare it to return OSErr
	and have the routine itself return noErr.
	
	An alternative way to call across segments is to call the GXPrintingDispatch
	function directly.  You must construct the 32-bit selector yourself and pass
	it as the first parameter.  This is usually not preferable since you don't get
	type-checking unless you declare a prototype as shown above, and your code
	isn't as easy to read.
	
	So given the above prototype, there are two ways to call the function:
	
		anErr = MyRenderingRoutine(p1, p2);			// Free type checking!
		
	or:
	
		#define kMyRenderRoutineSelector 0x0002000C
		anErr = GXPrintingDispatch(kMyRenderRoutineSelector, p1, p2);		// No type-checking!
	
	
	Both have the same effect.

}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION GXGetJob: gxJob; C;
FUNCTION GXGetMessageHandlerResFile: INTEGER; C;
FUNCTION GXSpoolingAborted: BOOLEAN; C;
FUNCTION GXJobIdle: OSErr; C;
FUNCTION GXReportStatus(statusID: LONGINT; statusIndex: UInt32): OSErr; C;
FUNCTION GXAlertTheUser(VAR statusRec: gxStatusRecord): OSErr; C;
FUNCTION GXSetupDialogPanel(VAR panelRec: gxPanelSetupRecord): OSErr; C;
FUNCTION GXCountTrays(VAR numTrays: gxTrayIndex): OSErr; C;
FUNCTION GXGetTrayName(trayNumber: gxTrayIndex; VAR trayName: Str31): OSErr; C;
FUNCTION GXSetTrayPaperType(whichTray: gxTrayIndex; aPapertype: gxPaperType): OSErr; C;
FUNCTION GXGetTrayPaperType(whichTray: gxTrayIndex; aPapertype: gxPaperType): OSErr; C;
FUNCTION GXGetTrayMapping(VAR trayMapping: gxTrayMapping): OSErr; C;
PROCEDURE GXCleanupStartJob; C;
PROCEDURE GXCleanupStartPage; C;
PROCEDURE GXCleanupOpenConnection; C;
PROCEDURE GXCleanupStartSendPage; C;

{ ------------------------------------------------------------------------------

					Constants and types for Universal Printing Messages

-------------------------------------------------------------------------------- }

{ Options for gxCreateSpoolFile message }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	gxNoCreateOptions			= $00000000;					{  Just create the file  }
	gxInhibitAlias				= $00000001;					{  Do not create an alias in the PMD folder  }
	gxInhibitUniqueName			= $00000002;					{  Do not append to the filename to make it unique  }
	gxResolveBitmapAlias		= $00000004;					{  Resolve bitmap aliases and duplicate data in file  }


{ Options for gxCloseSpoolFile message }
	gxNoCloseOptions			= $00000000;					{  Just close the file  }
	gxDeleteOnClose				= $00000001;					{  Delete the file rather than closing it  }
	gxUpdateJobData				= $00000002;					{  Write current job information into file prior to closing  }
	gxMakeRemoteFile			= $00000004;					{  Mark job as a remote file  }


{ Options for gxCreateImageFile message }
	gxNoImageFile				= $00000000;					{  Don't create image file  }
	gxMakeImageFile				= $00000001;					{  Create an image file  }
	gxEachPlane					= $00000002;					{  Only save up planes before rewinding  }
	gxEachPage					= $00000004;					{  Save up entire pages before rewinding  }
	gxEntireFile				= $00000006;					{  Save up the entire file before rewinding  }


{ Options for gxBufferData message }
	gxNoBufferOptions			= $00000000;
	gxMakeBufferHex				= $00000001;
	gxDontSplitBuffer			= $00000002;


{ Structure for gxDumpBuffer and gxFreeBuffer messages }

TYPE
	gxPrintingBufferPtr = ^gxPrintingBuffer;
	gxPrintingBuffer = RECORD
		size:					LONGINT;								{  Size of buffer in bytes  }
		userData:				LONGINT;								{  Client assigned id for the buffer  }
		data:					SInt8;									{  Array of size bytes  }
	END;


{ Structure for gxRenderPage message }
	gxPageInfoRecordPtr = ^gxPageInfoRecord;
	gxPageInfoRecord = RECORD
		docPageNum:				LONGINT;								{  Number of page being printed  }
		copyNum:				LONGINT;								{  Copy number being printed  }
		formatChanged:			BOOLEAN;								{  True if format changed from last page  }
		pageChanged:			BOOLEAN;								{  True if page contents changed from last page  }
		internalUse:			LONGINT;								{  Private  }
	END;

{******************************************************************
				Start of old "GXPrintingErrors.h/a/p" interface file.
		*******************************************************************}

CONST
	gxPrintingResultBase		= -510;							{ First QuickDraw GX printing error code. }

{RESULT CODES FOR QUICKDRAW GX PRINTING OPERATIONS}
	gxAioTimeout				= -510;							{ -510 : Timeout condition occurred during operation }
	gxAioBadRqstState			= -511;							{ -511 : Async I/O request in invalid state for operation }
	gxAioBadConn				= -512;							{ -512 : Invalid Async I/O connection refnum }
	gxAioInvalidXfer			= -513;							{ -513 : Read data transfer structure contained bad values }
	gxAioNoRqstBlks				= -514;							{ -514 : No available request blocks to process request }
	gxAioNoDataXfer				= -515;							{ -515 : Data transfer structure pointer not specified }
	gxAioTooManyAutos			= -516;							{ -516 : Auto status request already active }
	gxAioNoAutoStat				= -517;							{ -517 : Connection not configured for auto status }
	gxAioBadRqstID				= -518;							{ -518 : Invalid I/O request identifier }
	gxAioCantKill				= -519;							{ -519 : Comm. protocol doesn't support I/O term }
	gxAioAlreadyExists			= -520;							{ -520 : Protocol spec. data already specified }
	gxAioCantFind				= -521;							{ -521 : Protocol spec. data does not exist }
	gxAioDeviceDisconn			= -522;							{ -522 : Machine disconnected from printer }
	gxAioNotImplemented			= -523;							{ -523 : Function not implemented }
	gxAioOpenPending			= -524;							{ -524 : Opening a connection for protocol, but another open pending }
	gxAioNoProtocolData			= -525;							{ -525 : No protocol specific data specified in request }
	gxAioRqstKilled				= -526;							{ -526 : I/O request was terminated }
	gxBadBaudRate				= -527;							{ -527 : Invalid baud rate specified }
	gxBadParity					= -528;							{ -528 : Invalid parity specified }
	gxBadStopBits				= -529;							{ -529 : Invalid stop bits specified }
	gxBadDataBits				= -530;							{ -530 : Invalid data bits specified }
	gxBadPrinterName			= -531;							{ -531 : Bad printer name specified }
	gxAioBadMsgType				= -532;							{ -532 : Bad masType field in transfer info structure }
	gxAioCantFindDevice			= -533;							{ -533 : Cannot locate target device }
	gxAioOutOfSeq				= -534;							{ -534 : Non-atomic SCSI requests submitted out of sequence }
	gxPrIOAbortErr				= -535;							{ -535 : I/O operation aborted }
	gxPrUserAbortErr			= -536;							{ -536 : User aborted }
	gxCantAddPanelsNowErr		= -537;							{ -537 : Can only add panels during driver switch or dialog setup }
	gxBadxdtlKeyErr				= -538;							{ -538 : Unknown key for xdtl - must be radiobutton, etc }
	gxXdtlItemOutOfRangeErr		= -539;							{ -539 : Referenced item does not belong to panel }
	gxNoActionButtonErr			= -540;							{ -540 : Action button is nil }
	gxTitlesTooLongErr			= -541;							{ -541 : Length of buttons exceeds alert maximum width }
	gxUnknownAlertVersionErr	= -542;							{ -542 : Bad version for printing alerts }
	gxGBBufferTooSmallErr		= -543;							{ -543 : Buffer too small. }
	gxInvalidPenTable			= -544;							{ -544 : Invalid vector driver pen table. }
	gxIncompletePrintFileErr	= -545;							{ -545 : Print file was not completely spooled }
	gxCrashedPrintFileErr		= -546;							{ -546 : Print file is corrupted }
	gxInvalidPrintFileVersion	= -547;							{ -547 : Print file is incompatible with current QuickDraw GX version }
	gxSegmentLoadFailedErr		= -548;							{ -548 : Segment loader error }
	gxExtensionNotFoundErr		= -549;							{ -549 : Requested printing extension could not be found }
	gxDriverVersionErr			= -550;							{ -550 : Driver too new for current version of QuickDraw GX }
	gxImagingSystemVersionErr	= -551;							{ -551 : Imaging system too new for current version of QuickDraw GX }
	gxFlattenVersionTooNew		= -552;							{ -552 : Flattened object format too new for current version of QDGX }
	gxPaperTypeNotFound			= -553;							{ -553 : Requested papertype could not be found }
	gxNoSuchPTGroup				= -554;							{ -554 : Requested papertype group could not be found }
	gxNotEnoughPrinterMemory	= -555;							{ -555 : Printer does not have enough memory for fonts in document }
	gxDuplicatePanelNameErr		= -556;							{ -556 : Attempt to add more than 10 panels with the same name }
	gxExtensionVersionErr		= -557;							{ -557 : Extension too new for current version of QuickDraw GX }



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXPrintingIncludes}

{$ENDC} {__GXPRINTING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
