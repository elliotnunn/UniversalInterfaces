/*
 	File:		DrawSprocket.h
 
 	Contains:	Public interfaces for DrawSprocket
 
 	Version:	Technology:	Apple Game Sprockets 1.0
 				Package:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
*/


#ifndef __DRAWSPROCKET__
#define __DRAWSPROCKET__

#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __QDOFFSCREEN__
#include <QDOffscreen.h>
#endif

#ifndef __DISPLAYS__
#include <Displays.h>
#endif


#if GENERATINGPOWERPC

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=power
#endif

/*
********************************************************************************
** error/warning codes
********************************************************************************
*/
enum {
	kDSpNotInitializedErr				= -30440L,
	kDSpSystemSWTooOldErr				= -30441L,
	kDSpInvalidContextErr				= -30442L,
	kDSpInvalidAttributesErr			= -30443L,
	kDSpContextAlreadyReservedErr		= -30444L,
	kDSpContextNotReservedErr			= -30445L,
	kDSpContextNotFoundErr				= -30446L,
	kDSpFrameRateNotReadyErr			= -30447L,
	kDSpConfirmSwitchWarning			= -30448L,
	kDSpInternalErr						= -30449L
};

/*
********************************************************************************
** constants
********************************************************************************
*/
typedef UInt32 DSpDepthMask;
enum {
	kDSpDepthMask_1		= 1U<<0,
	kDSpDepthMask_2		= 1U<<1,
	kDSpDepthMask_4		= 1U<<2,
	kDSpDepthMask_8		= 1U<<3,
	kDSpDepthMask_16	= 1U<<4,
	kDSpDepthMask_32	= 1U<<5,
	kDSpDepthMask_All	= ~0U
};

typedef UInt32 DSpColorNeeds;
enum {
	kDSpColorNeeds_DontCare	= 0L,
	kDSpColorNeeds_Request	= 1L,
	kDSpColorNeeds_Require	= 2L
};

typedef UInt32 DSpContextState;
enum {
	kDSpContextState_Active		= 0L,
	kDSpContextState_Paused		= 1L,
	kDSpContextState_Inactive	= 2L
};

typedef UInt32 DSpContextOption;
enum {
	kDSpContextOption_QD3DAccel		= 1U<<0,
	kDSpContextOption_PageFlip		= 1U<<1,
	kDSpContextOption_DontSyncVBL	= 1U<<2
};

typedef UInt32 DSpBufferKind;
enum {
	kDSpBufferKind_Normal	= 0U
};

/* buffer scaling is not implemented in 1.0 */
typedef UInt32 DSpBufferScale;
enum {
	kDSpBufferScale_1				= 0x00000001U,
	kDSpBufferScale_2				= 0x00000002U,
	kDSpBufferScale_2Interpolate	= 0x80000002U,
	kDSpBufferScale_3				= 0x00000003U,
	kDSpBufferScale_3Interpolate	= 0x80000003U,
	kDSpBufferScale_4				= 0x00000004U,
	kDSpBufferScale_4Interpolate	= 0x80000004U
};

/*
********************************************************************************
** data types
********************************************************************************
*/
typedef struct DSpAltBufferPrivate *DSpAltBufferReference;
typedef struct DSpContextPrivate *DSpContextReference;

#define kDSpEveryContext ((DSpContextReference)NULL)

typedef Boolean (*DSpEventProcPtr)( EventRecord *inEvent );
typedef Boolean (*DSpCallbackProcPtr)( DSpContextReference inContext,
			void *inRefCon );

struct DSpContextAttributes {
	Fixed				frequency;
	UInt32				displayWidth;
	UInt32				displayHeight;
	UInt32				reserved1;
	UInt32				reserved2;
	UInt32				colorNeeds;
	CTabHandle			colorTable;
	OptionBits			contextOptions;
	OptionBits			backBufferDepthMask;
	OptionBits			displayDepthMask;
	UInt32				backBufferBestDepth;
	UInt32				displayBestDepth;
	UInt32				pageCount;
	Boolean				gameMustConfirmSwitch;
	UInt32				reserved3[4];
};
typedef struct DSpContextAttributes DSpContextAttributes;
typedef struct DSpContextAttributes *DSpContextAttributesPtr;

/*
********************************************************************************
** function prototypes
********************************************************************************
*/

/*
** global operations
*/
OSStatus DSpStartup( void );
OSStatus DSpShutdown( void );

OSStatus DSpGetFirstContext( DisplayIDType inDisplayID,
			DSpContextReference *outContext );
OSStatus DSpGetNextContext( DSpContextReference inCurrentContext,
			DSpContextReference *outContext );

OSStatus DSpFindBestContext(
			DSpContextAttributesPtr inDesiredAttributes,
			DSpContextReference *outContext );

OSStatus DSpCanUserSelectContext(
			DSpContextAttributesPtr inDesiredAttributes,
			Boolean *outUserCanSelectContext );
OSStatus DSpUserSelectContext(
			DSpContextAttributesPtr inDesiredAttributes,
			DisplayIDType inDialogDisplayLocation, DSpEventProcPtr inEventProc,
			DSpContextReference *outContext );

OSStatus DSpProcessEvent( EventRecord *inEvent, Boolean *outEventWasProcessed );

OSStatus DSpSetBlankingColor( const RGBColor *inRGBColor );

OSStatus DSpSetDebugMode( Boolean inDebugMode );

OSStatus DSpFindContextFromPoint( Point inGlobalPoint,
			DSpContextReference *outContext );

OSStatus DSpGetMouse( Point *outGlobalPoint );

/*
** alternate buffer operations
*/
OSStatus DSpAltBuffer_New( DSpContextReference inContext, Boolean inVRAMBuffer,
			UInt32 inReserved, DSpAltBufferReference *outAltBuffer );
OSStatus DSpAltBuffer_Dispose( DSpAltBufferReference inAltBuffer );
OSStatus DSpAltBuffer_InvalRect( DSpAltBufferReference inAltBuffer,
			const Rect *inInvalidRect );
OSStatus DSpAltBuffer_GetCGrafPtr( DSpAltBufferReference inAltBuffer,
			DSpBufferKind inBufferKind, CGrafPtr *outCGrafPtr,
			GDHandle *outGDevice );

/*
** context operations
*/

/* general */
OSStatus DSpContext_GetAttributes( DSpContextReference inContext,
			DSpContextAttributesPtr outAttributes );

OSStatus DSpContext_Reserve( DSpContextReference inContext,
			DSpContextAttributesPtr inDesiredAttributes );
OSStatus DSpContext_Release( DSpContextReference inContext );

OSStatus DSpContext_GetDisplayID( DSpContextReference inContext,
			DisplayIDType *outDisplayID );

OSStatus DSpContext_GlobalToLocal( DSpContextReference inContext,
			Point *ioPoint );
OSStatus DSpContext_LocalToGlobal( DSpContextReference inContext,
			Point *ioPoint );

OSStatus DSpContext_SetVBLProc( DSpContextReference inContext,
			DSpCallbackProcPtr inProcPtr, void *inRefCon );

OSStatus DSpContext_GetFlattenedSize( DSpContextReference inContext,
			UInt32 *outFlatContextSize );
OSStatus DSpContext_Flatten( DSpContextReference inContext,
			void *outFlatContext );
OSStatus DSpContext_Restore( void *inFlatContext,
			DSpContextReference *outRestoredContext );

OSStatus DSpContext_GetMonitorFrequency( DSpContextReference inContext,
			Fixed *outFrequency );
OSStatus DSpContext_SetMaxFrameRate( DSpContextReference inContext,
			UInt32 inMaxFPS );
OSStatus DSpContext_GetMaxFrameRate( DSpContextReference inContext,
			UInt32 *outMaxFPS );

OSStatus DSpContext_SetState( DSpContextReference inContext,
			DSpContextState inState );
OSStatus DSpContext_GetState( DSpContextReference inContext,
			DSpContextState *outState );

OSStatus DSpContext_IsBusy( DSpContextReference inContext,
			Boolean *outBusyFlag );

/* dirty rectangles */
OSStatus DSpContext_SetDirtyRectGridSize( DSpContextReference inContext,
			UInt32 inCellPixelWidth, UInt32 inCellPixelHeight );
OSStatus DSpContext_GetDirtyRectGridSize( DSpContextReference inContext,
			UInt32 *outCellPixelWidth, UInt32 *outCellPixelHeight );
OSStatus DSpContext_GetDirtyRectGridUnits( DSpContextReference inContext,
			UInt32 *outCellPixelWidth, UInt32 *outCellPixelHeight );
OSStatus DSpContext_InvalBackBufferRect( DSpContextReference inContext,
			const Rect *inRect );

/* underlays */
OSStatus DSpContext_SetUnderlayAltBuffer( DSpContextReference inContext,
			DSpAltBufferReference inNewUnderlay );
OSStatus DSpContext_GetUnderlayAltBuffer( DSpContextReference inContext,
			DSpAltBufferReference *outUnderlay );

/* gamma */
OSStatus DSpContext_FadeGammaOut( DSpContextReference inContext,
			RGBColor *inZeroIntensityColor );
OSStatus DSpContext_FadeGammaIn( DSpContextReference inContext,
			RGBColor *inZeroIntensityColor );
OSStatus DSpContext_FadeGamma( DSpContextReference inContext,
			SInt32 inPercentOfOriginalIntensity,
			RGBColor *inZeroIntensityColor );

/* buffering */
OSStatus DSpContext_SwapBuffers( DSpContextReference inContext,
			DSpCallbackProcPtr inBusyProc, void *inUserRefCon );
OSStatus DSpContext_GetBackBuffer( DSpContextReference inContext,
			DSpBufferKind inBufferKind, CGrafPtr *outBackBuffer );

/* clut operations */
OSStatus DSpContext_SetCLUTEntries( DSpContextReference inContext,
			const ColorSpec *inEntries, UInt16 inStartingEntry,
			UInt16 inEntryCount );
OSStatus DSpContext_GetCLUTEntries( DSpContextReference inContext,
			ColorSpec *outEntries, UInt16 inStartingEntry,
			UInt16 inEntryCount );
			
#ifdef __cplusplus
}
#endif

/*
********************************************************************************
** unimplemented functions
********************************************************************************
*/

/*
** These functions and associated items were slated to make it into the
** 1.0 release of DrawSprocket, but didn't make it.
*/
#if 0

/* alt buffer */
OSStatus DSpAltBuffer_RebuildTransparencyMask(
			DSpAltBufferReference inAltBuffer, UInt32 inTransparencyValue );

/* pixel scaling */
OSStatus DSpContext_SetScale( DSpContextReference inContext,
			DSpBufferScale inScale );
OSStatus DSpContext_GetScale( DSpContextReference inContext,
			DSpBufferScale *outScale );

/* overlays */
OSStatus DSpContext_SetOverlayAltBuffer( DSpContextReference inContext,
			DSpAltBufferReference inNewOverlay );
OSStatus DSpContext_GetOverlayAltBuffer( DSpContextReference inContext,
			DSpAltBufferReference *outOverlay );
			
#endif


#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#endif /* GENERATINGPOWERPC */
#endif /* __DRAWSPROCKET__ */
