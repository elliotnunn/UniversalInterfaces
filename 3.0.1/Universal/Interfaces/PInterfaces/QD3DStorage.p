{
 	File:		QD3DStorage.p
 
 	Contains:	Abstraction to deal with various types of stream-based storage devices		
 
 	Version:	Technology:	Quickdraw 3D 1.5.1
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1995-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DStorage;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DSTORAGE__}
{$SETC __QD3DSTORAGE__ := 1}

{$I+}
{$SETC QD3DStorageIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$ENDC}  {TARGET_OS_MAC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **																			 **
 **								Storage Routines							 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Storage_GetType(storage: TQ3StorageObject): LONGINT; C;
FUNCTION Q3Storage_GetSize(storage: TQ3StorageObject; VAR size: LONGINT): TQ3Status; C;
{ 
 *	Reads "dataSize" bytes starting at offset in storage, copying into data. 
 *	sizeRead returns the number of bytes filled in. 
 *	
 *	You may assume if *sizeRead < dataSize, then EOF is at offset + *sizeRead
 }
FUNCTION Q3Storage_GetData(storage: TQ3StorageObject; offset: LONGINT; dataSize: LONGINT; VAR data: UInt8; VAR sizeRead: LONGINT): TQ3Status; C;
{ 
 *	Write "dataSize" bytes starting at offset in storage, copying from data. 
 *	sizeWritten returns the number of bytes filled in. 
 *	
 *	You may assume if *sizeRead < dataSize, then EOF is at offset + *sizeWritten
 }
FUNCTION Q3Storage_SetData(storage: TQ3StorageObject; offset: LONGINT; dataSize: LONGINT; {CONST}VAR data: UInt8; VAR sizeWritten: LONGINT): TQ3Status; C;
{*****************************************************************************
 **																			 **
 **							 Memory Storage Prototypes						 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3MemoryStorage_GetType(storage: TQ3StorageObject): LONGINT; C;
{
 * These calls COPY the buffer into QD3D space
 }
FUNCTION Q3MemoryStorage_New({CONST}VAR buffer: UInt8; validSize: LONGINT): TQ3StorageObject; C;
FUNCTION Q3MemoryStorage_Set(storage: TQ3StorageObject; {CONST}VAR buffer: UInt8; validSize: LONGINT): TQ3Status; C;
{
 * These calls use the pointer given - you must dispose it when you're through
 }
FUNCTION Q3MemoryStorage_NewBuffer(buffer: Ptr; validSize: LONGINT; bufferSize: LONGINT): TQ3StorageObject; C;
FUNCTION Q3MemoryStorage_SetBuffer(storage: TQ3StorageObject; buffer: Ptr; validSize: LONGINT; bufferSize: LONGINT): TQ3Status; C;
FUNCTION Q3MemoryStorage_GetBuffer(storage: TQ3StorageObject; VAR buffer: Ptr; VAR validSize: LONGINT; VAR bufferSize: LONGINT): TQ3Status; C;
{$IFC TARGET_OS_MAC }
{*****************************************************************************
 **																			 **
 **								Macintosh Handles Prototypes				 **
 **																			 **
 ****************************************************************************}
{ Handle Storage is a subclass of Memory Storage }
FUNCTION Q3HandleStorage_New(handle: Handle; validSize: LONGINT): TQ3StorageObject; C;
FUNCTION Q3HandleStorage_Set(storage: TQ3StorageObject; handle: Handle; validSize: LONGINT): TQ3Status; C;
FUNCTION Q3HandleStorage_Get(storage: TQ3StorageObject; VAR handle: Handle; VAR validSize: LONGINT): TQ3Status; C;
{*****************************************************************************
 **																			 **
 **								Macintosh Storage Prototypes				 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3MacintoshStorage_New(fsRefNum: INTEGER): TQ3StorageObject; C;
{ Note: This storage is assumed open }
FUNCTION Q3MacintoshStorage_Set(storage: TQ3StorageObject; fsRefNum: INTEGER): TQ3Status; C;
FUNCTION Q3MacintoshStorage_Get(storage: TQ3StorageObject; VAR fsRefNum: INTEGER): TQ3Status; C;
FUNCTION Q3MacintoshStorage_GetType(storage: TQ3StorageObject): LONGINT; C;

{*****************************************************************************
 **																			 **
 **							Macintosh FSSpec Storage Prototypes				 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3FSSpecStorage_New({CONST}VAR fs: FSSpec): TQ3StorageObject; C;
FUNCTION Q3FSSpecStorage_Set(storage: TQ3StorageObject; {CONST}VAR fs: FSSpec): TQ3Status; C;
FUNCTION Q3FSSpecStorage_Get(storage: TQ3StorageObject; VAR fs: FSSpec): TQ3Status; C;
{$ENDC}  {TARGET_OS_MAC}

{$IFC TARGET_OS_WIN32 }
{*****************************************************************************
 **																			 **
 **							Win32 HANDLE Storage Prototypes					 **
 **																			 **
 ****************************************************************************}
FUNCTION Q3Win32Storage_New(hFile: HANDLE): TQ3StorageObject; C;
FUNCTION Q3Win32Storage_Set(storage: TQ3StorageObject; hFile: HANDLE): TQ3Status; C;
FUNCTION Q3Win32Storage_Get(storage: TQ3StorageObject; VAR hFile: HANDLE): TQ3Status; C;
{$ENDC}  {TARGET_OS_WIN32}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DStorageIncludes}

{$ENDC} {__QD3DSTORAGE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
