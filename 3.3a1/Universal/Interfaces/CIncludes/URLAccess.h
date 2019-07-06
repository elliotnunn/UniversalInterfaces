/*
 	File:		URLAccess.h
 
 	Contains:	URL Access Interfaces.
 
 	Version:	Technology:	2.0
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1994-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __URLACCESS__
#define __URLACCESS__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __CODEFRAGMENTS__
#include <CodeFragments.h>
#endif

#ifndef __FILESIGNING__
#include <FileSigning.h>
#endif


/* Data structures and types */


#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
	#pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
	#pragma pack(2)
#endif

typedef struct OpaqueURLReference* 		URLReference;

enum {
	kURLReplaceExistingFlag		= 1 << 0,
	kURLBinHexFileFlag			= 1 << 1,						/* Binhex before uploading if necessary*/
	kURLExpandFileFlag			= 1 << 2,						/* Use StuffIt engine to expand file if necessary*/
	kURLDisplayProgressFlag		= 1 << 3,
	kURLDisplayAuthFlag			= 1 << 4,						/* Display auth dialog if guest connection fails*/
	kURLUploadFlag				= 1 << 5,						/* Do an upload instead of a download*/
	kURLIsDirectoryHintFlag		= 1 << 6,						/* Hint: the URL is a directory*/
	kURLDoNotTryAnonymousFlag	= 1 << 7,						/* Don't try to connect anonymously before getting logon info*/
	kURLDirectoryListingFlag	= 1 << 8,						/* Download the directory listing, not the whole directory*/
	kURLExpandAndVerifyFlag		= 1 << 9,						/* Expand file and then verify using signature resource*/
	kURLNoAutoRedirectFlag		= 1 << 10,						/* Do not automatically redirect to new URL*/
	kURLDebinhexOnlyFlag		= 1 << 11,						/* Do not use Stuffit Expander - just internal debinhex engine*/
	kURLReservedFlag			= 1 << 31						/* reserved for Apple internal use*/
};

typedef UInt32 							URLOpenFlags;
enum {
	kURLNullState				= 0,
	kURLInitiatingState			= 1,
	kURLLookingUpHostState		= 2,
	kURLConnectingState			= 3,
	kURLResourceFoundState		= 4,
	kURLDownloadingState		= 5,
	kURLDataAvailableState		= 0x10 + kURLDownloadingState,
	kURLTransactionCompleteState = 6,
	kURLErrorOccurredState		= 7,
	kURLAbortingState			= 8,
	kURLCompletedState			= 9,
	kURLUploadingState			= 10
};

typedef UInt32 							URLState;
enum {
	kURLInitiatedEvent			= kURLInitiatingState,
	kURLResourceFoundEvent		= kURLResourceFoundState,
	kURLDownloadingEvent		= kURLDownloadingState,
	kURLAbortInitiatedEvent		= kURLAbortingState,
	kURLCompletedEvent			= kURLCompletedState,
	kURLErrorOccurredEvent		= kURLErrorOccurredState,
	kURLDataAvailableEvent		= kURLDataAvailableState,
	kURLTransactionCompleteEvent = kURLTransactionCompleteState,
	kURLUploadingEvent			= kURLUploadingState,
	kURLSystemEvent				= 29,
	kURLPercentEvent			= 30,
	kURLPeriodicEvent			= 31,
	kURLPropertyChangedEvent	= 32
};

typedef UInt32 							URLEvent;
enum {
	kURLInitiatedEventMask		= 1 << (kURLInitiatedEvent - 1),
	kURLResourceFoundEventMask	= 1 << (kURLResourceFoundEvent - 1),
	kURLDownloadingMask			= 1 << (kURLDownloadingEvent - 1),
	kURLUploadingMask			= 1 << (kURLUploadingEvent - 1),
	kURLAbortInitiatedMask		= 1 << (kURLAbortInitiatedEvent - 1),
	kURLCompletedEventMask		= 1 << (kURLCompletedEvent - 1),
	kURLErrorOccurredEventMask	= 1 << (kURLErrorOccurredEvent - 1),
	kURLDataAvailableEventMask	= 1 << (kURLDataAvailableEvent - 1),
	kURLTransactionCompleteEventMask = 1 << (kURLTransactionCompleteEvent - 1),
	kURLSystemEventMask			= 1 << (kURLSystemEvent - 1),
	kURLPercentEventMask		= 1 << (kURLPercentEvent - 1),
	kURLPeriodicEventMask		= 1 << (kURLPeriodicEvent - 1),
	kURLPropertyChangedEventMask = 1 << (kURLPropertyChangedEvent - 1),
	kURLAllBufferEventsMask		= kURLDataAvailableEventMask + kURLTransactionCompleteEventMask,
	kURLAllNonBufferEventsMask	= kURLInitiatedEventMask + kURLDownloadingMask + kURLUploadingMask + kURLAbortInitiatedMask + kURLCompletedEventMask + kURLErrorOccurredEventMask + kURLPercentEventMask + kURLPeriodicEventMask + kURLPropertyChangedEventMask,
	kURLAllEventsMask			= (long)0xFFFFFFFF
};

typedef UInt32 							URLEventMask;

struct URLCallbackInfo {
	UInt32 							version;
	URLReference 					urlRef;
	const char *					property;
	UInt32 							currentSize;
	EventRecord *					systemEvent;
};
typedef struct URLCallbackInfo			URLCallbackInfo;
static const char* kURLURL						= "URLString";
static const char* kURLResourceSize				= "URLResourceSize";
static const char* kURLLastModifiedTime			= "URLLastModifiedTime";
static const char* kURLMIMEType					= "URLMIMEType";
static const char* kURLFileType					= "URLFileType";
static const char* kURLFileCreator				= "URLFileCreator";
static const char* kURLCharacterSet				= "URLCharacterSet";
static const char* kURLResourceName				= "URLResourceName";
static const char* kURLHost						= "URLHost";
static const char* kURLAuthType					= "URLAuthType";
static const char* kURLUserName					= "URLUserName";
static const char* kURLPassword					= "URLPassword";
static const char* kURLStatusString				= "URLStatusString";
static const char* kURLIsSecure					= "URLIsSecure";
static const char* kURLCertificate				= "URLCertificate";
static const char* kURLTotalItems				= "URLTotalItems";
/* http and https properties*/
static const char* kURLHTTPRequestMethod		= "URLHTTPRequestMethod";
static const char* kURLHTTPRequestHeader		= "URLHTTPRequestHeader";
static const char* kURLHTTPRequestBody			= "URLHTTPRequestBody";
static const char* kURLHTTPRespHeader			= "URLHTTPRespHeader";
static const char* kURLHTTPUserAgent			= "URLHTTPUserAgent";
static const char* kURLHTTPRedirectedURL		= "URLHTTPRedirectedURL";
/* authentication type flags*/
enum {
	kUserNameAndPasswordFlag	= 0x00000001
};

EXTERN_API( OSStatus )
URLGetURLAccessVersion			(UInt32 *				returnVers);

#if TARGET_RT_MAC_CFM
#ifdef __cplusplus
	inline pascal Boolean URLAccessAvailable() { return ((URLGetURLAccessVersion != (void*)kUnresolvedCFragSymbolAddress) ); }
#else
	#define URLAccessAvailable() 	((URLGetURLAccessVersion != (void*)kUnresolvedCFragSymbolAddress) )
#endif
#endif  /* TARGET_RT_MAC_CFM */

typedef CALLBACK_API( OSStatus , URLNotifyProcPtr )(void *userContext, URLEvent event, URLCallbackInfo *callbackInfo);
typedef CALLBACK_API( OSStatus , URLSystemEventProcPtr )(void *userContext, EventRecord *event);
typedef TVECTOR_UPP_TYPE(URLNotifyProcPtr) 						URLNotifyUPP;
typedef TVECTOR_UPP_TYPE(URLSystemEventProcPtr) 				URLSystemEventUPP;
#if OPAQUE_UPP_TYPES
	EXTERN_API(URLNotifyUPP)
	NewURLNotifyUPP				   (URLNotifyProcPtr		userRoutine);

	EXTERN_API(URLSystemEventUPP)
	NewURLSystemEventUPP		   (URLSystemEventProcPtr	userRoutine);

	EXTERN_API(void)
	DisposeURLNotifyUPP			   (URLNotifyUPP			userUPP);

	EXTERN_API(void)
	DisposeURLSystemEventUPP	   (URLSystemEventUPP		userUPP);

	EXTERN_API(OSStatus)
	InvokeURLNotifyUPP			   (void *					userContext,
									URLEvent				event,
									URLCallbackInfo *		callbackInfo,
									URLNotifyUPP			userUPP);

	EXTERN_API(OSStatus)
	InvokeURLSystemEventUPP		   (void *					userContext,
									EventRecord *			event,
									URLSystemEventUPP		userUPP);

#else
	#define NewURLNotifyUPP(userRoutine)							(userRoutine)
	#define NewURLSystemEventUPP(userRoutine)						(userRoutine)
	#define DisposeURLNotifyUPP(userUPP) 							
	#define DisposeURLSystemEventUPP(userUPP) 						
	#define InvokeURLNotifyUPP(userContext, event, callbackInfo, userUPP)  (*userUPP)(userContext, event, callbackInfo)
	#define InvokeURLSystemEventUPP(userContext, event, userUPP) 	(*userUPP)(userContext, event)
#endif
EXTERN_API( OSStatus )
URLSimpleDownload				(const char *			url,
								 FSSpec *				destination,
								 Handle 				destinationHandle,
								 URLOpenFlags 			openFlags,
								 URLSystemEventUPP 		eventProc,
								 void *					userContext);

EXTERN_API( OSStatus )
URLDownload						(URLReference 			urlRef,
								 FSSpec *				destination,
								 Handle 				destinationHandle,
								 URLOpenFlags 			openFlags,
								 URLSystemEventUPP 		eventProc,
								 void *					userContext);

EXTERN_API( OSStatus )
URLSimpleUpload					(const char *			url,
								 const FSSpec *			source,
								 URLOpenFlags 			openFlags,
								 URLSystemEventUPP 		eventProc,
								 void *					userContext);

EXTERN_API( OSStatus )
URLUpload						(URLReference 			urlRef,
								 const FSSpec *			source,
								 URLOpenFlags 			openFlags,
								 URLSystemEventUPP 		eventProc,
								 void *					userContext);

EXTERN_API( OSStatus )
URLNewReference					(const char *			url,
								 URLReference *			urlRef);

EXTERN_API( OSStatus )
URLDisposeReference				(URLReference 			urlRef);

EXTERN_API( OSStatus )
URLOpen							(URLReference 			urlRef,
								 FSSpec *				fileSpec,
								 URLOpenFlags 			openFlags,
								 URLNotifyUPP 			notifyProc,
								 URLEventMask 			eventRegister,
								 void *					userContext);

EXTERN_API( OSStatus )
URLAbort						(URLReference 			urlRef);

EXTERN_API( OSStatus )
URLGetDataAvailable				(URLReference 			urlRef,
								 Size *					dataSize);

EXTERN_API( OSStatus )
URLGetBuffer					(URLReference 			urlRef,
								 void **				buffer,
								 Size *					bufferSize);

EXTERN_API( OSStatus )
URLReleaseBuffer				(URLReference 			urlRef,
								 void *					buffer);

EXTERN_API( OSStatus )
URLGetProperty					(URLReference 			urlRef,
								 const char *			property,
								 void *					propertyBuffer,
								 Size 					bufferSize);

EXTERN_API( OSStatus )
URLGetPropertySize				(URLReference 			urlRef,
								 const char *			property,
								 Size *					propertySize);

EXTERN_API( OSStatus )
URLSetProperty					(URLReference 			urlRef,
								 const char *			property,
								 void *					propertyBuffer,
								 Size 					bufferSize);

EXTERN_API( OSStatus )
URLGetCurrentState				(URLReference 			urlRef,
								 URLState *				state);

EXTERN_API( OSStatus )
URLGetError						(URLReference 			urlRef,
								 OSStatus *				urlError);

EXTERN_API( OSStatus )
URLIdle							(void);

EXTERN_API( OSStatus )
URLGetFileInfo					(StringPtr 				fName,
								 OSType *				fType,
								 OSType *				fCreator);


/* Error Codes */
enum {
	kURLInternetAccessErrorCodeBase = -30770,
	kURLInvalidURLReferenceError = kURLInternetAccessErrorCodeBase - 0,
	kURLProgressAlreadyDisplayedError = kURLInternetAccessErrorCodeBase - 1,
	kURLDestinationExistsError	= kURLInternetAccessErrorCodeBase - 2,
	kURLInvalidURLError			= kURLInternetAccessErrorCodeBase - 3,
	kURLUnsupportedSchemeError	= kURLInternetAccessErrorCodeBase - 4,
	kURLServerBusyError			= kURLInternetAccessErrorCodeBase - 5,
	kURLAuthenticationError		= kURLInternetAccessErrorCodeBase - 6,
	kURLPropertyNotYetKnownError = kURLInternetAccessErrorCodeBase - 7,
	kURLUnknownPropertyError	= kURLInternetAccessErrorCodeBase - 8,
	kURLPropertyBufferTooSmallError = kURLInternetAccessErrorCodeBase - 9,
	kURLUnsettablePropertyError	= kURLInternetAccessErrorCodeBase - 10,
	kURLInvalidCallError		= kURLInternetAccessErrorCodeBase - 11,
	kURLFileEmptyError			= kURLInternetAccessErrorCodeBase - 13,
	kURLExtensionFailureError	= kURLInternetAccessErrorCodeBase - 15,
	kURLInvalidConfigurationError = kURLInternetAccessErrorCodeBase - 16,
	kURLAccessNotAvailableError	= kURLInternetAccessErrorCodeBase - 17,
	kURL68kNotSupportedError	= kURLInternetAccessErrorCodeBase - 18
};


#if PRAGMA_STRUCT_ALIGN
	#pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
	#pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __URLACCESS__ */
