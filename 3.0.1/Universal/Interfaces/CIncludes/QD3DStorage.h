/******************************************************************************
 **																			 **
 ** 	Module:		QD3DStorage.h											 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose: 	Abstraction to deal with various types of stream-based	 **
 **					storage devices.										 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1992-1997 Apple Computer, Inc.  All rights reserved.	 **
 ** 																		 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DStorage_h
#define QD3DStorage_h

#include "QD3D.h"

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=small
#endif

#include <Types.h>
#include <Files.h>

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=reset
	#pragma options enum=int
	#pragma options align=power
#elif defined(__MWERKS__)
	#pragma enumsalwaysint on
	#pragma options align=native
#elif defined(__MRC__) || defined(__SC__)
	#if __option(pack_enums)
		#define PRAGMA_ENUM_RESET_QD3DSTORAGE 1
	#endif
	#pragma options(!pack_enums)
	#pragma options align=power
#endif

#endif  /*  OS_MACINTOSH  */


#if defined(OS_WIN32) && OS_WIN32
#include <windows.h>
#endif /* OS_WIN32 */


#ifdef __cplusplus
extern "C" {
#endif	/* __cplusplus */

/******************************************************************************
 **																			 **
 **								Storage Routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3Storage_GetType(
	TQ3StorageObject	storage);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Storage_GetSize(
	TQ3StorageObject	storage,
	unsigned long		*size);

/* 
 *	Reads "dataSize" bytes starting at offset in storage, copying into data. 
 *	sizeRead returns the number of bytes filled in. 
 *	
 *	You may assume if *sizeRead < dataSize, then EOF is at offset + *sizeRead
 */

QD3D_EXPORT TQ3Status QD3D_CALL Q3Storage_GetData(
	TQ3StorageObject	storage,
	unsigned long		offset,
	unsigned long		dataSize,
	unsigned char		*data,
	unsigned long		*sizeRead);

/* 
 *	Write "dataSize" bytes starting at offset in storage, copying from data. 
 *	sizeWritten returns the number of bytes filled in. 
 *	
 *	You may assume if *sizeRead < dataSize, then EOF is at offset + *sizeWritten
 */

QD3D_EXPORT TQ3Status QD3D_CALL Q3Storage_SetData(
	TQ3StorageObject	storage,
	unsigned long		offset,
	unsigned long		dataSize,
	const unsigned char	*data,
	unsigned long		*sizeWritten);

/******************************************************************************
 **																			 **
 **							 Memory Storage Prototypes						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3MemoryStorage_GetType(
	TQ3StorageObject		storage);

/*
 * These calls COPY the buffer into QD3D space
 */
QD3D_EXPORT TQ3StorageObject QD3D_CALL Q3MemoryStorage_New(
	const unsigned char		*buffer,
	unsigned long			validSize);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MemoryStorage_Set(
 	TQ3StorageObject		storage,
	const unsigned char		*buffer,
	unsigned long			validSize);

/*
 * These calls use the pointer given - you must dispose it when you're through
 */
QD3D_EXPORT TQ3StorageObject QD3D_CALL Q3MemoryStorage_NewBuffer(
	unsigned char			*buffer,
	unsigned long			validSize,
	unsigned long			bufferSize);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MemoryStorage_SetBuffer(
 	TQ3StorageObject		storage,
	unsigned char			*buffer,
	unsigned long			validSize,
	unsigned long			bufferSize);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MemoryStorage_GetBuffer(
 	TQ3StorageObject		storage,
	unsigned char			**buffer,
	unsigned long			*validSize,
	unsigned long			*bufferSize);

#if defined(OS_MACINTOSH) && OS_MACINTOSH

/******************************************************************************
 **																			 **
 **								Macintosh Handles Prototypes				 **
 **																			 **
 *****************************************************************************/

/* Handle Storage is a subclass of Memory Storage */

QD3D_EXPORT TQ3StorageObject QD3D_CALL Q3HandleStorage_New(
	Handle					handle,
	unsigned long			validSize);

QD3D_EXPORT TQ3Status QD3D_CALL Q3HandleStorage_Set(
 	TQ3StorageObject		storage,
	Handle					handle,
	unsigned long			validSize);

QD3D_EXPORT TQ3Status QD3D_CALL Q3HandleStorage_Get(
 	TQ3StorageObject		storage,
 	Handle					*handle,
	unsigned long			*validSize);

/******************************************************************************
 **																			 **
 **								Macintosh Storage Prototypes				 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3StorageObject QD3D_CALL Q3MacintoshStorage_New(					
	short					fsRefNum);	/* Note: This storage is assumed open*/

QD3D_EXPORT TQ3Status QD3D_CALL Q3MacintoshStorage_Set(
 	TQ3StorageObject		storage,
	short					fsRefNum);

QD3D_EXPORT TQ3Status QD3D_CALL Q3MacintoshStorage_Get(
 	TQ3StorageObject		storage,
	short					*fsRefNum);
	
QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3MacintoshStorage_GetType(
	TQ3StorageObject		storage);


/******************************************************************************
 **																			 **
 **							Macintosh FSSpec Storage Prototypes				 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3StorageObject QD3D_CALL Q3FSSpecStorage_New(
	const FSSpec			*fs);

QD3D_EXPORT TQ3Status QD3D_CALL Q3FSSpecStorage_Set(
 	TQ3StorageObject		storage,
	const FSSpec			*fs);

QD3D_EXPORT TQ3Status QD3D_CALL Q3FSSpecStorage_Get(
 	TQ3StorageObject		storage,
	FSSpec					*fs);

#endif  /*  OS_MACINTOSH  */

#if defined(OS_WIN32) && OS_WIN32

/******************************************************************************
 **																			 **
 **							Win32 HANDLE Storage Prototypes					 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3StorageObject QD3D_CALL Q3Win32Storage_New(
	const HANDLE			hFile);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Win32Storage_Set(
 	TQ3StorageObject		storage,
	const HANDLE			hFile);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Win32Storage_Get(
 	TQ3StorageObject		storage,
	const HANDLE			*hFile);

#endif  /*  OS_WIN32  */

/******************************************************************************
 **																			 **
 **									Unix Prototypes							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3StorageObject QD3D_CALL Q3UnixStorage_New(
	FILE					*storage);

QD3D_EXPORT TQ3Status QD3D_CALL Q3UnixStorage_Set(
 	TQ3StorageObject		storage,
	FILE					*stdFile);

QD3D_EXPORT TQ3Status QD3D_CALL Q3UnixStorage_Get(
 	TQ3StorageObject		storage,
	FILE					**stdFile);
	
QD3D_EXPORT TQ3ObjectType QD3D_CALL Q3UnixStorage_GetType(
	TQ3StorageObject		storage);


/******************************************************************************
 **																			 **
 **								Unix Path Prototypes						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3StorageObject QD3D_CALL Q3UnixPathStorage_New(					
	const char				*pathName);				/* C string */

QD3D_EXPORT TQ3Status QD3D_CALL Q3UnixPathStorage_Set(			
 	TQ3StorageObject		storage,
	const char				*pathName);				/* C string */

QD3D_EXPORT TQ3Status QD3D_CALL Q3UnixPathStorage_Get(			
 	TQ3StorageObject		storage,
	char					*pathName);				/* pathName is a buffer */

#ifdef __cplusplus
}
#endif	/* __cplusplus */

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=reset
	#pragma options align=reset
#elif defined(__MWERKS__)
	#pragma enumsalwaysint reset
	#pragma options align=reset
#elif defined(__MRC__) || defined(__SC__)
	#if PRAGMA_ENUM_RESET_QD3DSTORAGE
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DSTORAGE
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif /* QD3DStorage_h */
