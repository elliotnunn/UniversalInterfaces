{
 	File:		Printing.p
 
 	Contains:	Print Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Printing;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PRINTING__}
{$SETC __PRINTING__ := 1}

{$I+}
{$SETC PrintingIncludes := UsingIncludes}
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


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	iPFMaxPgs					= 128;
	iPrPgFract					= 120;							{ Page scale factor. ptPgSize (below) is in units of 1/iPrPgFract }
	iPrPgFst					= 1;							{ Page range constants }
	iPrPgMax					= 9999;
	iPrRelease					= 3;							{ Current version number of the code. }
	iPrSavPFil					= -1;
	iPrAbort					= $0080;
	iPrDevCtl					= 7;							{ The PrDevCtl Proc's ctl number }
	lPrReset					= $00010000;					{ The PrDevCtl Proc's CParam for reset }
	lPrLineFeed					= $00030000;
	lPrLFStd					= $0003FFFF;					{ The PrDevCtl Proc's CParam for std paper advance }
	lPrLFSixth					= $0003FFFF;
	lPrPageEnd					= $00020000;					{ The PrDevCtl Proc's CParam for end page }
	lPrDocOpen					= $00010000;
	lPrPageOpen					= $00040000;
	lPrPageClose				= $00020000;
	lPrDocClose					= $00050000;
	iFMgrCtl					= 8;							{ The FMgr's Tail-hook Proc's ctl number }
	iMscCtl						= 9;							{ The FMgr's Tail-hook Proc's ctl number }
	iPvtCtl						= 10;							{ The FMgr's Tail-hook Proc's ctl number }

{	Error Codes moved to Errors.(hap) }
	pPrGlobals					= $00000944;					{ The PrVars lo mem area: }
	bDraftLoop					= 0;
	bSpoolLoop					= 1;
	bUser1Loop					= 2;
	bUser2Loop					= 3;
	fNewRunBit					= 2;
	fHiResOK					= 3;
	fWeOpenedRF					= 4;							{ Driver constants  }
	iPrBitsCtl					= 4;
	lScreenBits					= 0;
	lPaintBits					= 1;
	lHiScreenBits				= $00000002;					{ The Bitmap Print Proc's Screen Bitmap param }
	lHiPaintBits				= $00000003;					{ The Bitmap Print Proc's Paint [sq pix] param }
	iPrIOCtl					= 5;
	iPrEvtCtl					= 6;							{ The PrEvent Proc's ctl number }
	lPrEvtAll					= $0002FFFD;					{ The PrEvent Proc's CParam for the entire screen }
	lPrEvtTop					= $0001FFFD;					{ The PrEvent Proc's CParam for the top folder }
	iPrDrvrRef					= -3;

	getRslDataOp				= 4;
	setRslOp					= 5;
	draftBitsOp					= 6;
	noDraftBitsOp				= 7;
	getRotnOp					= 8;
	NoSuchRsl					= 1;
	OpNotImpl					= 2;							{ the driver doesn't support this opcode }
	RgType1						= 1;

	feedCut						= 0;
	feedFanfold					= 1;
	feedMechCut					= 2;
	feedOther					= 3;


TYPE
	TFeed								= SInt8;

CONST
	scanTB						= 0;
	scanBT						= 1;
	scanLR						= 2;
	scanRL						= 3;


TYPE
	TScan								= SInt8;
{ A Rect Ptr }
	TPRect								= ^Rect;
	PrIdleProcPtr = ProcPtr;  { PROCEDURE PrIdle; }

	PItemProcPtr = ProcPtr;  { PROCEDURE PItem(theDialog: DialogPtr; item: INTEGER); }

	PrIdleUPP = UniversalProcPtr;
	PItemUPP = UniversalProcPtr;

CONST
	uppPrIdleProcInfo = $00000000;
	uppPItemProcInfo = $000002C0;

FUNCTION NewPrIdleProc(userRoutine: PrIdleProcPtr): PrIdleUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPItemProc(userRoutine: PItemProcPtr): PItemUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallPrIdleProc(userRoutine: PrIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallPItemProc(theDialog: DialogPtr; item: INTEGER; userRoutine: PItemUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	TPrPortPtr = ^TPrPort;
	TPrPort = RECORD
		gPort:					GrafPort;								{ The Printer's graf port. }
		gProcs:					QDProcs;								{ ..and its procs }
		lGParam1:				LONGINT;								{ 16 bytes for private parameter storage. }
		lGParam2:				LONGINT;
		lGParam3:				LONGINT;
		lGParam4:				LONGINT;
		fOurPtr:				BOOLEAN;								{ Whether the PrPort allocation was done by us. }
		fOurBits:				BOOLEAN;								{ Whether the BitMap allocation was done by us. }
	END;

	TPPrPort							= ^TPrPort;
	TPPrPortRef							= ^TPrPort;
{ Printing Graf Port. All printer imaging, whether spooling, banding, etc, happens "thru" a GrafPort.
  This is the "PrPeek" record. }
	TPrInfoPtr = ^TPrInfo;
	TPrInfo = RECORD
		iDev:					INTEGER;								{ Font mgr/QuickDraw device code }
		iVRes:					INTEGER;								{ Resolution of device, in device coordinates }
		iHRes:					INTEGER;								{ ..note: V before H => compatable with Point. }
		rPage:					Rect;									{ The page (printable) rectangle in device coordinates. }
	END;

	TPPrInfo							= ^TPrInfo;
{ Print Info Record: The parameters needed for page composition. }
	TPrStlPtr = ^TPrStl;
	TPrStl = RECORD
		wDev:					INTEGER;
		iPageV:					INTEGER;
		iPageH:					INTEGER;
		bPort:					SInt8;
		feed:					TFeed;
	END;

	TPPrStl								= ^TPrStl;
	TPrXInfoPtr = ^TPrXInfo;
	TPrXInfo = RECORD
		iRowBytes:				INTEGER;
		iBandV:					INTEGER;
		iBandH:					INTEGER;
		iDevBytes:				INTEGER;
		iBands:					INTEGER;
		bPatScale:				SInt8;
		bUlThick:				SInt8;
		bUlOffset:				SInt8;
		bUlShadow:				SInt8;
		scan:					TScan;
		bXInfoX:				SInt8;
	END;

	TPPrXInfo							= ^TPrXInfo;
	TPrJobPtr = ^TPrJob;
	TPrJob = RECORD
		iFstPage:				INTEGER;								{ Page Range. }
		iLstPage:				INTEGER;
		iCopies:				INTEGER;								{ No. copies. }
		bJDocLoop:				SInt8;									{ The Doc style: Draft, Spool, .., and .. }
		fFromUsr:				BOOLEAN;								{ Printing from an User's App (not PrApp) flag }
		pIdleProc:				PrIdleUPP;								{ The Proc called while waiting on IO etc. }
		pFileName:				StringPtr;								{ Spool File Name: NIL for default. }
		iFileVol:				INTEGER;								{ Spool File vol, set to 0 initially }
		bFileVers:				SInt8;									{ Spool File version, set to 0 initially }
		bJobX:					SInt8;									{ An eXtra byte. }
	END;

	TPPrJob								= ^TPrJob;
{ Print Job: Print "form" for a single print request. }
	TPrFlag1Ptr = ^TPrFlag1;
	TPrFlag1 = PACKED RECORD
		f15:					BOOLEAN;
		f14:					BOOLEAN;
		f13:					BOOLEAN;
		f12:					BOOLEAN;
		f11:					BOOLEAN;
		f10:					BOOLEAN;
		f9:						BOOLEAN;
		f8:						BOOLEAN;
		f7:						BOOLEAN;
		f6:						BOOLEAN;
		f5:						BOOLEAN;
		f4:						BOOLEAN;
		f3:						BOOLEAN;
		f2:						BOOLEAN;
		fLstPgFst:				BOOLEAN;
		fUserScale:				BOOLEAN;
	END;

	TPrintPtr = ^TPrint;
	TPrint = RECORD
		iPrVersion:				INTEGER;								{ (2) Printing software version }
		prInfo:					TPrInfo;								{ (14) the PrInfo data associated with the current style. }
		rPaper:					Rect;									{ (8) The paper rectangle [offset from rPage] }
		prStl:					TPrStl;									{ (8)  This print request's style. }
		prInfoPT:				TPrInfo;								{ (14)  Print Time Imaging metrics }
		prXInfo:				TPrXInfo;								{ (16)  Print-time (expanded) Print info record. }
		prJob:					TPrJob;									{ (20) The Print Job request (82)  Total of the above; 120-82 = 38 bytes needed to fill 120 }
		CASE INTEGER OF
		0: (
			printX:				ARRAY [1..19] OF INTEGER;
			);
		1: (
			prFlag1:			TPrFlag1;
			iZoomMin:			INTEGER;
			iZoomMax:			INTEGER;
			hDocName:			StringHandle;
		   );
	END;

	TPPrint								= ^TPrint;
	THPrint								= ^TPPrint;
	TPrStatusPtr = ^TPrStatus;
	TPrStatus = RECORD
		iTotPages:				INTEGER;								{ Total pages in Print File. }
		iCurPage:				INTEGER;								{ Current page number }
		iTotCopies:				INTEGER;								{ Total copies requested }
		iCurCopy:				INTEGER;								{ Current copy number }
		iTotBands:				INTEGER;								{ Total bands per page. }
		iCurBand:				INTEGER;								{ Current band number }
		fPgDirty:				BOOLEAN;								{ True if current page has been written to. }
		fImaging:				BOOLEAN;								{ Set while in band's DrawPic call. }
		hPrint:					THPrint;								{ Handle to the active Printer record }
		pPrPort:				TPPrPortRef;							{ Ptr to the active PrPort }
		hPic:					PicHandle;								{ Handle to the active Picture }
	END;

	TPPrStatus							= ^TPrStatus;
	TPPrStatusRef						= ^TPrStatus;

{ Print Status: Print information during printing. }
	TPfPgDirPtr = ^TPfPgDir;
	TPfPgDir = RECORD
		iPages:					INTEGER;
		iPgPos:					ARRAY [0..128] OF LONGINT;				{ ARRAY [0..iPfMaxPgs] OF LONGINT }
	END;

	TPPfPgDir							= ^TPfPgDir;
	THPfPgDir							= ^TPPfPgDir;
{ PicFile = a TPfHeader followed by n QuickDraw Pics (whose PicSize is invalid!) }
{ This is the Printing Dialog Record. Only used by folks appending their own
   DITLs to the print dialogs.	Print Dialog: The Dialog Stream object. }
	TPrDlgPtr = ^TPrDlg;
	TPrDlg = RECORD
		Dlg:					DialogRecord;							{ The Dialog window }
		pFltrProc:				ModalFilterUPP;							{ The Filter Proc. }
		pItemProc:				PItemUPP;								{ The Item evaluating proc. }
		hPrintUsr:				THPrint;								{ The user's print record. }
		fDoIt:					BOOLEAN;
		fDone:					BOOLEAN;
		lUser1:					LONGINT;								{ Four longs for apps to hang global data. }
		lUser2:					LONGINT;								{ Plus more stuff needed by the particular }
		lUser3:					LONGINT;								{ printing dialog. }
		lUser4:					LONGINT;
	END;

	TPPrDlg								= ^TPrDlg;
	TPPrDlgRef							= ^TPrDlg;
	PDlgInitProcPtr = ProcPtr;  { FUNCTION PDlgInit(hPrint: THPrint): TPPrDlgRef; }

	PDlgInitUPP = UniversalProcPtr;

CONST
	uppPDlgInitProcInfo = $000000F0;

FUNCTION NewPDlgInitProc(userRoutine: PDlgInitProcPtr): PDlgInitUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallPDlgInitProc(hPrint: THPrint; userRoutine: PDlgInitUPP): TPPrDlgRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	TGnlDataPtr = ^TGnlData;
	TGnlData = RECORD
		iOpCode:				INTEGER;
		iError:					INTEGER;
		lReserved:				LONGINT;								{ more fields here depending on call }
	END;

	TRslRgPtr = ^TRslRg;
	TRslRg = RECORD
		iMin:					INTEGER;
		iMax:					INTEGER;
	END;

	TRslRecPtr = ^TRslRec;
	TRslRec = RECORD
		iXRsl:					INTEGER;
		iYRsl:					INTEGER;
	END;

	TGetRslBlkPtr = ^TGetRslBlk;
	TGetRslBlk = RECORD
		iOpCode:				INTEGER;
		iError:					INTEGER;
		lReserved:				LONGINT;
		iRgType:				INTEGER;
		xRslRg:					TRslRg;
		yRslRg:					TRslRg;
		iRslRecCnt:				INTEGER;
		rgRslRec:				ARRAY [1..27] OF TRslRec;
	END;

	TSetRslBlkPtr = ^TSetRslBlk;
	TSetRslBlk = RECORD
		iOpCode:				INTEGER;
		iError:					INTEGER;
		lReserved:				LONGINT;
		hPrint:					THPrint;
		iXRsl:					INTEGER;
		iYRsl:					INTEGER;
	END;

	TDftBitsBlkPtr = ^TDftBitsBlk;
	TDftBitsBlk = RECORD
		iOpCode:				INTEGER;
		iError:					INTEGER;
		lReserved:				LONGINT;
		hPrint:					THPrint;
	END;

	TGetRotnBlkPtr = ^TGetRotnBlk;
	TGetRotnBlk = RECORD
		iOpCode:				INTEGER;
		iError:					INTEGER;
		lReserved:				LONGINT;
		hPrint:					THPrint;
		fLandscape:				BOOLEAN;
		bXtra:					SInt8;
	END;

PROCEDURE PrPurge;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $A800, $0000, $A8FD;
	{$ENDC}
PROCEDURE PrNoPurge;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $B000, $0000, $A8FD;
	{$ENDC}
PROCEDURE PrOpen;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $C800, $0000, $A8FD;
	{$ENDC}
PROCEDURE PrClose;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $D000, $0000, $A8FD;
	{$ENDC}
PROCEDURE PrintDefault(hPrint: THPrint);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $2004, $0480, $A8FD;
	{$ENDC}
FUNCTION PrValidate(hPrint: THPrint): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $5204, $0498, $A8FD;
	{$ENDC}
FUNCTION PrStlDialog(hPrint: THPrint): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $2A04, $0484, $A8FD;
	{$ENDC}
FUNCTION PrJobDialog(hPrint: THPrint): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $3204, $0488, $A8FD;
	{$ENDC}
FUNCTION PrStlInit(hPrint: THPrint): TPPrDlgRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $3C04, $040C, $A8FD;
	{$ENDC}
FUNCTION PrJobInit(hPrint: THPrint): TPPrDlgRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $4404, $0410, $A8FD;
	{$ENDC}
PROCEDURE PrJobMerge(hPrintSrc: THPrint; hPrintDst: THPrint);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $5804, $089C, $A8FD;
	{$ENDC}
FUNCTION PrDlgMain(hPrint: THPrint; pDlgInit: PDlgInitUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $4A04, $0894, $A8FD;
	{$ENDC}
FUNCTION PrOpenDoc(hPrint: THPrint; pPrPort: TPPrPortRef; pIOBuf: Ptr): TPPrPortRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0400, $0C00, $A8FD;
	{$ENDC}
PROCEDURE PrCloseDoc(pPrPort: TPPrPortRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0800, $0484, $A8FD;
	{$ENDC}
PROCEDURE PrOpenPage(pPrPort: TPPrPortRef; pPageFrame: TPRect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $1000, $0808, $A8FD;
	{$ENDC}
PROCEDURE PrClosePage(pPrPort: TPPrPortRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $1800, $040C, $A8FD;
	{$ENDC}
PROCEDURE PrPicFile(hPrint: THPrint; pPrPort: TPPrPortRef; pIOBuf: Ptr; pDevBuf: Ptr; prStatus: TPPrStatusRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $6005, $1480, $A8FD;
	{$ENDC}
FUNCTION PrError: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $BA00, $0000, $A8FD;
	{$ENDC}
PROCEDURE PrSetError(iErr: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $C000, $0200, $A8FD;
	{$ENDC}
PROCEDURE PrGeneral(pData: Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $7007, $0480, $A8FD;
	{$ENDC}
PROCEDURE PrDrvrOpen;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8000, $0000, $A8FD;
	{$ENDC}
PROCEDURE PrDrvrClose;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8800, $0000, $A8FD;
	{$ENDC}
PROCEDURE PrCtlCall(iWhichCtl: INTEGER; lParam1: LONGINT; lParam2: LONGINT; lParam3: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $A000, $0E00, $A8FD;
	{$ENDC}
FUNCTION PrDrvrDCE: Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $9400, $0000, $A8FD;
	{$ENDC}
FUNCTION PrDrvrVers: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $9A00, $0000, $A8FD;
	{$ENDC}
FUNCTION PrLoadDriver: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $D800, $0000, $A8FD;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PrintingIncludes}

{$ENDC} {__PRINTING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}