{
     File:       DrawSprocket.p
 
     Contains:   Games Sprockets: DrawSprocket interfaces
 
     Version:    Technology: Draw Sprocket 1.7
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1996-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT DrawSprocket;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DRAWSPROCKET__}
{$SETC __DRAWSPROCKET__ := 1}

{$I+}
{$SETC DrawSprocketIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __QDOFFSCREEN__}
{$I QDOffscreen.p}
{$ENDC}
{$IFC UNDEFINED __DISPLAYS__}
{$I Displays.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{
********************************************************************************
** constants
********************************************************************************
}

TYPE
	DSpDepthMask 				= SInt32;
CONST
	kDSpDepthMask_1				= $01;
	kDSpDepthMask_2				= $02;
	kDSpDepthMask_4				= $04;
	kDSpDepthMask_8				= $08;
	kDSpDepthMask_16			= $10;
	kDSpDepthMask_32			= $20;
	kDSpDepthMask_All			= -1;


TYPE
	DSpColorNeeds 				= SInt32;
CONST
	kDSpColorNeeds_DontCare		= 0;
	kDSpColorNeeds_Request		= 1;
	kDSpColorNeeds_Require		= 2;


TYPE
	DSpContextState 			= SInt32;
CONST
	kDSpContextState_Active		= 0;
	kDSpContextState_Paused		= 1;
	kDSpContextState_Inactive	= 2;

{ kDSpContextOption_QD3DAccel not yet implemented }

TYPE
	DSpContextOption 			= SInt32;
CONST
																{     kDSpContextOption_QD3DAccel       = 1<<0, }
	kDSpContextOption_PageFlip	= $02;
	kDSpContextOption_DontSyncVBL = $04;
	kDSpContextOption_Stereoscopic = $08;


TYPE
	DSpAltBufferOption 			= SInt32;
CONST
	kDSpAltBufferOption_RowBytesEqualsWidth = $01;


TYPE
	DSpBufferKind 				= SInt32;
CONST
	kDSpBufferKind_Normal		= 0;


TYPE
	DSpBlitMode 				= SInt32;
CONST
	kDSpBlitMode_Plain			= 0;
	kDSpBlitMode_SrcKey			= $01;
	kDSpBlitMode_DstKey			= $02;
	kDSpBlitMode_Interpolation	= $04;

{
********************************************************************************
** data types
********************************************************************************
}

TYPE
	DSpAltBufferReference = ^LONGINT; { an opaque 32-bit type }
	DSpContextReference = ^LONGINT; { an opaque 32-bit type }
{$IFC TYPED_FUNCTION_POINTERS}
	DSpEventProcPtr = FUNCTION(VAR inEvent: EventRecord): BOOLEAN; C;
{$ELSEC}
	DSpEventProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DSpCallbackProcPtr = FUNCTION(inContext: DSpContextReference; inRefCon: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	DSpCallbackProcPtr = ProcPtr;
{$ENDC}

	DSpContextAttributesPtr = ^DSpContextAttributes;
	DSpContextAttributes = RECORD
		frequency:				Fixed;
		displayWidth:			UInt32;
		displayHeight:			UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
		colorNeeds:				UInt32;
		colorTable:				CTabHandle;
		contextOptions:			OptionBits;
		backBufferDepthMask:	OptionBits;
		displayDepthMask:		OptionBits;
		backBufferBestDepth:	UInt32;
		displayBestDepth:		UInt32;
		pageCount:				UInt32;
		filler:					PACKED ARRAY [0..2] OF CHAR;
		gameMustConfirmSwitch:	BOOLEAN;
		reserved3:				ARRAY [0..3] OF UInt32;
	END;

	DSpAltBufferAttributesPtr = ^DSpAltBufferAttributes;
	DSpAltBufferAttributes = RECORD
		width:					UInt32;
		height:					UInt32;
		options:				DSpAltBufferOption;
		reserved:				ARRAY [0..3] OF UInt32;
	END;

	DSpBlitInfoPtr = ^DSpBlitInfo;
{$IFC TYPED_FUNCTION_POINTERS}
	DSpBlitDoneProc = PROCEDURE(info: DSpBlitInfoPtr); C;
{$ELSEC}
	DSpBlitDoneProc = ProcPtr;
{$ENDC}

	DSpBlitInfo = RECORD
		completionFlag:			BOOLEAN;
		filler:					PACKED ARRAY [0..2] OF CHAR;
		completionProc:			DSpBlitDoneProc;
		srcContext:				DSpContextReference;
		srcBuffer:				CGrafPtr;
		srcRect:				Rect;
		srcKey:					UInt32;
		dstContext:				DSpContextReference;
		dstBuffer:				CGrafPtr;
		dstRect:				Rect;
		dstKey:					UInt32;
		mode:					DSpBlitMode;
		reserved:				ARRAY [0..3] OF UInt32;
	END;

{
********************************************************************************
** function prototypes
********************************************************************************
}
{
    DrawSprocket is not in CarbonLib 1.0.2.  But, it is possible to still use 
    DrawSprocket on OS 8/9 in a CarbonLib based application, by setting  
    CALL_IN_SPOCKETS_BUT_NOT_IN_CARBON to 1 on the command line or in a prefix
    file, weaklinking with DrawSpocketLib, and testing for its existence 
    at runtime.
}
{$IFC UNDEFINED CALL_IN_SPOCKETS_BUT_NOT_IN_CARBON }
{$SETC CALL_IN_SPOCKETS_BUT_NOT_IN_CARBON := CALL_NOT_IN_CARBON }
{$ENDC}  {CALL_IN_SPOCKETS_BUT_NOT_IN_CARBON}


{
** global operations
}
{$IFC CALL_IN_SPOCKETS_BUT_NOT_IN_CARBON }
FUNCTION DSpStartup: OSStatus; C;
FUNCTION DSpShutdown: OSStatus; C;
FUNCTION DSpGetVersion: NumVersion; C;
FUNCTION DSpGetFirstContext(inDisplayID: DisplayIDType; VAR outContext: DSpContextReference): OSStatus; C;
FUNCTION DSpGetNextContext(inCurrentContext: DSpContextReference; VAR outContext: DSpContextReference): OSStatus; C;
FUNCTION DSpGetCurrentContext(inDisplayID: DisplayIDType; VAR outContext: DSpContextReference): OSStatus; C;
FUNCTION DSpFindBestContext(inDesiredAttributes: DSpContextAttributesPtr; VAR outContext: DSpContextReference): OSStatus; C;
FUNCTION DSpFindBestContextOnDisplayID(inDesiredAttributes: DSpContextAttributesPtr; VAR outContext: DSpContextReference; inDisplayID: DisplayIDType): OSStatus; C;
FUNCTION DSpCanUserSelectContext(inDesiredAttributes: DSpContextAttributesPtr; VAR outUserCanSelectContext: BOOLEAN): OSStatus; C;
FUNCTION DSpUserSelectContext(inDesiredAttributes: DSpContextAttributesPtr; inDialogDisplayLocation: DisplayIDType; inEventProc: DSpEventProcPtr; VAR outContext: DSpContextReference): OSStatus; C;
FUNCTION DSpProcessEvent(VAR inEvent: EventRecord; VAR outEventWasProcessed: BOOLEAN): OSStatus; C;
FUNCTION DSpSetBlankingColor({CONST}VAR inRGBColor: RGBColor): OSStatus; C;
FUNCTION DSpSetDebugMode(inDebugMode: BOOLEAN): OSStatus; C;
FUNCTION DSpFindContextFromPoint(inGlobalPoint: Point; VAR outContext: DSpContextReference): OSStatus; C;
FUNCTION DSpGetMouse(VAR outGlobalPoint: Point): OSStatus; C;
{
** alternate buffer operations
}
FUNCTION DSpAltBuffer_New(inContext: DSpContextReference; inVRAMBuffer: BOOLEAN; VAR inAttributes: DSpAltBufferAttributes; VAR outAltBuffer: DSpAltBufferReference): OSStatus; C;
FUNCTION DSpAltBuffer_Dispose(inAltBuffer: DSpAltBufferReference): OSStatus; C;
FUNCTION DSpAltBuffer_InvalRect(inAltBuffer: DSpAltBufferReference; {CONST}VAR inInvalidRect: Rect): OSStatus; C;
FUNCTION DSpAltBuffer_GetCGrafPtr(inAltBuffer: DSpAltBufferReference; inBufferKind: DSpBufferKind; VAR outCGrafPtr: CGrafPtr; VAR outGDevice: GDHandle): OSStatus; C;
{
** context operations
}
{ general }
FUNCTION DSpContext_GetAttributes(inContext: DSpContextReference; outAttributes: DSpContextAttributesPtr): OSStatus; C;
FUNCTION DSpContext_Reserve(inContext: DSpContextReference; inDesiredAttributes: DSpContextAttributesPtr): OSStatus; C;
FUNCTION DSpContext_Queue(inParentContext: DSpContextReference; inChildContext: DSpContextReference; inDesiredAttributes: DSpContextAttributesPtr): OSStatus; C;
FUNCTION DSpContext_Switch(inOldContext: DSpContextReference; inNewContext: DSpContextReference): OSStatus; C;
FUNCTION DSpContext_Release(inContext: DSpContextReference): OSStatus; C;
FUNCTION DSpContext_GetDisplayID(inContext: DSpContextReference; VAR outDisplayID: DisplayIDType): OSStatus; C;
FUNCTION DSpContext_GlobalToLocal(inContext: DSpContextReference; VAR ioPoint: Point): OSStatus; C;
FUNCTION DSpContext_LocalToGlobal(inContext: DSpContextReference; VAR ioPoint: Point): OSStatus; C;
FUNCTION DSpContext_SetVBLProc(inContext: DSpContextReference; inProcPtr: DSpCallbackProcPtr; inRefCon: UNIV Ptr): OSStatus; C;
FUNCTION DSpContext_GetFlattenedSize(inContext: DSpContextReference; VAR outFlatContextSize: UInt32): OSStatus; C;
FUNCTION DSpContext_Flatten(inContext: DSpContextReference; outFlatContext: UNIV Ptr): OSStatus; C;
FUNCTION DSpContext_Restore(inFlatContext: UNIV Ptr; VAR outRestoredContext: DSpContextReference): OSStatus; C;
FUNCTION DSpContext_GetMonitorFrequency(inContext: DSpContextReference; VAR outFrequency: Fixed): OSStatus; C;
FUNCTION DSpContext_SetMaxFrameRate(inContext: DSpContextReference; inMaxFPS: UInt32): OSStatus; C;
FUNCTION DSpContext_GetMaxFrameRate(inContext: DSpContextReference; VAR outMaxFPS: UInt32): OSStatus; C;
FUNCTION DSpContext_SetState(inContext: DSpContextReference; inState: DSpContextState): OSStatus; C;
FUNCTION DSpContext_GetState(inContext: DSpContextReference; VAR outState: DSpContextState): OSStatus; C;
FUNCTION DSpContext_IsBusy(inContext: DSpContextReference; VAR outBusyFlag: BOOLEAN): OSStatus; C;
{ dirty rectangles }
FUNCTION DSpContext_SetDirtyRectGridSize(inContext: DSpContextReference; inCellPixelWidth: UInt32; inCellPixelHeight: UInt32): OSStatus; C;
FUNCTION DSpContext_GetDirtyRectGridSize(inContext: DSpContextReference; VAR outCellPixelWidth: UInt32; VAR outCellPixelHeight: UInt32): OSStatus; C;
FUNCTION DSpContext_GetDirtyRectGridUnits(inContext: DSpContextReference; VAR outCellPixelWidth: UInt32; VAR outCellPixelHeight: UInt32): OSStatus; C;
FUNCTION DSpContext_InvalBackBufferRect(inContext: DSpContextReference; {CONST}VAR inRect: Rect): OSStatus; C;
{ underlays }
FUNCTION DSpContext_SetUnderlayAltBuffer(inContext: DSpContextReference; inNewUnderlay: DSpAltBufferReference): OSStatus; C;
FUNCTION DSpContext_GetUnderlayAltBuffer(inContext: DSpContextReference; VAR outUnderlay: DSpAltBufferReference): OSStatus; C;
{ gamma }
FUNCTION DSpContext_FadeGammaOut(inContext: DSpContextReference; VAR inZeroIntensityColor: RGBColor): OSStatus; C;
FUNCTION DSpContext_FadeGammaIn(inContext: DSpContextReference; VAR inZeroIntensityColor: RGBColor): OSStatus; C;
FUNCTION DSpContext_FadeGamma(inContext: DSpContextReference; inPercentOfOriginalIntensity: SInt32; VAR inZeroIntensityColor: RGBColor): OSStatus; C;
{ buffering }
FUNCTION DSpContext_SwapBuffers(inContext: DSpContextReference; inBusyProc: DSpCallbackProcPtr; inUserRefCon: UNIV Ptr): OSStatus; C;
FUNCTION DSpContext_GetBackBuffer(inContext: DSpContextReference; inBufferKind: DSpBufferKind; VAR outBackBuffer: CGrafPtr): OSStatus; C;
FUNCTION DSpContext_GetFrontBuffer(inContext: DSpContextReference; VAR outFrontBuffer: CGrafPtr): OSStatus; C;
{ clut operations }
FUNCTION DSpContext_SetCLUTEntries(inContext: DSpContextReference; {CONST}VAR inEntries: ColorSpec; inStartingEntry: UInt16; inLastEntry: UInt16): OSStatus; C;
FUNCTION DSpContext_GetCLUTEntries(inContext: DSpContextReference; VAR outEntries: ColorSpec; inStartingEntry: UInt16; inLastEntry: UInt16): OSStatus; C;
{ blit operations }
FUNCTION DSpBlit_Faster(inBlitInfo: DSpBlitInfoPtr; inAsyncFlag: BOOLEAN): OSStatus; C;
FUNCTION DSpBlit_Fastest(inBlitInfo: DSpBlitInfoPtr; inAsyncFlag: BOOLEAN): OSStatus; C;

{$ENDC}  {CALL_IN_SPOCKETS_BUT_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DrawSprocketIncludes}

{$ENDC} {__DRAWSPROCKET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}