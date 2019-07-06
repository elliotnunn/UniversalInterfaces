/******************************************************************************
 **																			 **
 ** 	Module:		QD3DErrors.h											 **
 **																			 **
 **																			 **
 ** 	Purpose:	Error API and error codes								 **
 **																			 **
 **																			 **
 **																			 **
 ** 	Copyright (C) 1992-1997 Apple Computer, Inc.  All rights reserved.	 **
 **																			 **
 **																			 **
 *****************************************************************************/
#ifndef QD3DError_h
#define QD3DError_h

#include "QD3D.h"

#if defined(PRAGMA_ONCE) && PRAGMA_ONCE
	#pragma once
#endif  /*  PRAGMA_ONCE  */

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=small
#endif

#include <Types.h>

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=reset
	#pragma options enum=int
	#pragma options align=power
#elif defined(__MWERKS__)
	#pragma enumsalwaysint on
	#pragma options align=native
#elif defined(__MRC__) || defined(__SC__)
	#if __option(pack_enums)
		#define PRAGMA_ENUM_RESET_QD3DERRORS 1
	#endif
	#pragma options(!pack_enums)
	#pragma options align=power
#endif

#endif  /* OS_MACINTOSH */


#ifdef __cplusplus
extern "C" {
#endif  /*  __cplusplus  */


/******************************************************************************
 **																			 **
 **							Error Types and Codes							 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3Error {
	kQ3ErrorNone = 0,		
	/* Fatal Errors */
	kQ3ErrorInternalError			= -28500,
	kQ3ErrorNoRecovery,
	kQ3ErrorLastFatalError,
	/* System Errors */
	kQ3ErrorNotInitialized			= -28490,
	kQ3ErrorAlreadyInitialized,
	kQ3ErrorUnimplemented,
	kQ3ErrorRegistrationFailed,
	/* OS Errors */
	kQ3ErrorUnixError,
	kQ3ErrorMacintoshError,
	kQ3ErrorX11Error,
	/* Memory Errors */
	kQ3ErrorMemoryLeak,
	kQ3ErrorOutOfMemory,
	/* Parameter errors */
	kQ3ErrorNULLParameter,
	kQ3ErrorParameterOutOfRange,
	kQ3ErrorInvalidParameter,			
	kQ3ErrorInvalidData,				
	kQ3ErrorAcceleratorAlreadySet,		
	kQ3ErrorVector3DNotUnitLength,
	kQ3ErrorVector3DZeroLength,
	/* Object Errors */
	kQ3ErrorInvalidObject,
	kQ3ErrorInvalidObjectClass,
	kQ3ErrorInvalidObjectType,
	kQ3ErrorInvalidObjectName,
	kQ3ErrorObjectClassInUse,			
	kQ3ErrorAccessRestricted,
	kQ3ErrorMetaHandlerRequired,
	kQ3ErrorNeedRequiredMethods,
	kQ3ErrorNoSubClassType,
	kQ3ErrorUnknownElementType,
	kQ3ErrorNotSupported,
	/* Extension Errors */
	kQ3ErrorNoExtensionsFolder,
	kQ3ErrorExtensionError,
	kQ3ErrorPrivateExtensionError,
	/* Geometry Errors */
	kQ3ErrorDegenerateGeometry,
	kQ3ErrorGeometryInsufficientNumberOfPoints,
	/* IO Errors */
	kQ3ErrorNoStorageSetForFile,
	kQ3ErrorEndOfFile,
	kQ3ErrorFileCancelled,
	kQ3ErrorInvalidMetafile,
 	kQ3ErrorInvalidMetafilePrimitive,
 	kQ3ErrorInvalidMetafileLabel,
 	kQ3ErrorInvalidMetafileObject,
 	kQ3ErrorInvalidMetafileSubObject,
	kQ3ErrorInvalidSubObjectForObject,
	kQ3ErrorUnresolvableReference,
	kQ3ErrorUnknownObject,
	kQ3ErrorStorageInUse,
	kQ3ErrorStorageAlreadyOpen,
	kQ3ErrorStorageNotOpen,
	kQ3ErrorStorageIsOpen,
	kQ3ErrorFileAlreadyOpen,
	kQ3ErrorFileNotOpen,
	kQ3ErrorFileIsOpen,
	kQ3ErrorBeginWriteAlreadyCalled,
	kQ3ErrorBeginWriteNotCalled,
	kQ3ErrorEndWriteNotCalled,
	kQ3ErrorReadStateInactive,
	kQ3ErrorStateUnavailable,
	kQ3ErrorWriteStateInactive,
	kQ3ErrorSizeNotLongAligned,
	kQ3ErrorFileModeRestriction,
	kQ3ErrorInvalidHexString,
	kQ3ErrorWroteMoreThanSize,
	kQ3ErrorWroteLessThanSize,
	kQ3ErrorReadLessThanSize,
	kQ3ErrorReadMoreThanSize,
	kQ3ErrorNoBeginGroup,
	kQ3ErrorSizeMismatch,
	kQ3ErrorStringExceedsMaximumLength,
	kQ3ErrorValueExceedsMaximumSize,
	kQ3ErrorNonUniqueLabel,
	kQ3ErrorEndOfContainer,
	kQ3ErrorUnmatchedEndGroup,
	kQ3ErrorFileVersionExists,
	/* View errors */
	kQ3ErrorViewNotStarted,
	kQ3ErrorViewIsStarted,
	kQ3ErrorRendererNotSet,
	kQ3ErrorRenderingIsActive,
	kQ3ErrorImmediateModeUnderflow,
	kQ3ErrorDisplayNotSet,
	kQ3ErrorCameraNotSet,
	kQ3ErrorDrawContextNotSet,
	kQ3ErrorNonInvertibleMatrix,
	kQ3ErrorRenderingNotStarted,
	kQ3ErrorPickingNotStarted,
	kQ3ErrorBoundsNotStarted,
	kQ3ErrorDataNotAvailable,
	kQ3ErrorNothingToPop,
	/* Renderer Errors */
	kQ3ErrorUnknownStudioType,			
	kQ3ErrorAlreadyRendering,
	kQ3ErrorStartGroupRange,
	kQ3ErrorUnsupportedGeometryType,
	kQ3ErrorInvalidGeometryType,
	kQ3ErrorUnsupportedFunctionality,
	/* Group Errors */
	kQ3ErrorInvalidPositionForGroup,
	kQ3ErrorInvalidObjectForGroup,
	kQ3ErrorInvalidObjectForPosition,
	/* Transform Errors */
	kQ3ErrorScaleOfZero,				
	/* String Errors */
	kQ3ErrorBadStringType,				
	/* Attribute Errors */
	kQ3ErrorAttributeNotContained,		
	kQ3ErrorAttributeInvalidType,		
	/* Camera Errors */
	kQ3ErrorInvalidCameraValues,		
	/* DrawContext Errors */
	kQ3ErrorBadDrawContextType,
	kQ3ErrorBadDrawContextFlag,
	kQ3ErrorBadDrawContext,
	kQ3ErrorUnsupportedPixelDepth,
	/* Controller Errors */
	kQ3ErrorController,
	/* Tracker Errors */
	kQ3ErrorTracker,
	/* Another OS Error */
	kQ3ErrorWin32Error,
	/* Object Errors */
	kQ3ErrorTypeAlreadyExistsAndHasSubclasses,
	kQ3ErrorTypeAlreadyExistsAndOtherClassesDependOnIt,
	kQ3ErrorTypeAlreadyExistsAndHasObjectInstances,
	/*
	 * submit loop errors: if you ever get one of these check the previous
	 * error posted, it may be kQ3ErrorOutOfMemory.  If so you *may* be able
	 * to recover by freeing up some memory and trying again
	 */
	kQ3ErrorPickingLoopFailed,
	kQ3ErrorRenderingLoopFailed,
	kQ3ErrorWritingLoopFailed,
	kQ3ErrorBoundingLoopFailed
} TQ3Error;

typedef enum TQ3Warning {
	kQ3WarningNone = 0,
	/* General System */
	kQ3WarningInternalException = -28300,	
	/* Object Warnings */
	kQ3WarningNoObjectSupportForDuplicateMethod,
	kQ3WarningNoObjectSupportForDrawMethod,
	kQ3WarningNoObjectSupportForWriteMethod,
	kQ3WarningNoObjectSupportForReadMethod,
	kQ3WarningUnknownElementType,
	kQ3WarningTypeAndMethodAlreadyDefined,
	kQ3WarningTypeIsOutOfRange,
	kQ3WarningTypeHasNotBeenRegistered,
	/* Parameter Warnings */
	kQ3WarningVector3DNotUnitLength,
	/* IO Warnings */
	kQ3WarningInvalidSubObjectForObject,
	kQ3WarningInvalidHexString,
	kQ3WarningUnknownObject,
	kQ3WarningInvalidMetafileObject,
	kQ3WarningUnmatchedBeginGroup,
	kQ3WarningUnmatchedEndGroup,
	kQ3WarningInvalidTableOfContents,
	kQ3WarningUnresolvableReference,
	kQ3WarningNoAttachMethod,
	kQ3WarningInconsistentData,
	kQ3WarningReadLessThanSize,
	kQ3WarningFilePointerResolutionFailed,
	kQ3WarningFilePointerRedefined,
	kQ3WarningStringExceedsMaximumLength,
	/* Memory Warnings */
	kQ3WarningLowMemory,
	kQ3WarningPossibleMemoryLeak,
	/* View Warnings */
	kQ3WarningViewTraversalInProgress,
	kQ3WarningNonInvertibleMatrix,
	/* Quaternion Warning */
	kQ3WarningQuaternionEntriesAreZero,
	/* Renderer Warning */
	kQ3WarningFunctionalityNotSupported,
	/* DrawContext Warning */
	kQ3WarningInvalidPaneDimensions,
	/* Pick Warning */
	kQ3WarningPickParamOutside,
	/* Scale Warnings */
	kQ3WarningScaleEntriesAllZero,
	kQ3WarningScaleContainsNegativeEntries,
	/* Generic Warnings */
	kQ3WarningParameterOutOfRange,
	/* Extension Warnings */
	kQ3WarningExtensionNotLoading,
	/* Object Warnings */
	kQ3WarningTypeAlreadyRegistered,
	kQ3WarningTypeSameVersionAlreadyRegistered,
	kQ3WarningTypeNewerVersionAlreadyRegistered,
	/* Invalid Group Object */
	kQ3WarningInvalidObjectInGroupMetafile
} TQ3Warning;


typedef enum TQ3Notice {
	kQ3NoticeNone = 0,
	kQ3NoticeDataAlreadyEmpty = -28100,
	kQ3NoticeMethodNotSupported,
	kQ3NoticeObjectAlreadySet,
	kQ3NoticeParameterOutOfRange,
	kQ3NoticeFileAliasWasChanged,
	kQ3NoticeMeshVertexHasNoComponent,
	kQ3NoticeMeshInvalidVertexFacePair,
	kQ3NoticeMeshEdgeVertexDoNotCorrespond,
	kQ3NoticeMeshEdgeIsNotBoundary,
	kQ3NoticeDrawContextNotSetUsingInternalDefaults,
	kQ3NoticeInvalidAttenuationTypeUsingInternalDefaults,
	kQ3NoticeBrightnessGreaterThanOne,
	kQ3NoticeScaleContainsZeroEntries,
	kQ3NoticeSystemAlreadyInitialized,
	kQ3NoticeViewSyncCalledAgain,
	kQ3NoticeFileCancelled
} TQ3Notice;

typedef void (QD3D_CALLBACK *TQ3ErrorMethod)(
	TQ3Error	firstError,
	TQ3Error	lastError,
	long		reference);
	
typedef void (QD3D_CALLBACK *TQ3WarningMethod)(
	TQ3Warning	firstWarning,
	TQ3Warning	lastWarning,
	long		reference);

typedef void (QD3D_CALLBACK *TQ3NoticeMethod)(
	TQ3Notice	firstNotice,
	TQ3Notice	lastNotice,
	long		reference);


/******************************************************************************
 **																			 **
 **								Error Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status QD3D_CALL Q3Error_Register(
	TQ3ErrorMethod		errorPost,
	long				reference);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Warning_Register(
	TQ3WarningMethod	warningPost,
	long				reference);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Notice_Register(
	TQ3NoticeMethod		noticePost,
	long				reference);

/*
 *  Getting error codes -
 *	Clears error type on next entry into system (except all of these 
 *  error calls), and returns the last error, and optionally the 
 *	first error. The parameter to these "_Get" calls may be NULL.
 */
QD3D_EXPORT TQ3Error QD3D_CALL Q3Error_Get(
	TQ3Error			*firstError);

QD3D_EXPORT TQ3Boolean QD3D_CALL Q3Error_IsFatalError(
	TQ3Error			error);

QD3D_EXPORT TQ3Warning QD3D_CALL Q3Warning_Get(
	TQ3Warning			*firstWarning);

QD3D_EXPORT TQ3Notice QD3D_CALL Q3Notice_Get(
	TQ3Notice			*firstNotice);

#if defined(OS_MACINTOSH) && OS_MACINTOSH

QD3D_EXPORT OSErr QD3D_CALL Q3MacintoshError_Get(
	OSErr				*firstMacErr);

#endif  /*  OS_MACINTOSH  */
#ifdef __cplusplus
}
#endif  /*  __cplusplus  */

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=reset
	#pragma options align=reset
#elif defined(__MWERKS__)
	#pragma enumsalwaysint reset
	#pragma options align=reset
#elif defined(__MRC__) || defined(__SC__)
	#if PRAGMA_ENUM_RESET_QD3DERRORS
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DERRORS
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif	/*  QD3DError_h  */
