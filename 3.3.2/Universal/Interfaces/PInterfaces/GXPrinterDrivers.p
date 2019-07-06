{
     File:       GXPrinterDrivers.p
 
     Contains:   This file defines data types and API functions for printer driver development.
 
     Version:    Technology: Quickdraw GX 1.1
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1995-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT GXPrinterDrivers;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GXPRINTERDRIVERS__}
{$SETC __GXPRINTERDRIVERS__ := 1}

{$I+}
{$SETC GXPrinterDriversIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __SCALERSTREAMTYPES__}
{$I ScalerStreamTypes.p}
{$ENDC}
{$IFC UNDEFINED __GXMESSAGES__}
{$I GXMessages.p}
{$ENDC}
{$IFC UNDEFINED __PRINTING__}
{$I Printing.p}
{$ENDC}
{$IFC UNDEFINED __GXPRINTING__}
{$I GXPrinting.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ ------------------------------------------------------------------------------

                        Desktop Printer Constants and Types

-------------------------------------------------------------------------------- }
{ Manual feed alert preferences structure for gxManualFeedAlertPrefsType desktop printer resource }

TYPE
	gxManualFeedAlertPrefsPtr = ^gxManualFeedAlertPrefs;
	gxManualFeedAlertPrefs = RECORD
		alertFlags:				LONGINT;								{     Flags--first word is for driver's private use, the rest is predefined.  }
	END;

	gxManualFeedAlertPrefsHdl			= ^gxManualFeedAlertPrefsPtr;
{  Constants for the alertFlags field of gxManualFeedAlertPrefs. }

CONST
	gxShowAlerts				= $00000001;					{  Show alerts for this desktop printer.  }
	gxAlertOnPaperChange		= $00000002;					{  …only if the papertype changes.  }

	gxDefaultMFeedAlertSettings	= $00000003;


{ Driver output settings structure for desktop printer gxDriverOutputType resource }

TYPE
	gxDriverOutputSettingsPtr = ^gxDriverOutputSettings;
	gxDriverOutputSettings = RECORD
		driverflags:			LONGINT;								{     Flags -- for use by driver.  }
		outputSettings:			LONGINT;								{     Flags -- predefined.  }
	END;

	gxDriverOutputSettingsHdl			= ^gxDriverOutputSettingsPtr;
{ Constants for the outputSettings field of gxDriverOutputSettings. }

CONST
	gxCanConfigureTrays			= $00000001;					{  Desktop printer represents a device with a paper feed.  }

{ ------------------------------------------------------------------------------

                        Printing Driver Constants and Types

-------------------------------------------------------------------------------- }
	gxInputTraysMenuItem		= -1;							{  Menu item number for "Input Trays..."  }


{ Buffering and IO preferences-- this structure mirrors the 'iobm' resource }

TYPE
	gxIOPrefsRecPtr = ^gxIOPrefsRec;
	gxIOPrefsRec = RECORD
		communicationsOptions:	UInt32;									{  Standard or nonstandard I/O?  }
		numBuffers:				UInt32;									{  Requested number of buffers for QDGX to create  }
		bufferSize:				UInt32;									{  The size of each buffer  }
		numReqBlocks:			UInt32;									{  The number of async I/O request blocks which will be needed  }
		openCloseTimeout:		UInt32;									{  The open/close timeout (in ticks)  }
		readWriteTimeout:		UInt32;									{  The read/write timeout (in ticks)  }
	END;

	gxIOPrefsPtr						= ^gxIOPrefsRec;
	gxIOPrefsHdl						= ^gxIOPrefsPtr;
{ Constants for the communicationsOptions field of IOPrefsRec. }

CONST
	gxUseCustomIO				= $00000001;					{  Driver uses a non-standard IO mechanism  }


{ Information about writing to a file }

TYPE
	gxPrintDestinationRecPtr = ^gxPrintDestinationRec;
	gxPrintDestinationRec = RECORD
		printToFile:			BOOLEAN;								{  True if output is to go to a file  }
		padByte:				SInt8;
		fSpec:					FSSpec;									{  If going to a file, the FSSpec for the file  }
		includeFonts:			SInt8;									{  True if fonts are to be included  }
		pad2:					SInt8;
		fileFormat:				Str31;									{  Format to write file  }
	END;

	gxPrintDestinationPtr				= ^gxPrintDestinationRec;
	gxPrintDestinationHdl				= ^gxPrintDestinationPtr;
{ This structure is the content of each cell in the standard PACK LDEF }
	gxPortListRecPtr = ^gxPortListRec;
	gxPortListRec = RECORD
		firstMarker:			SInt8;									{  Markers to indicate icon or non-icon version  }
		secondMarker:			SInt8;									{  if these are ≈ and ≈, then the cell is an icon cell.  }
																		{  Otherwise, it is assumed to be a standard text LDEF  }
																		{  cell  }
		iconSuiteHandle:		Handle;									{  The icon suite to draw for this cell  }
		outputDriverName:		Handle;									{  Handle to the output driver name (for serial)  }
		inputDriverName:		Handle;									{  Handle to the input driver name (for serial)  }
		iconName:				Str255;									{  Name to draw under the icon  }
	END;

	gxPortListPtr						= ^gxPortListRec;
{ ------------------------------------------------------------------------------

                        Printing Driver Constants for resources in the desktop printer

-------------------------------------------------------------------------------- }

CONST
	gxDeviceCommunicationsID	= 0;


{ ----------------------------------• 'prod' •---------------------------------- }
{
      For PostScript devices, the device and version names of the device.
      (0) product name is of type PString
      (1) version is of type PString
      (2) revision is of type PString
      (3) vm available is of type long
      (4) font stream type is of type scalerStreamTypeFlag
      (5) language level is of type long
}

	gxPostscriptProductInfoType	= 'prod';
	gxPostscriptProductNameID	= 0;
	gxPostscriptVersionID		= 1;
	gxPostscriptRevisionID		= 2;
	gxPostscriptVMAvailableID	= 3;
	gxPostscriptFontStreamTypeID = 4;
	gxPostscriptLanguageLevelID	= 5;


{  PPD support definitions }
	gxPPDInformationTag			= 'ppda';						{  tag used for job collection }
	gxPPDInformationTagID		= -28672;						{  ID for job collection tag }

	gxPPDInformationType		= 'ppda';						{  rsource type as stored in desktop printer }
	gxPPDInformationResID		= -27648;						{  ID of rsource stored in desktop printer }


TYPE
	gxPPDFileInfoRecPtr = ^gxPPDFileInfoRec;
	gxPPDFileInfoRec = RECORD
		dataOffset:				UInt32;									{  byte offset to beginning of ppd data }
		dataLength:				UInt32;									{  length of ppd data }
		reserved:				UInt32;									{  reserved }
		aliasRecordSize:		UInt32;									{  size of alias record below }
		ppdAlias:				SInt8;									{  the actual alias record data }
	END;

	gxPPDFileInfoPtr					= ^gxPPDFileInfoRec;
	gxPPDFileInfoHdl					= ^gxPPDFileInfoPtr;
{ ------------------------------------------------------------------------------

                        Printing Driver Constants for status alerts

-------------------------------------------------------------------------------- }

{ Structure passed in statusBuffer of StatusRecord for manual feed alert }
	gxManualFeedRecordPtr = ^gxManualFeedRecord;
	gxManualFeedRecord = RECORD
		canAutoFeed:			BOOLEAN;								{  True if driver can switch to auto feed  }
		pad1:					SInt8;
		paperTypeName:			Str31;									{  Name of paperType to feed manually  }
	END;


{ Structure passed in statusBuffer of StatusRecord for out of paper alert }
	gxOutOfPaperRecordPtr = ^gxOutOfPaperRecord;
	gxOutOfPaperRecord = RECORD
		paperTypeName:			Str31;									{  Name of printing document  }
	END;


{ The DITL id for the auto feed button in the manual feed alert }

CONST
	gxAutoFeedButtonId			= 3;


{ Status resource id for the alerts }
	gxUnivAlertStatusResourceId	= -28508;


{ Status resource indices for alerts }
	gxUnivSetTrayIndex			= 0;
	gxUnivManualFeedIndex		= 2;
	gxUnivFailToPrintIndex		= 3;
	gxUnivPaperJamIndex			= 4;
	gxUnivOutOfPaperIndex		= 5;
	gxUnivNoPaperTrayIndex		= 6;
	gxUnivPrinterReadyIndex		= 7;
	gxUnivAlertBeforeIndex		= 9;
	gxUnivAlertAfterIndex		= 10;


{ Allocation sizes for status buffers needed for automatic alerts }
	gxDefaultStatusBufferSize	= 10;
	gxManualFeedStatusBufferSize = 34;
	gxOutOfPaperStatusBufferSize = 42;


{ ------------------------------------------------------------------------------

                                Old Application Support

-------------------------------------------------------------------------------- }
{ The format of a 'cust' resource  }

TYPE
	gxCustomizationRecPtr = ^gxCustomizationRec;
	gxCustomizationRec = RECORD
		horizontalResolution:	INTEGER;								{  Horizontal res (integral part)  }
		verticalResolution:		INTEGER;								{  Vertical res (integral part)  }
		upDriverType:			INTEGER;								{  "upDriver" emulation type  }
		patternStretch:			Point;									{  Pattern stretch factor  }
		translatorSettings:		INTEGER;								{  Translator settings to use  }
	END;

	gxCustomizationPtr					= ^gxCustomizationRec;
	gxCustomizationHdl					= ^gxCustomizationPtr;
{ The format of a 'resl' resource }
	gxResolutionRecPtr = ^gxResolutionRec;
	gxResolutionRec = RECORD
		rangeType:				INTEGER;								{  Always 1  }
		xMinimumResolution:		INTEGER;								{  Min X resolution available  }
		xMaximumResolution:		INTEGER;								{  Max X resolution available  }
		yMinimumResolution:		INTEGER;								{  Min Y resolution available  }
		yMaximumResolution:		INTEGER;								{  Max Y resolution available  }
		resolutionCount:		INTEGER;								{  Number of resolutions  }
		resolutions:			ARRAY [0..0] OF Point;					{  Array of resolutions  }
	END;

	gxResolutionPtr						= ^gxResolutionRec;
	gxResolutionHdl						= ^gxResolutionPtr;
{

        Constants for the "universal" print record.

}
{ Constant for version number in universal print record }

CONST
	gxPrintRecordVersion		= 8;

{ Constants for feed field in universal print record }
	gxAutoFeed					= 0;
	gxManualFeed				= 1;

{ Constants for options field in universal print record }
	gxPreciseBitmap				= $0001;						{  Tall adjusted (IW), precise bitmap (LW, SC)  }
	gxBiggerPages				= $0002;						{  No gaps (IW), larger print area (LW)  }
	gxGraphicSmoothing			= $0004;						{  Graphic smoothing (LW)  }
	gxTextSmoothing				= $0008;						{  Text smoothing (SC)  }
	gxFontSubstitution			= $0010;						{  Font substitution  }
	gxInvertPage				= $0020;						{  B/W invert image  }
	gxFlipPageHoriz				= $0040;						{  Flip horizontal  }
	gxFlipPageVert				= $0080;						{  Flip vertical  }
	gxColorMode					= $0100;						{  Color printing  }
	gxBidirectional				= $0200;						{  Bidirectional printing  }
	gxUserFlag0					= $0400;						{  User flag 0  }
	gxUserFlag1					= $0800;						{  User flag 1  }
	gxUserFlag2					= $1000;						{  User flag 2  }
	gxReservedFlag0				= $2000;						{  Reserved flag 0  }
	gxReservedFlag1				= $4000;						{  Reserved flag 1  }
	gxReservedFlag2				= $8000;						{  Reserved flag 2  }

{ Constants for orientation field in universal print record }
	gxPortraitOrientation		= 0;
	gxLandscapeOrientation		= 1;
	gxAltPortraitOrientation	= 2;
	gxAltLandscapeOrientation	= 3;

{ Constants for qualityMode field in universal print record }
	gxBestQuality				= 0;
	gxFasterQuality				= 1;
	gxDraftQuality				= 2;

{ Constants for firstTray and remainingTray fields in universal print record }
	gxFirstTray					= 0;
	gxSecondTray				= 1;
	gxThirdTray					= 2;

{ Constants for coverPage field in universal print record }
	gxNoCoverPage				= 0;
	gxFirstPageCover			= 1;
	gxLastPageCover				= 2;

{ Constants for headMotion field in universal print record }
	gxUnidirectionalMotion		= 0;
	gxBidirectionalMotion		= 1;

{ Constants for saveFile field in universal print record }
	gxNoFile					= 0;
	gxPostScriptFile			= 1;


{ The format of the "universal" print record }

TYPE
	gxUniversalPrintRecordPtr = ^gxUniversalPrintRecord;
	gxUniversalPrintRecord = RECORD
		printRecordVersion:		INTEGER;								{  Print record version  }
																		{  prInfo subrecord  }
		appDev:					INTEGER;								{  Device kind, always 0  }
		appVRes:				INTEGER;								{  Application vertical resolution  }
		appHRes:				INTEGER;								{  Application horizontal resolution  }
		appPage:				Rect;									{  Page size, in application resolution  }
		appPaper:				Rect;									{  Paper rectangle [offset from rPage]  }
																		{  prStl subrecord  }
		devType:				INTEGER;								{  Device type, always 0xA900 (was wDev)  }
		pageV:					INTEGER;								{  Page height in 120ths of an inch  }
		pageH:					INTEGER;								{  Page width in 120ths of an inch  }
		fillByte:				SInt8;									{  Page calculation mode  }
		feed:					SInt8;									{  Feed mode  }
																		{  prInfoPT subrecord  }
		devKind:				INTEGER;								{  Device kind, always 0  }
		devVRes:				INTEGER;								{  Device vertical resolution  }
		devHRes:				INTEGER;								{  Device horizontal resolution  }
		devPage:				Rect;									{  Device page size  }
																		{  prXInfo subrecord  }
		actualCopies:			INTEGER;								{  Actual number of copies for this job  }
		options:				INTEGER;								{  Options for this device  }
		reduction:				INTEGER;								{  Reduce/enlarge factor  }
		orientation:			SInt8;									{  Orientation of paper ( 0=portrait, 1=landscape )  }
																		{  Clusters and PopUps  }
		qualityMode:			SInt8;									{  Quality mode  }
		coverPage:				SInt8;									{  Cover page  }
		firstTray:				SInt8;									{  First feed tray  }
		remainingTray:			SInt8;									{  Remaining feed tray  }
		headMotion:				SInt8;									{  Head motion  }
		saveFile:				SInt8;									{  Save file  }
		userCluster1:			SInt8;									{  Three clusters left over  }
		userCluster2:			SInt8;
		userCluster3:			SInt8;
																		{  prJob subrecord  }
		firstPage:				INTEGER;								{  First page  }
		lastPage:				INTEGER;								{  Last page  }
		copies:					INTEGER;								{  Number of copies, always 1  }
		reserved1:				SInt8;									{  Always true, unused  }
		reserved2:				SInt8;									{  Always true, unused  }
		pIdleProc:				PrIdleUPP;								{  Idle proc  }
		pFileName:				Ptr;									{  Spool file name pointer  }
		fileVol:				INTEGER;								{  Spool file vRefNum  }
		fileVers:				SInt8;									{  File version, must be 0  }
		reserved3:				SInt8;									{  Always 0  }
		printX:					ARRAY [0..18] OF INTEGER;				{  Internal use  }
	END;

	gxUniversalPrintRecordHdl			= ^gxUniversalPrintRecordPtr;

{ ------------------------------------------------------------------------------

                            Compatibility Printing Messages

-------------------------------------------------------------------------------- }

{ ------------------------------------------------------------------------------

                        Raster Driver Contants and Types

-------------------------------------------------------------------------------- }
	gxRasterPlaneOptions				= LONGINT;
{ Input structure for setting up the offscreen }
	gxPlaneSetupRecPtr = ^gxPlaneSetupRec;
	gxPlaneSetupRec = RECORD
		planeOptions:			gxRasterPlaneOptions;					{  Options for the offscreen package  }
		planeHalftone:			gxHalftone;								{  OPTIONAL: halftone structure for this plane  }
		planeSpace:				gxColorSpace;							{  OPTIONAL: noSpace will get the graphics default  }
		planeSet:				gxColorSet;								{  OPTIONAL: NIL gets the default  }
		planeProfile:			gxColorProfile;							{  OPTIONAL: NIL gets no matching  }
	END;

{ Constants for planeOptions field in gxPlaneSetupRec }

CONST
	gxDefaultOffscreen			= $00000000;					{  Default value - bits are allocated for the client, halftoning takes place  }
	gxDontSetHalftone			= $00000001;					{  Don't call SetViewPortHalftone  }
	gxDotTypeIsDitherLevel		= $00000002;					{  Call SetViewPortDither using the dotType as the level  }



TYPE
	gxOffscreenSetupRecPtr = ^gxOffscreenSetupRec;
	gxOffscreenSetupRec = RECORD
		width:					INTEGER;								{  Width in pixels  }
		minHeight:				INTEGER;								{  Minimum height in pixels - actual height returned here  }
		maxHeight:				INTEGER;								{  Maximum height in pixels  }
		ramPercentage:			Fixed;									{  Maximum percentage of RAM to take  }
		ramSlop:				LONGINT;								{  Amount of RAM to be sure to leave  }
		depth:					INTEGER;								{  Depths in bits of each plane  }
		vpMapping:				gxMapping;								{  Mapping to assign to offscreen viewPorts  }
		vdMapping:				gxMapping;								{  Mapping to assign to offscreen viewDevices  }
		planes:					INTEGER;								{  Number of planes to allocate of depth bits each (can be more than 4)  }
		planeSetup:				ARRAY [0..3] OF gxPlaneSetupRec;		{  Parameters for each plane, 4 is provided because it is most handy for writers of devices  }
	END;


{ The format of one plane in the offscreen planar area }
	gxOffscreenPlaneRecPtr = ^gxOffscreenPlaneRec;
	gxOffscreenPlaneRec = RECORD
		theViewPort:			gxViewPort;								{  viewPort for the offscreen  }
		theDevice:				gxViewDevice;							{  viewDevice for the offscreen  }
		theViewGroup:			gxViewGroup;							{  The viewGroup that they share  }
		theBitmap:				gxShape;								{  The offscreen bitmap shape  }
		theBits:				gxBitmap;								{  The bits of the offscreen  }
	END;


{ The format of an entire offscreen area }
	gxOffscreenRecPtr = ^gxOffscreenRec;
	gxOffscreenRec = RECORD
		numberOfPlanes:			INTEGER;								{  Number of planes we have  }
		offscreenStorage:		Handle;									{  Handle containing the bitmaps image data  }
		thePlanes:				ARRAY [0..0] OF gxOffscreenPlaneRec;	{  Planes to draw in  }
	END;

	gxOffscreenPtr						= ^gxOffscreenRec;
	gxOffscreenHdl						= ^gxOffscreenPtr;
	gxRasterRenderOptions				= LONGINT;
{ Structure that mirrors 'rdip' resource. }
	gxRasterPrefsRecPtr = ^gxRasterPrefsRec;
	gxRasterPrefsRec = RECORD
		renderOptions:			gxRasterRenderOptions;					{  Options for the raster imaging system  }
		hImageRes:				Fixed;									{  Horizontal resolution to image at  }
		vImageRes:				Fixed;									{  Vertical resolution to image at  }
		minBandSize:			INTEGER;								{  Minimum band size to use (in pixels)  }
		maxBandSize:			INTEGER;								{  Maximum band size to use (in pixels), 0 == entire page  }
		ramPercentage:			Fixed;									{  Maximum percentage of RAM to take  }
		ramSlop:				LONGINT;								{  Amount of RAM to be sure to leave  }
		depth:					INTEGER;								{  Depth in pixels (PER PLANE!)  }
		numPlanes:				INTEGER;								{  Number of planes to render  }
		planeSetup:				ARRAY [0..0] OF gxPlaneSetupRec;		{  One for each plane  }
	END;

{ Constants for renderOptions field in gxRasterPrefsRec. }

CONST
	gxDefaultRaster				= $00000000;					{  Default raster options  }
	gxDontResolveTransferModes	= $00000001;					{  0=Resolve, 1=Don't Resolve  }
	gxRenderInReverse			= $00000002;					{  Traverse image in reverse order  }
	gxOnePlaneAtATime			= $00000004;					{  Render each plane separately  }
	gxSendAllBands				= $00000008;					{  Send even empty bands  }


TYPE
	gxRasterPrefsPtr					= ^gxRasterPrefsRec;
	gxRasterPrefsHdl					= ^gxRasterPrefsPtr;
	gxRasterPackageOptions				= LONGINT;
{ Structure that mirrors 'rpck' resource. }
	gxRasterPackageRecPtr = ^gxRasterPackageRec;
	gxRasterPackageRec = RECORD
		bufferSize:				Ptr;									{  Buffer size for packaging (>= maximum head pass size)  }
		colorPasses:			INTEGER;								{  1 (b/w) or 4 (CMYK) is typical  }
		headHeight:				INTEGER;								{  Printhead height in pixels  }
		numberPasses:			INTEGER;								{  Number of head passes it takes to == iHeadHeight  }
		passOffset:				INTEGER;								{  Offset between passes, in pixels  }
		packageOptions:			gxRasterPackageOptions;					{  Packaging options  }
	END;

	gxRasterPackagePtr					= ^gxRasterPackageRec;
	gxRasterPackageHdl					= ^gxRasterPackagePtr;
{ Constants for packageOptions field in gxRasterPackageRec. }

CONST
	gxSendAllColors				= $00000001;					{  Send even clean bands through  }
	gxInterlaceColor			= $00000002;					{  Ribbon contamination is a concern  }
	gxOverlayColor				= $00000004;					{  Color printer without a ribbon problem  }
	gxUseColor					= $00000006;					{  This is a color printer  }


{ Structure for RasterPackageBitmap message }

TYPE
	gxRasterPackageBitmapRecPtr = ^gxRasterPackageBitmapRec;
	gxRasterPackageBitmapRec = RECORD
		bitmapToPackage:		gxBitmapPtr;							{  Bitmap containing the data to package  }
		startRaster:			UInt16;									{  Raster to begin the packaging from  }
		colorBand:				UInt16;									{  For which color pass this is a packaging request  }
		isBandDirty:			BOOLEAN;								{  Whether there are any dirty bits in this band  }
		padByte:				SInt8;
		dirtyRect:				Rect;									{  Which bits are dirty  }
	END;


{ Structure of number record in gxRasterPackageControlsRec }
	gxStandardNumberRecPtr = ^gxStandardNumberRec;
	gxStandardNumberRec = RECORD
		numberType:				INTEGER;								{  Type of numberic output desired  }
		minWidth:				INTEGER;								{  Minimum output width of the number  }
		padChar:				SInt8;									{  Pad character for numbers shorter than the minWidth  }
		padChar2:				SInt8;
		startString:			Str31;									{  Prefix string  }
		endString:				Str31;									{  Postfix string  }
	END;

	gxStandardNumberPtr					= ^gxStandardNumberRec;
{ Structure that mirrors 'ropt' resource }
	gxRasterPackageControlsRecPtr = ^gxRasterPackageControlsRec;
	gxRasterPackageControlsRec = RECORD
		startPageStringID:		INTEGER;								{  'wstr' to send to the device at start of page  }
		formFeedStringID:		INTEGER;								{  'wstr' to send to the device to cause a form feed  }
		forwardMax:				INTEGER;								{  Line feed strings  }
		forwardLineFeed:		gxStandardNumberRec;					{  Number record for forward line feed  }
		reverseMax:				INTEGER;								{  Max number of reverse line feeds device can do  }
		reverseLineFeed:		gxStandardNumberRec;					{  Number record for forward line feed  }
	END;

	gxRasterPackageControlsPtr			= ^gxRasterPackageControlsRec;
	gxRasterPackageControlsHdl			= ^gxRasterPackageControlsPtr;
{ Raster imaging system imageData structure }
	gxRasterImageDataRecPtr = ^gxRasterImageDataRec;
	gxRasterImageDataRec = RECORD
		renderOptions:			gxRasterRenderOptions;					{  Options for the raster imaging system  }
		hImageRes:				Fixed;									{  horizontal resolution to image at  }
		vImageRes:				Fixed;									{  vertical resolution to image at  }
		minBandSize:			INTEGER;								{  smallest band that makes sense for this device  }
		maxBandSize:			INTEGER;								{  biggest band that makes sense, or 0 for "full page"  }
		pageSize:				gxRectangle;							{  size of page for device  }
																		{  Values used within the RasterDataIn message  }
		currentYPos:			INTEGER;								{  Current position moving down the page  }
		packagingInfo:			gxRasterPackageRec;						{  Raster packaging record  }
																		{  Values used within the remaining messages  }
		optionsValid:			BOOLEAN;								{  Were options specified by the driver?  }
		padByte:				SInt8;
		packageControls:		gxRasterPackageControlsRec;				{  Options for the packaging messages  }
		theSetup:				gxOffscreenSetupRec;					{  setup for the offscreen code, variable length componant  }
	END;

	gxRasterImageDataPtr				= ^gxRasterImageDataRec;
	gxRasterImageDataHdl				= ^gxRasterImageDataPtr;
{ ------------------------------------------------------------------------------

                                Raster Driver Imaging Messages

-------------------------------------------------------------------------------- }

{ ------------------------------------------------------------------------------

                        Vector Driver Contants and Types

-------------------------------------------------------------------------------- }
{ Vector device halftone component record }
	gxVHalftoneCompRecPtr = ^gxVHalftoneCompRec;
	gxVHalftoneCompRec = RECORD
		angle:					Fixed;									{  Angle to halftone at. Must be 0, 90, 45 or 135  }
		penIndex:				LONGINT;								{  index of the pen to draw this component with  }
	END;


{ Vector device halftone record }
	gxVHalftoneRecPtr = ^gxVHalftoneRec;
	gxVHalftoneRec = RECORD
		halftoneSpace:			gxColorSpace;
		halftoneComps:			ARRAY [0..3] OF gxVHalftoneCompRec;		{  Info for each color component  }
		penIndexForBW:			LONGINT;								{  Pen index to draw one bit deep or black and white bitmap with  }
	END;


{ Vector shape rendering information }
	gxVectorShapeOptions				= LONGINT;
	gxVectorShapeDataRecPtr = ^gxVectorShapeDataRec;
	gxVectorShapeDataRec = RECORD
		shapeOptions:			gxVectorShapeOptions;					{  Options to control shape handling  }
		maxPolyPoints:			LONGINT;								{  Maximum number of polygon points that device can support  }
		shapeError:				Fixed;									{  Defines allowed deviation from the original shape  }
		textSize:				Fixed;									{  Text above this size is filled; text below this size is outlined  }
		frameSize:				Fixed;									{  Frame's smaller than this -> shape stroked; frame's larger -> shape is filled  }
	END;


{ Constants for shapeOptions field in gxVectorShapeDataRec. }

CONST
	gxUnidirectionalFill		= $00000001;					{  Generate scanlines in one direction only.  Useful for transparencies  }
	gxAlsoOutlineFilledShape	= $00000002;					{  Turn on this bit to also outline solid filled shapes  }


{ Vector device rendering information }

TYPE
	gxVectorRenderOptions				= LONGINT;
{ Vector imaging system imageData structure }
	gxVectorImageDataRecPtr = ^gxVectorImageDataRec;
	gxVectorImageDataRec = RECORD
		renderOptions:			gxVectorRenderOptions;					{  Options to control rendering: color sort, clipping, etc.  }
		devRes:					Fixed;									{  Device resolution  }
		devTransform:			gxTransform;							{  Mapping, clip and halftoning information for colored bitmaps  }
		clrSet:					gxColorSet;								{  Entire set of colors; usually indexed color space for pen plotters  }
		bgColor:				gxColor;								{  The background color in the color space specified by the clrSpace field  }
		halftoneInfo:			gxVHalftoneRec;							{  Defines halftone information for color bitmaps  }
		hPenTable:				gxPenTableHdl;							{  Complete list of pens along with their pen positions and thickness  }
		pageRect:				gxRectangle;							{  Page dimensions  }
		shapeData:				gxVectorShapeDataRec;					{  Information on how to render a shape  }
	END;

	gxVectorImageDataPtr				= ^gxVectorImageDataRec;
	gxVectorImageDataHdl				= ^gxVectorImageDataPtr;
{ Constants for renderOptions field in gxVectorImageDataRec. }

CONST
	gxColorSort					= $00000001;					{  Set for pen plotters  }
	gxATransferMode				= $00000002;					{  Set if transfer modes need to be resolved  }
	gxNoOverlap					= $00000004;					{  Set if non-overlapping output is desired }
	gxAColorBitmap				= $00000008;					{  Set if color bitmap output is desired  }
	gxSortbyPenPos				= $00000010;					{  Set if shapes are to be drawn in the order of the pen index  }
																{  in the pen table. NOTE: this is not the pen position in the carousel  }
	gxPenLessPlotter			= $00000020;					{  Indicates raster printer/plotter  }
	gxCutterPlotter				= $00000040;					{  Indicates cutter  }
	gxNoBackGround				= $00000080;					{  Set if shapes that map to the background color should not be sent to driver  }


{ ------------------------------------------------------------------------------

                                Vector Driver Imaging Messages

-------------------------------------------------------------------------------- }

{ ------------------------------------------------------------------------------

                            PostScript Driver Contants and Types

-------------------------------------------------------------------------------- }
	gxPostSynonym				= 'post';

{ PostScript glyphs record }

TYPE
	gxPrinterGlyphsRecPtr = ^gxPrinterGlyphsRec;
	gxPrinterGlyphsRec = RECORD
		theFont:				gxFont;									{   ---> Font reference  }
		nGlyphs:				LONGINT;								{   ---> Number of glyphs in the font  }
		platform:				gxFontPlatform;							{  <---  How printer font is encoded  }
		script:					gxFontScript;							{  <---  Script if platform != glyphPlatform  }
		language:				gxFontLanguage;							{  <---  Language if platform != glyphPlatform  }
		vmUsage:				LONGINT;								{  <---  How much PostScript VM font uses  }
																		{  Size of this array is long-alligned(nGlyphs)  }
		glyphBits:				ARRAY [0..0] OF UInt32;					{  <---  Bit array of which system glyphs are in printer  }
	END;


{ PostScript device rendering information }
	gxPostScriptRenderOptions			= LONGINT;
	gxPostScriptImageDataRecPtr = ^gxPostScriptImageDataRec;
	gxPostScriptImageDataRec = RECORD
		languageLevel:			INTEGER;								{  PostScript language level  }
		devCSpace:				gxColorSpace;							{  The printer's color space  }
		devCProfile:			gxColorProfile;							{  The printer's color profile for matching  }
		renderOptions:			gxPostScriptRenderOptions;				{  Options for the imaging system  }
		pathLimit:				LONGINT;								{  Maximum path size  }
		gsaveLimit:				INTEGER;								{  Maximum number of gsaves allowed  }
		opStackLimit:			INTEGER;								{  Operand stack limit  }
		fontType:				scalerStreamTypeFlag;					{  These are the font types that the printer supports   }
		printerVM:				LONGINT;								{  How much memory is in the printer  }
		reserved0:				LONGINT;
	END;

	gxPostScriptImageDataPtr			= ^gxPostScriptImageDataRec;
	gxPostScriptImageDataHdl			= ^gxPostScriptImageDataPtr;
{ Constants for renderOptions field in gxPostScriptImageDataRec. }

CONST
	gxNeedsHexOption			= $00000001;					{  Convert all binary data to hex  }
	gxNeedsCommentsOption		= $00000002;					{  Issue PostScript comments  }
	gxBoundingBoxesOption		= $00000004;					{  Calculate the values for  }
	gxPortablePostScriptOption	= $00000008;					{  Generate portable PostScript  }
	gxTextClipsToPathOption		= $00000010;					{  Convert all clips that are composed of text to path shapes  }
	gxFlattenClipPathOption		= $00000020;					{  Convert all clips that are path shapes to polygons (helps better control point limit)  }
	gxUseCharpath1Option		= $00000040;					{  (ignored if text clips are converted to paths)  When the clip is text,   }
																{  Do it one glyph at a time, redrawing the main shape each time  }
	gxUseLevel2ColorOption		= $00000080;					{  When printing to level-2 use level-2 device independent color  }
	gxNoEPSIllegalOperators		= $00000100;					{  Don't use any operators prohibited by the Encapsulated PostScript File Format V3.0  }
	gxEPSTargetOption			= $00000106;					{  PostScript intended for EPS Use.  }
	gxPageIndependentPostScript	= $00000200;					{  Don't generate PostScript with page interdependencies  }


{ Structure for gxPostScriptGetProcSetList / gxPostScriptDownLoadProcSetList }

TYPE
	gxProcSetListRecPtr = ^gxProcSetListRec;
	gxProcSetListRec = RECORD
		clientid:				gxOwnerSignature;
		controlType:			OSType;									{  The driver will call FetchTaggedData on each of these resources  }
		controlid:				INTEGER;
		dataType:				OSType;
		reserved0:				LONGINT;
	END;

	gxProcSetListPtr					= ^gxProcSetListRec;
	gxProcSetListHdl					= ^gxProcSetListPtr;
{ Possible results of querying printer (returned by gxPostScriptQueryPrinter message) }

CONST
	gxPrinterOK					= 0;
	gxIntializePrinter			= 1;
	gxFilePrinting				= 2;
	gxResetPrinter				= 128;


{ ------------------------------------------------------------------------------

                                PostScript Driver Imaging Messages

-------------------------------------------------------------------------------- }
{ Device control messages }
{ Device communication messages }
{ Proc set management messages }
{ Font management messages }
{ Document structuring and formatting messages }
{ Page structuring and formatting messages }
{ Shape imaging messages }
{ ------------------------------------------------------------------------------

                                            Driver API Functions

-------------------------------------------------------------------------------- }
{ Constants for printer gxViewDevice bitmaps. }
	gxMissingImagePointer		= -4;

{$IFC CALL_NOT_IN_CARBON }
FUNCTION GXAddPrinterViewDevice(thePrinter: gxPrinter; theViewDevice: gxViewDevice): OSErr; C;
FUNCTION GXGetAvailableJobFormatModes(VAR theFormatModes: gxJobFormatModeTableHdl): OSErr; C;
FUNCTION GXSetPreferredJobFormatMode(theFormatMode: gxJobFormatMode; directOnly: BOOLEAN): OSErr; C;
FUNCTION GXPrintingAlert(iconId: LONGINT; txtSize: LONGINT; defaultTitleNum: LONGINT; cancelTitleNum: LONGINT; textLength: LONGINT; pAlertMsg: Ptr; actionTitle: StringPtr; title2: StringPtr; title3: StringPtr; msgFont: StringPtr; filterProc: ModalFilterUPP; VAR itemHit: INTEGER; alertTitle: StringPtr): OSErr; C;
FUNCTION GXGetPrintingAlert(alertResId: LONGINT; filterProc: ModalFilterUPP; VAR itemHit: INTEGER): OSErr; C;

FUNCTION GXFetchDTPData(VAR dtpName: Str31; theType: OSType; theID: LONGINT; VAR theData: Handle): OSErr; C;
FUNCTION GXWriteDTPData(VAR dtpName: Str31; theType: OSType; theID: LONGINT; theData: Handle): OSErr; C;
FUNCTION GXHandleChooserMessage(VAR aJob: gxJob; VAR driverName: Str31; message: LONGINT; caller: LONGINT; objName: StringPtr; zoneName: StringPtr; theList: ListHandle; p2: LONGINT): OSErr; C;
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXPrinterDriversIncludes}

{$ENDC} {__GXPRINTERDRIVERS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
