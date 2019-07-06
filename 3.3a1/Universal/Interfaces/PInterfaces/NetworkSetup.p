{
 	File:		NetworkSetup.p
 
 	Contains:	Network Setup Interfaces
 
 	Version:	Technology:	1.1.0
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1998-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT NetworkSetup;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __NETWORKSETUP__}
{$SETC __NETWORKSETUP__ := 1}

{$I+}
{$SETC NetworkSetupIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __OPENTRANSPORT__}
{$I OpenTransport.p}
{$ENDC}
{$IFC UNDEFINED __OPENTRANSPORTPROVIDERS__}
{$I OpenTransportProviders.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CfgDatabaseRef = ^LONGINT; { an opaque 32-bit type }
	CfgAreaID							= UInt32;
	CfgEntityClass						= OSType;
	CfgEntityType						= OSType;
	CfgEntityRefPtr = ^CfgEntityRef;
	CfgEntityRef = RECORD
		fLoc:					CfgAreaID;
		fReserved:				UInt32;
		fID:					Str255;
	END;

	CfgResourceLocatorPtr = ^CfgResourceLocator;
	CfgResourceLocator = RECORD
		fFile:					FSSpec;
		fResID:					UInt16;
	END;

	CfgEntityInfoPtr = ^CfgEntityInfo;
	CfgEntityInfo = RECORD
		fClass:					CfgEntityClass;
		fType:					CfgEntityType;
		fName:					Str255;
		fIcon:					CfgResourceLocator;
	END;

	CfgEntityAccessID					= Ptr;
	CfgPrefsHeaderPtr = ^CfgPrefsHeader;
	CfgPrefsHeader = RECORD
		fSize:					UInt16;									{  size includes this header }
		fVersion:				UInt16;
		fType:					OSType;
	END;

{	-------------------------------------------------------------------------
	Error codes
	------------------------------------------------------------------------- }

CONST
	kCfgErrDatabaseChanged		= -3290;						{  database has changed since last call - close and reopen DB }
	kCfgErrAreaNotFound			= -3291;						{  Area doesn't exist }
	kCfgErrAreaAlreadyExists	= -3292;						{  Area already exists }
	kCfgErrAreaNotOpen			= -3293;						{  Area needs to open first }
	kCfgErrConfigLocked			= -3294;						{  Access conflict - retry later }
	kCfgErrEntityNotFound		= -3295;						{  An entity with this name doesn't exist }
	kCfgErrEntityAlreadyExists	= -3296;						{  An entity with this name already exists }
	kCfgErrPrefsTypeNotFound	= -3297;						{  An record with this PrefsType doesn't exist }
	kCfgErrDataTruncated		= -3298;						{  Data truncated when read buffer too small }
	kCfgErrFileCorrupted		= -3299;						{  The database format appears to be corrupted. }

{ 	reserve a 'free' tag for free blocks }
	kCfgTypefree				= 'free';

{	-------------------------------------------------------------------------
	CfgEntityClass / CfgEntityType

	The database can distinguish between several classes of objects and 
	several types withing each class
	Use of different classes allow to store type of information in the same database

	Other entity classes and types can be defined by developers.
	they should be unique and registered with Developer Tech Support (DTS)
	------------------------------------------------------------------------- }
	kCfgClassAnyEntity			= '****';
	kCfgClassUnknownEntity		= '????';
	kCfgTypeAnyEntity			= '****';
	kCfgTypeUnknownEntity		= '????';

{	-------------------------------------------------------------------------
	For CfgIsSameEntityRef
	------------------------------------------------------------------------- }
	kCfgIgnoreArea				= true;
	kCfgDontIgnoreArea			= false;

{******************************************************************************
**	Configuration Information Access API 
*******************************************************************************}
{	-------------------------------------------------------------------------
	Database access
	------------------------------------------------------------------------- }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTCfgOpenDatabase(VAR dbRef: CfgDatabaseRef): OSStatus;
{
	OTCfgOpenDatabase()

	Inputs:		none
	Outputs:	CfgDatabaseRef* dbRef			Reference to opened database
	Returns:	OSStatus						*** list errors ***

	Opens the Configuration API for a given client. This call should be made prior to any other call.
}
FUNCTION OTCfgCloseDatabase(VAR dbRef: CfgDatabaseRef): OSStatus;
{
	OTCfgCloseDatabase()

	Inputs:		CfgDatabaseRef* dbRef			Reference to opened database
	Outputs:	CfgDatabaseRef* dbRef			Reference to opened database is cleared
	Returns:	OSStatus						*** list errors ***

	Closes the Configuration API for a given client. This call should be made when the client no 
	longer wants to use the Configuration API.  
}
{	-------------------------------------------------------------------------
	Area management
	------------------------------------------------------------------------- }
FUNCTION OTCfgGetAreasCount(dbRef: CfgDatabaseRef; VAR itemCount: ItemCount): OSStatus;
{
	OTCfgGetAreasCount()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
	Outputs:	ItemCount* itemCount			Number of entities defined
	Returns:	OSStatus						*** list errors ***

	Returns the number of areas currently defined.
}
FUNCTION OTCfgGetAreasList(dbRef: CfgDatabaseRef; VAR itemCount: ItemCount; VAR areaID: CfgAreaID; VAR areaName: Str255): OSStatus;
{
	OTCfgGetAreasList()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				ItemCount* itemCount			Number of entities requested
	Outputs:	ItemCount* itemCount			Number of entities defined
	Returns:	OSStatus						*** list errors ***

	Returns a list of area IDs and names. On entry, count should be set to whatever OTCfgGetAreasCount 
	returned.  On exit, count contains the actual number of areas found. This can be less than the 
	initial count value if areas were deleted in the meantime.  The id and name parameters are stored 
	in arrays that should each be able to contain count values.
}
FUNCTION OTCfgGetCurrentArea(dbRef: CfgDatabaseRef; VAR areaID: CfgAreaID): OSStatus;
{
	OTCfgGetCurrentArea()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
	Outputs:	CfgAreaID* areaID				ID of current area
	Returns:	OSStatus						*** list errors ***

	Returns the id of the current area.
}
FUNCTION OTCfgSetCurrentArea(dbRef: CfgDatabaseRef; areaID: CfgAreaID): OSStatus;
{
	OTCfgSetCurrentArea()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgAreaID areaID				ID of area to make active
	Outputs:	none
	Returns:	OSStatus						*** list errors ***

	Sets the current area. If the area doesn’t exist kCfgErrAreaNotFound is returned.
}
FUNCTION OTCfgCreateArea(dbRef: CfgDatabaseRef; areaName: Str255; VAR areaID: CfgAreaID): OSStatus;
{
	OTCfgCreateArea()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				ConstStr255Param areaName		Name of area to create
	Outputs:	CfgAreaID* areaID				ID of newly created area
	Returns:	OSStatus						*** list errors ***

	Creates a new area with the specified name. Then name must be unique or kCfgErrAreaAlreadyExists 
	will be returned.
}
FUNCTION OTCfgDeleteArea(dbRef: CfgDatabaseRef; areaID: CfgAreaID): OSStatus;
{
	OTCfgDeleteArea()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgAreaID areaID				ID of area to delete
	Outputs:	none
	Returns:	OSStatus						*** list errors ***

	Deletes the specified area. If the area doesn’t exist kCfgErrAreaNotFound is returned.
}
FUNCTION OTCfgDuplicateArea(dbRef: CfgDatabaseRef; sourceAreaID: CfgAreaID; destAreaID: CfgAreaID): OSStatus;
{
	OTCfgDuplicateArea()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgAreaID sourceAreaID			Area to duplicate
				CfgAreaID destAreaID			Area to contain duplicate
	Outputs:	none
	Returns:	OSStatus						*** list errors ***

	Duplicates the source area content into the destination area. Both areas should exist prior to 
	making this call. If either area doesn’t exist kCfgErrAreaNotFound is returned.
}
FUNCTION OTCfgSetAreaName(dbRef: CfgDatabaseRef; areaID: CfgAreaID; areaName: Str255; VAR newAreaID: CfgAreaID): OSStatus;
{
	OTCfgSetAreaName()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgAreaID areaID				ID of area being named
				ConstStr255Param areaName		New name for area
	Outputs:	CfgAreaID* newAreaID			ID of renamed area
	Returns:	OSStatus						*** list errors ***

	Renames the specified area. A new id is returned: it should be used from now on. If the area 
	doesn’t exist kCfgErrAreaNotFound is returned.
}
FUNCTION OTCfgGetAreaName(dbRef: CfgDatabaseRef; areaID: CfgAreaID; VAR areaName: Str255): OSStatus;
{
	OTCfgGetAreaName()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgAreaID areaID				ID of area being queried
	Outputs:	Str255 areaName					Name of area
	Returns:	OSStatus						*** list errors ***

	Gets the name of the specified area. If the area doesn’t exist kCfgErrAreaNotFound is returned.
}
{	-------------------------------------------------------------------------
	Configuration Database API
	
	Single Writer ONLY!!!
	------------------------------------------------------------------------- }
{	-------------------------------------------------------------------------
	Opening an area for reading
	------------------------------------------------------------------------- }
FUNCTION OTCfgOpenArea(dbRef: CfgDatabaseRef; areaID: CfgAreaID): OSStatus;
{
	OTCfgOpenArea()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgAreaID areaID				ID of area to open
	Outputs:	none
	Returns:	OSStatus						*** list errors ***

	Opens the specified area for reading. If the area doesn’t exist kCfgErrAreaNotFound is returned.
}
FUNCTION OTCfgCloseArea(dbRef: CfgDatabaseRef; areaID: CfgAreaID): OSStatus;
{
	OTCfgCloseArea()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgAreaID areaID				ID of area to close
	Outputs:	none
	Returns:	OSStatus						*** list errors ***

	Closes an area opened for reading. If the area doesn’t exist kCfgErrAreaNotFound is returned.  
	Opening an area for writing All modifications to an area should be performed as part of a 
	transaction.
}
{
	For write access
}
FUNCTION OTCfgBeginAreaModifications(dbRef: CfgDatabaseRef; readAreaID: CfgAreaID; VAR writeAreaID: CfgAreaID): OSStatus;
{
	OTCfgBeginAreaModifications()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgAreaID readAreaID			ID of area opened for reading
	Outputs:	CfgAreaID* writeAreaID			ID of area opened for modification
	Returns:	OSStatus						*** list errors ***

	Opens the specified area for writing. A new area id is provided.  This area id should be used to 
	enumerate, add, delete, read and write to the modified data. The original id can still be used to 
	access the original unmodified data. If the area doesn’t exist kCfgErrAreaNotFound is returned.
}
FUNCTION OTCfgCommitAreaModifications(dbRef: CfgDatabaseRef; readAreaID: CfgAreaID; writeAreaID: CfgAreaID): OSStatus;
{
	OTCfgCommitAreaModifications()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgAreaID readAreaID			ID of area opened for reading
				CfgAreaID writeAreaID			ID of area opened for modification
	Outputs:	none
	Returns:	OSStatus						*** list errors ***

	Closes an area opened for writing.  All modifications are committed and readers are informed that 
	the database changed state ( kCfgStateChangedErr ). The areaID should be the id of the original 
	area.  If the area doesn’t exist or the wrong id is passed, kCfgErrAreaNotFound is returned.
}
FUNCTION OTCfgAbortAreaModifications(dbRef: CfgDatabaseRef; readAreaID: CfgAreaID): OSStatus;
{
	OTCfgAbortAreaModifications()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgAreaID readAreaID			ID of area opened for reading
	Outputs:	none
	Returns:	OSStatus						*** list errors ***

	Closes an area opened for writing, discarding any modification. The areaID should be the id of 
	the original area. If the area doesn’t exist or the wrong id is passed kCfgErrAreaNotFound is 
	returned.
}
{
	Working with entities

	Entities can be manipulated as soon as an area has been opened.  The same calls work both for 
	areas opened for reading or for modification. In the latter case, the calls can be used on the 
	original or new area id to access the original data or the modified data.
}
{
	For everybody
	Count receives the actual number of entities
}
FUNCTION OTCfgGetEntitiesCount(dbRef: CfgDatabaseRef; areaID: CfgAreaID; entityClass: CfgEntityClass; entityType: CfgEntityType; VAR itemCount: ItemCount): OSStatus;
{
	OTCfgGetEntitiesCount()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgAreaID areaID				ID of area to count
				CfgEntityClass entityClass		Class of entities to count
				CfgEntityType entityType		Type of entities to count
	Outputs:	ItemCount* itemCount			Count of matching entities
	Returns:	OSStatus						*** list errors ***

	Returns the number of entities of the specified class and type in the specified area. To obtain 
	all entities regardless of their class or type pass kCfgClassAnyEntity or kCfgTypeAnyEntity. If 
	the area doesn’t exist or the wrong id is passed kCfgErrAreaNotFound is returned.
}

{
	Count as input, is the number of entities to read;
	count as output, receives the actual number of entities or the number you specified. 
}
FUNCTION OTCfgGetEntitiesList(dbRef: CfgDatabaseRef; areaID: CfgAreaID; entityClass: CfgEntityClass; entityType: CfgEntityType; VAR itemCount: ItemCount; VAR entityRef: CfgEntityRef; VAR entityInfo: CfgEntityInfo): OSStatus;
{
	OTCfgGetEntitiesList()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgAreaID areaID				ID of area to list
				CfgEntityClass entityClass		Class of entities to list
				CfgEntityType entityType		Type of entities to list
				ItemCount* itemCount			Count of entities requested
	Outputs:	ItemCount* itemCount			Count of entities listed
	Returns:	OSStatus						*** list errors ***

	Returns the list of entities of the specified class and type in the specified area. To obtain all 
	entities regardless of their class or type pass kCfgClassAnyEntity or kCfgTypeAnyEntity. The 
	count parameter should have the value obtained by CfgGetEntitiesCount.  On exit count may be less 
	if some entities were deleted in the meantime. The id and info parameters should be arrays large 
	enough to hold count entries. If the area doesn’t exist or the wrong id is passed 
	kCfgErrAreaNotFound is returned.  The info array contains information about each entity, 
	including its class, type, name and the area of its icon:

	struct CfgEntityInfo
	(
		CfgEntityClass		fClass;
		CfgEntityType		fType;
		ConstStr255Param	fName;
		CfgResourceLocator	fIcon;
	);
}
FUNCTION OTCfgCreateEntity(dbRef: CfgDatabaseRef; areaID: CfgAreaID; {CONST}VAR entityInfo: CfgEntityInfo; VAR entityRef: CfgEntityRef): OSStatus;
{
	OTCfgCreateEntity()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgAreaID areaID				ID of area to contain entity
				CfgEntityInfo* entityInfo		Information that defines the entity
	Outputs:	CfgEntityRef* entityRef			Reference to entity created
	Returns:	OSStatus						*** list errors ***

	Creates a new entity with the specified class, type and name and returns an id for it. If the 
	area doesn’t exist or the wrong id is passed kCfgErrAreaNotFound is returned. If there is already 
	an entity with the same name kCfgErrEntityAlreadyExists is returned.
}
FUNCTION OTCfgDeleteEntity(dbRef: CfgDatabaseRef; {CONST}VAR entityRef: CfgEntityRef): OSStatus;
{
	OTCfgDeleteEntity()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgEntityRef* entityRef			Reference to entity to delete
	Outputs:	none
	Returns:	OSStatus						*** list errors ***

	Deletes the specified entity. If there is no entity with this id kCfgEntityNotfoundErr is returned
}
FUNCTION OTCfgDuplicateEntity(dbRef: CfgDatabaseRef; {CONST}VAR entityRef: CfgEntityRef; {CONST}VAR newEntityRef: CfgEntityRef): OSStatus;
{
	OTCfgDuplicateEntity()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgEntityRef* entityRef			Reference to entity to duplicate
	Outputs:	CfgEntityRef* newEntityRef		Reference to duplicate entity
	Returns:	OSStatus						*** list errors ***

	Duplicates the specified entity. Both entities should exit. If any entity doesn’t exist 
	kCfgErrEntityNotFound is returned.
}
FUNCTION OTCfgSetEntityName(dbRef: CfgDatabaseRef; {CONST}VAR entityRef: CfgEntityRef; entityName: Str255; VAR newEntityRef: CfgEntityRef): OSStatus;
{
	OTCfgSetEntityName()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgEntityRef* entityRef			Reference to entity to duplicate
				ConstStr255Param entityName		New name for entity
	Outputs:	CfgEntityRef* newEntityRef		Reference to renamed entity
	Returns:	OSStatus						*** list errors ***

	Renames the specified entity. If the entity doesn’t exist kCfgEntityNotfoundErr is returned. If 
	there is already an entity with that name kCfgErrEntityAlreadyExists is returned.
}
PROCEDURE OTCfgGetEntityArea({CONST}VAR entityRef: CfgEntityRef; VAR areaID: CfgAreaID);
{
	OTCfgGetEntityArea()

	Inputs:		CfgEntityRef *entityRef			Reference to an entity
	Outputs:	CfgAreaID *areaID				ID of area that contains the entity
	Returns:	none

	Returns the area ID associated with the specified entity reference.
}
PROCEDURE OTCfgGetEntityName({CONST}VAR entityRef: CfgEntityRef; VAR entityName: Str255);
{
	OTCfgGetEntityName()

	Inputs:		CfgEntityRef *entityRef			Reference to an entity
	Outputs:	Str255 entityName				Name of the entity
	Returns:	none

	Returns the entity name associated with the specified entity reference.
}
PROCEDURE OTCfgChangeEntityArea(VAR entityRef: CfgEntityRef; newAreaID: CfgAreaID);
{
	OTCfgChangeEntityArea()

	Inputs:		CfgEntityRef *entityRef			Reference to an entity
				CfgAreaID newAreaID				ID of area to contain moved entity
	Outputs:	none
	Returns:	none

	Changes the area ID associated with the specified entity reference. This effectively moves the 
	entity to a different area.
}
{	-------------------------------------------------------------------------
	These API calls are for the protocol developers to compare the IDs.
	------------------------------------------------------------------------- }
{	-------------------------------------------------------------------------
	For OTCfgIsSameEntityRef
	------------------------------------------------------------------------- }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kOTCfgIgnoreArea			= 1;
	kOTCfgDontIgnoreArea		= 0;

{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTCfgIsSameEntityRef({CONST}VAR entityRef1: CfgEntityRef; {CONST}VAR entityRef2: CfgEntityRef; ignoreArea: BOOLEAN): BOOLEAN;
{
	OTCfgIsSameEntityRef()

	Inputs:		CfgEntityRef* entityRef1		Reference to an entity
				CfgEntityRef* entityRef2		Reference to another entity
				Boolean ignoreArea				If true, ignore the area ID
	Outputs:	none
	Returns:	Boolean							If true, entity references match

	Compare two entity references. If ignoreArea is true, and the two entity names are the same, then return 
	true. If ignoreArea is false, then the area IDs must be the same, as well as the entity names 
	must be the same, then can return true.
}
FUNCTION OTCfgIsSameAreaID(areaID1: CfgAreaID; areaID2: CfgAreaID): BOOLEAN;
{
	OTCfgIsSameAreaID()

	Inputs:		CfgAreaID areaID1				ID of an area
				CfgAreaID areaID2				ID of another area
	Outputs:	none
	Returns:	Boolean							If true, area IDs match

	Compare two area IDs. Return true for matching area IDs, and return false for the different area IDs.
}
{	-------------------------------------------------------------------------
	Dealing with individual preferences
	------------------------------------------------------------------------- }
{	-------------------------------------------------------------------------
	Open Preferences
	if writer = true, GetPrefs and SetPrefs are allowed, else only GetPrefs is allowed.
	------------------------------------------------------------------------- }
FUNCTION OTCfgOpenPrefs(dbRef: CfgDatabaseRef; {CONST}VAR entityRef: CfgEntityRef; writer: BOOLEAN; VAR accessID: CfgEntityAccessID): OSStatus;
{
	OTCfgOpenPrefs()

	Inputs:		CfgDatabaseRef dbRef			Reference to opened database
				CfgEntityRef* entityRef			Reference to an entity
				Boolean writer				If true, open for write
	Outputs:	CfgEntityAccessID* accessID		ID for entity access
	Returns:	OSStatus						*** list errors ***

	Open the specified entity and return the CfgEntityAccessID for the following access of the 
	content of the entity. If writer is true, CfgGetPrefs and CfgSetPrefs are allowed, otherwise only 
	CfgGetPrefs is allowed.
}
FUNCTION OTCfgClosePrefs(accessID: CfgEntityAccessID): OSStatus;
{
	OTCfgClosePrefs()

	Inputs:		CfgEntityAccessID* accessID		ID for entity to close
	Outputs:	none
	Returns:	OSStatus						*** list errors ***

	Close the entity with the specified CfgEntityAccessID.
}
{	-------------------------------------------------------------------------
	Get/Set Preferences

	Accessing the content of an entity

	These API calls are for the protocol developers. It supports multiple records per entity. Each 
	record is identified by the prefsType and the size of the record. The protocol stack will provide 
	the STRUCT to view the content of each record.
	------------------------------------------------------------------------- }
FUNCTION OTCfgSetPrefs(accessID: CfgEntityAccessID; prefsType: OSType; data: UNIV Ptr; length: ByteCount): OSStatus;
{
	OTCfgSetPrefs()

	Inputs:		CfgEntityAccessID* accessID		ID of entity to access
				OSType prefsType				Record type to set
				void* data						Address of data
				ByteCount length				Number of bytes of data
	Outputs:	none
	Returns:	OSStatus						*** list errors ***

	Write the data to the specified record. The record is identified by the prefsType. If the entity 
	is not opened for the writer, an error code is returned.
}
FUNCTION OTCfgGetPrefs(accessID: CfgEntityAccessID; prefsType: OSType; data: UNIV Ptr; length: ByteCount): OSStatus;
{
	OTCfgGetPrefs()

	Inputs:		CfgEntityAccessID* accessID		ID of entity to access
				OSType prefsType				Record type to get
				void* data						Address for data
				ByteCount length				Number of bytes of data requested
	Outputs:	none
	Returns:	OSStatus						*** list errors ***

	Read the data from the specified record to the passed buffer. The record is identified by the 
	prefsType. If the passed buffer is too small, kCfgErrDataTruncated is returned, but will copy as 
	many data as possible to the buffer.
}
FUNCTION OTCfgGetPrefsSize(accessID: CfgEntityAccessID; prefsType: OSType; VAR length: ByteCount): OSStatus;
{
	OTCfgGetPrefsSize()

	Inputs:		CfgEntityAccessID* accessID		ID of entity to access
				OSType prefsType				Record type to get
				ByteCount length				Number of bytes of data available
	Outputs:	none
	Returns:	OSStatus						*** list errors ***

	Returns the length, in bytes, of the specified record. The record is identified by the prefsType.
}
{	-------------------------------------------------------------------------
	Get table of contents for prefs
	------------------------------------------------------------------------- }
FUNCTION OTCfgGetPrefsTOCCount(accessID: CfgEntityAccessID; VAR itemCount: ItemCount): OSStatus;
{
	OTCfgGetPrefsTOCCount()

	Inputs:		CfgEntityAccessID* accessID		ID of entity to access
	Outputs:	ItemCount* itemCount			Number of entries available
	Returns:	OSStatus						*** list errors ***

	Get the count of all the record headers in the entity. Return the number of records in the count. 
}
FUNCTION OTCfgGetPrefsTOC(accessID: CfgEntityAccessID; VAR itemCount: ItemCount; VAR PrefsTOC: CfgPrefsHeader): OSStatus;
{
	OTCfgGetPrefsTOC()

	Inputs:		CfgEntityAccessID* accessID		ID of entity to access
				ItemCount* itemCount			Number of entries requested
	Outputs:	ItemCount* itemCount			Number of entries available
				CfgPrefsHeader PrefsTOC[]		Table of entries
	Returns:	OSStatus						*** list errors ***

	Get the list of all the record headers in the entity. Return the number of records in the count. 
	If the PrefsTOC is specified, it has to be big enough to hold all the record headers. If the 
	PrefsTOC is null, only the count is returned.
}
FUNCTION OTCfgEncrypt(VAR key: UInt8; VAR data: UInt8; dataLen: SInt16): SInt16;
{
	OTCfgEncrypt()

	Inputs:		UInt8 *key						encryption key ( user name )
				UInt8 *data						data to encrypt ( password )
				SInt16 dataLen					length of data to encrypt
	Outputs:	UInt8 *data						encrypted data
	Returns:	SInt16							length of encrypted data

	Encrypt the password, using the user name as the encryption key.  Return the encrypted password and its length.  
}
FUNCTION OTCfgDecrypt(VAR key: UInt8; VAR data: UInt8; dataLen: SInt16): SInt16;
{
	OTCfgDecrypt()

	Inputs:		UInt8 *key						encryption key ( user name )
				UInt8 *data						data to decrypt ( password )
				SInt16 dataLen					length of data to decrypt
	Outputs:	UInt8 *data						decrypted data
	Returns:	SInt16							length of decrypted data

	Decrypt the password, using the user name as the encryption key.  Return the decrypted password and its length.  
}
FUNCTION OTCfgGetDefault(entityType: ResType; entityClass: ResType; recordType: ResType): Handle;
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION OTCfgInstallNotifier(dbRef: CfgDatabaseRef; theClass: CfgEntityClass; theType: CfgEntityType; notifier: OTNotifyProcPtr; contextPtr: UNIV Ptr): OSStatus;
FUNCTION OTCfgRemoveNotifier(dbRef: CfgDatabaseRef; theClass: CfgEntityClass; theType: CfgEntityType): OSStatus;
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	OTCfgIRPortSetting					= UInt16;

CONST
	kOTCfgTypeStruct			= 'stru';
	kOTCfgTypeElement			= 'elem';
	kOTCfgTypeVector			= 'vect';

{	-------------------------------------------------------------------------
	CfgEntityClass / CfgEntityType

	The database can distinguish between several classes of objects and 
	several types withing each class
	Use of different classes allow to store type of information in the same database

	Other entity classes and types can be defined by developers.
	they should be unique and registered with Developer Tech Support (DTS)
	------------------------------------------------------------------------- }
	kOTCfgClassNetworkConnection = 'otnc';
	kOTCfgClassGlobalSettings	= 'otgl';
	kOTCfgClassServer			= 'otsv';
	kOTCfgTypeGeneric			= 'otan';
	kOTCfgTypeAppleTalk			= 'atlk';
	kOTCfgTypeTCPv4				= 'tcp4';
	kOTCfgTypeTCPv6				= 'tcp6';
	kOTCfgTypeRemote			= 'ara ';
	kOTCfgTypeDial				= 'dial';
	kOTCfgTypeModem				= 'modm';
	kOTCfgTypeInfrared			= 'infr';
	kOTCfgClassSetOfSettings	= 'otsc';
	kOTCfgTypeSetOfSettings		= 'otst';
	kOTCfgTypeDNS				= 'dns ';

{******************************************************************************
** Preferences Structures
*******************************************************************************}
	kOTCfgIndexSetsActive		= 0;
	kOTCfgIndexSetsEdit			= 1;
	kOTCfgIndexSetsLimit		= 2;							{ 	last value, no comma }


TYPE
	CfgSetsStructPtr = ^CfgSetsStruct;
	CfgSetsStruct = RECORD
		fFlags:					UInt32;
		fTimes:					ARRAY [0..1] OF UInt32;
	END;

	CfgSetsElementPtr = ^CfgSetsElement;
	CfgSetsElement = RECORD
		fEntityRef:				CfgEntityRef;
		fEntityInfo:			CfgEntityInfo;
	END;

	CfgSetsVectorPtr = ^CfgSetsVector;
	CfgSetsVector = RECORD
		fCount:					UInt32;
		fElements:				ARRAY [0..0] OF CfgSetsElement;
	END;

{	Common	}

CONST
																{ 	connection	 }
	kOTCfgTypeConfigName		= 'cnam';
	kOTCfgTypeConfigSelected	= 'ccfg';						{ 	transport options	 }
	kOTCfgTypeUserLevel			= 'ulvl';
	kOTCfgTypeWindowPosition	= 'wpos';

{	AppleTalk	}
																{ 	connection	 }
	kOTCfgTypeAppleTalkPrefs	= 'atpf';
	kOTCfgTypeAppleTalkVersion	= 'cvrs';
	kOTCfgTypeAppleTalkLocks	= 'lcks';
	kOTCfgTypeAppleTalkPort		= 'port';
	kOTCfgTypeAppleTalkProtocol	= 'prot';
	kOTCfgTypeAppleTalkPassword	= 'pwrd';
	kOTCfgTypeAppleTalkPortFamily = 'ptfm';						{ 	transport options	 }

	kOTCfgIndexAppleTalkAARP	= 0;
	kOTCfgIndexAppleTalkDDP		= 1;
	kOTCfgIndexAppleTalkNBP		= 2;
	kOTCfgIndexAppleTalkZIP		= 3;
	kOTCfgIndexAppleTalkATP		= 4;
	kOTCfgIndexAppleTalkADSP	= 5;
	kOTCfgIndexAppleTalkPAP		= 6;
	kOTCfgIndexAppleTalkASP		= 7;
	kOTCfgIndexAppleTalkLast	= 7;


TYPE
	OTCfgAppleTalkPrefsPtr = ^OTCfgAppleTalkPrefs;
	OTCfgAppleTalkPrefs = RECORD
		fVersion:				UInt16;
		fNumPrefs:				UInt16;
		fPort:					OTPortRef;
		fLink:					Ptr;
		fPrefs:					ARRAY [0..7] OF Ptr;
	END;

	OTCfgAARPPrefsPtr = ^OTCfgAARPPrefs;
	OTCfgAARPPrefs = RECORD
		fVersion:				UInt16;
		fSize:					UInt16;
		fAgingCount:			UInt32;
		fAgingInterval:			UInt32;
		fProtAddrLen:			OTByteCount;
		fHWAddrLen:				OTByteCount;
		fMaxEntries:			UInt32;
		fProbeInterval:			OTByteCount;
		fProbeRetryCount:		OTByteCount;
		fRequestInterval:		OTByteCount;
		fRequestRetryCount:		OTByteCount;
	END;

	OTCfgDDPPrefsPtr = ^OTCfgDDPPrefs;
	OTCfgDDPPrefs = RECORD
		fVersion:				UInt16;
		fSize:					UInt16;
		fTSDUSize:				UInt32;
		fLoadType:				SInt8;
		fNode:					SInt8;
		fNetwork:				UInt16;
		fRTMPRequestLimit:		UInt16;
		fRTMPRequestInterval:	UInt16;
		fAddressGenLimit:		UInt32;
		fBRCAgingInterval:		UInt32;
		fRTMPAgingInterval:		UInt32;
		fMaxAddrTries:			UInt32;
		fDefaultChecksum:		BOOLEAN;
		fIsFixedNode:			BOOLEAN;
		fMyZone:				PACKED ARRAY [0..32] OF UInt8;
	END;

	OTCfgATPFPrefsPtr = ^OTCfgATPFPrefs;
	OTCfgATPFPrefs = RECORD
		fAT:					OTCfgAppleTalkPrefs;
		fAARP:					OTCfgAARPPrefs;
		fDDP:					OTCfgDDPPrefs;
		fFill:					PACKED ARRAY [0..121] OF CHAR;
	END;

{	Infrared	}

CONST
	kOTCfgTypeInfraredPrefs		= 'atpf';
	kOTCfgTypeInfraredGlobal	= 'irgo';


TYPE
	OTCfgIRPrefsPtr = ^OTCfgIRPrefs;
	OTCfgIRPrefs = RECORD
		fHdr:					CfgPrefsHeader;
		fPort:					OTPortRef;								{ 	OT port id }
		fPortSetting:			OTCfgIRPortSetting;						{ 	Ir protocol,  irda or irtalk }
		fNotifyOnDisconnect:	BOOLEAN;								{ 	notify user on irda disconnect? }
		fDisplayIRControlStrip:	BOOLEAN;								{ 	show ir control strip? }
		fWindowPosition:		Point;									{ 	The position of the editor window }
	END;

	OTCfgIRGlobalPtr = ^OTCfgIRGlobal;
	OTCfgIRGlobal = RECORD
		fHdr:					CfgPrefsHeader;							{  standard prefererences header }
		fOptions:				UInt32;									{  options bitmask }
		fNotifyMask:			UInt32;									{  Notification options. }
		fUnloadTimeout:			UInt32;									{  Unload timeout (in milliseconds) }
	END;

{	TCP/IP v4	}

CONST
																{ 	connection	 }
	kOTCfgTypeTCPalis			= 'alis';
	kOTCfgTypeTCPcvrs			= 'cvrs';
	kOTCfgTypeTCPdcid			= 'dcid';
	kOTCfgTypeTCPdclt			= 'dclt';
	kOTCfgTypeTCPdtyp			= 'dtyp';
	kOTCfgTypeTCPidns			= 'idns';
	kOTCfgTypeTCPihst			= 'ihst';
	kOTCfgTypeTCPiitf			= 'iitf';
	kOTCfgTypeTCPara			= 'ipcp';
	kOTCfgTypeTCPirte			= 'irte';
	kOTCfgTypeTCPisdm			= 'isdm';
	kOTCfgTypeTCPstng			= 'stng';
	kOTCfgTypeTCPunld			= 'unld';
	kOTCfgTypeTCPVersion		= 'cvrs';						{ 	Version  }
	kOTCfgTypeTCPDevType		= 'dvty';
	kOTCfgTypeTCPPrefs			= 'iitf';
	kOTCfgTypeTCPServersList	= 'idns';
	kOTCfgTypeTCPSearchList		= 'ihst';
	kOTCfgTypeTCPRoutersList	= 'irte';
	kOTCfgTypeTCPDomainsList	= 'isdm';
	kOTCfgTypeTCPPort			= 'port';						{ 	Ports  }
	kOTCfgTypeTCPProtocol		= 'prot';
	kOTCfgTypeTCPPassword		= 'pwrd';						{ 	Password  }
	kOTCfgTypeTCPLocks			= 'stng';						{ 	locks  }
	kOTCfgTypeTCPUnloadType		= 'unld';						{ 	transport options	 }



TYPE
	OTCfgIDNSPrefsPtr = ^OTCfgIDNSPrefs;
	OTCfgIDNSPrefs = RECORD
		fCount:					INTEGER;
		fAddressesList:			InetHost;
	END;

	OTCfgHSTFPrefsPtr = ^OTCfgHSTFPrefs;
	OTCfgHSTFPrefs = PACKED RECORD
		fPrimaryInterfaceIndex:	CHAR;									{ 	always 1 in OT 1.0 / 1.1 }
																		{ 	this structure IS packed! }
		fLocalDomainName:		PACKED ARRAY [0..255] OF UInt8;
																		{ 	followed by  }
		admindomain:			PACKED ARRAY [0..255] OF UInt8;
	END;

{ 	This is your worst case, a fixed size structure, tacked on after a variable length string. }
{
  	This structure also contains an IP address and subnet mask that are not aligned on a four byte boundary.  
  	In order to avoid compiler warnings, and the possibility of code that won't work, 
  	these fields are defined here as four character arrays.  
  	It is suggested that BlockMoveData be used to copy to and from a field of type InetHost.  
}
	OTCfgIITFPrefsPartPtr = ^OTCfgIITFPrefsPart;
	OTCfgIITFPrefsPart = RECORD
		path:					PACKED ARRAY [0..35] OF CHAR;
		module:					PACKED ARRAY [0..31] OF CHAR;
		framing:				UInt32;
	END;

	OTCfgIITFPrefsPtr = ^OTCfgIITFPrefs;
	OTCfgIITFPrefs = PACKED RECORD
		fCount:					INTEGER;
		fConfigMethod:			UInt8;
																		{ 	this structure IS packed! }
																		{ 	Followed by: }
		fIPAddress:				PACKED ARRAY [0..3] OF UInt8;
		fSubnetMask:			PACKED ARRAY [0..3] OF UInt8;
		fAppleTalkZone:			PACKED ARRAY [0..255] OF UInt8;
																		{ 	this structure IS packed! }
		fFiller:				UInt8;
		part:					OTCfgIITFPrefsPart;
	END;

	OTCfgIRTEEntryPtr = ^OTCfgIRTEEntry;
	OTCfgIRTEEntry = RECORD
		fToHost:				InetHost;								{ 	always 0; }
		fViaHost:				InetHost;								{ 	router address; }
		fLocal:					INTEGER;								{ 	always 0 }
		fHost:					INTEGER;								{ 	always 0 }
	END;

	OTCfgIRTEPrefsPtr = ^OTCfgIRTEPrefs;
	OTCfgIRTEPrefs = RECORD
		fCount:					INTEGER;
		fList:					ARRAY [0..0] OF OTCfgIRTEEntry;
	END;

	OTCfgISDMPrefsPtr = ^OTCfgISDMPrefs;
	OTCfgISDMPrefs = RECORD
		fCount:					INTEGER;
		fDomainsList:			Str255;
	END;

	OTCfgDHCPRecordPtr = ^OTCfgDHCPRecord;
	OTCfgDHCPRecord = RECORD
		ipIPAddr:				InetHost;
		ipConfigServer:			InetHost;
		ipLeaseGrantTime:		UInt32;
		ipLeaseExpirationTime:	UInt32;
	END;

{	DNS	}

CONST
																{ 	connection	 }
	kOTCfgTypeDNSidns			= 'idns';
	kOTCfgTypeDNSisdm			= 'isdm';
	kOTCfgTypeDNSihst			= 'ihst';
	kOTCfgTypeDNSstng			= 'stng';
	kOTCfgTypeDNSPassword		= 'pwrd';						{ 	transport options	 }

{	Modem	}
																{ 	connection	 }
	kOTCfgTypeModemModem		= 'ccl ';						{ 	Type for Modem configuration resource }
	kOTCfgTypeModemLocks		= 'lkmd';						{ 	Types for lock resources }
	kOTCfgTypeModemAdminPswd	= 'mdpw';						{ 	Password }
																{ 	transport options	 }
	kOTCfgTypeModemApp			= 'mapt';


TYPE
	OTCfgRemoteConfigModemPtr = ^OTCfgRemoteConfigModem;
	OTCfgRemoteConfigModem = RECORD
		version:				UInt32;
		useModemScript:			BOOLEAN;
		pad00:					SInt8;									{ 	this structure is NOT packed! }
		modemScript:			FSSpec;
		modemSpeakerOn:			BOOLEAN;
		modemPulseDial:			BOOLEAN;
		modemDialToneMode:		UInt32;
		lowerLayerName:			ARRAY [0..35] OF SInt8;
	END;

	OTCfgModemLocksPtr = ^OTCfgModemLocks;
	OTCfgModemLocks = RECORD
		version:				UInt32;
		port:					UInt32;
		script:					UInt32;
		speaker:				UInt32;
		dialing:				UInt32;
	END;

	OTCfgModemAppPrefsPtr = ^OTCfgModemAppPrefs;
	OTCfgModemAppPrefs = RECORD
		version:				UInt32;
		windowPos:				Point;
		userMode:				SInt32;
	END;

{	Remote Access	}

CONST
																{ 	connection	 }
	kOTCfgTypeRemoteARAP		= 'arap';
	kOTCfgTypeRemoteAddress		= 'cadr';
	kOTCfgTypeRemoteChat		= 'ccha';
	kOTCfgTypeRemoteDialing		= 'cdia';
	kOTCfgTypeRemoteExtAddress	= 'cead';
	kOTCfgTypeRemoteClientLocks	= 'clks';
	kOTCfgTypeRemoteClientMisc	= 'cmsc';
	kOTCfgTypeRemoteConnect		= 'conn';
	kOTCfgTypeRemoteUser		= 'cusr';
	kOTCfgTypeRemoteDialAssist	= 'dass';
	kOTCfgTypeRemoteIPCP		= 'ipcp';
	kOTCfgTypeRemoteLCP			= 'lcp ';						{  trailing space is important!  }
	kOTCfgTypeRemoteLogOptions	= 'logo';
	kOTCfgTypeRemotePassword	= 'pass';
	kOTCfgTypeRemotePort		= 'port';
	kOTCfgTypeRemoteServerLocks	= 'slks';
	kOTCfgTypeRemoteServer		= 'srvr';
	kOTCfgTypeRemoteUserMode	= 'usmd';
	kOTCfgTypeRemoteX25			= 'x25 ';						{  trailing space is important!  }
																{ 	transport options	 }
	kOTCfgTypeRemoteApp			= 'capt';

{******************************************************************************
*	OTCfgRemoteLogOptions
*
*	This structure is appended to OTCfgRemoteConnect records in the 
*	OTCfgRemoteConnect::additional list.
*
*	NOTE
*
*	All OTCfgRemoteConnect::additional structures MUST have the same fields up to
*	the "additional" field.  See OTCfgRemoteX25Info.
*******************************************************************************}

TYPE
	OTCfgRemoteLogOptionsPtr = ^OTCfgRemoteLogOptions;
	OTCfgRemoteLogOptions = RECORD
		version:				UInt32;
		fType:					UInt32;									{ 	kRAConnectAdditionalLogOptions }
		additional:				Ptr;
		logLevel:				UInt32;									{ 	values defined above. }
		reserved:				ARRAY [0..3] OF UInt32;					{ 	for later use. }
	END;

{******************************************************************************
*	New structures for dialing mode, phone numbers, and configuration stats.
*	
*	
*******************************************************************************}

CONST
	kOTCfgRemoteMaxAddressSize	= 256;


TYPE
	OTCfgRemoteAddressPtr = ^OTCfgRemoteAddress;
	OTCfgRemoteAddress = RECORD
		next:					OTCfgRemoteAddressPtr;
		address:				PACKED ARRAY [0..255] OF UInt8;
	END;

{******************************************************************************
*	OTCfgRemoteDialing
*
*	This structure is appended to OTCfgRemoteConnect records in the 
*	OTCfgRemoteConnect::additional list.
*
*	NOTE
*
*	All OTCfgRemoteConnect::additional structures MUST have the same fields up to
*	the "additional" field.  See OTCfgRemoteX25Info.
*******************************************************************************}
	OTCfgRemoteDialingPtr = ^OTCfgRemoteDialing;
	OTCfgRemoteDialing = RECORD
		version:				UInt32;
		fType:					UInt32;									{ 	kRAConnectAdditionalDialing }
		additional:				Ptr;
		dialMode:				UInt32;									{ 	values defined above. }
		redialTries:			SInt32;
		redialDelay:			UInt32;									{ 	in seconds. }
		addresses:				OTCfgRemoteAddressPtr;
	END;

{******************************************************************************
*	OTCfgRemoteScript
*
*	This is appended to OTCfgRemoteConnect records in the "additional" list.
*	It is currently only used for passing in a modem script to override
*	the default script.  Connect scripts have their own field in OTCfgRemoteConnect.
*
*	NOTE
*
*	All OTCfgRemoteConnect::additional structures MUST have the same fields up to
*	the "additional" field.  See OTCfgRemoteX25Info and OTCfgRemoteDialing.
*******************************************************************************}
	OTCfgRemoteScriptPtr = ^OTCfgRemoteScript;
	OTCfgRemoteScript = RECORD
		version:				UInt32;
		fType:					UInt32;									{ 	kRAConnectAdditionalScript }
		additional:				Ptr;
		scriptType:				UInt32;
		scriptLength:			UInt32;
		scriptData:				Ptr;
	END;

{******************************************************************************
*	Miscellaneous limits
*	The size limits for strings include a 1 byte for the string length or
*	a terminating NULL character.
*******************************************************************************}

CONST
	kOTCfgRemoteMaxPasswordLength = 255;
	kOTCfgRemoteMaxPasswordSize	= 256;
	kOTCfgRemoteMaxUserNameLength = 255;
	kOTCfgRemoteMaxUserNameSize	= 256;
	kOTCfgRemoteMaxAddressLength = 255;							{ 	kOTCfgRemoteMaxAddressSize					= (255 + 1), }
	kOTCfgRemoteMaxServerNameLength = 32;
	kOTCfgRemoteMaxServerNameSize = 33;
	kOTCfgRemoteMaxMessageLength = 255;
	kOTCfgRemoteMaxMessageSize	= 256;
	kOTCfgRemoteMaxX25ClosedUserGroupLength = 4;
	kOTCfgRemoteInfiniteSeconds	= $FFFFFFFF;
	kOTCfgRemoteMinReminderMinutes = 1;
	kOTCfgRemoteChatScriptFileCreator = 'ttxt';
	kOTCfgRemoteChatScriptFileType = 'TEXT';
	kOTCfgRemoteMaxChatScriptLength = $8000;

{******************************************************************************
*	X.25 connection information, added to OTCfgRemoteConnect's additional info list.
*
*	NOTE
*
*	All OTCfgRemoteConnect::additional structures MUST have the same fields up to
*	the "additional" field.  See OTCfgRemoteScript & OTCfgRemoteDialing.
*******************************************************************************}

TYPE
	OTCfgRemoteX25InfoPtr = ^OTCfgRemoteX25Info;
	OTCfgRemoteX25Info = RECORD
		version:				UInt32;
		fType:					UInt32;									{ 	kRAConnectAdditionalX25 }
		additional:				Ptr;									{ 	Ptr to additional connect info }
		script:					FSSpec;									{ 	PAD's CCL script }
		address:				PACKED ARRAY [0..255] OF UInt8;			{ 	address of server }
		userName:				PACKED ARRAY [0..255] OF UInt8;
																		{ 	network user ID }
		closedUserGroup:		PACKED ARRAY [0..4] OF UInt8;
																		{ 	closed user group }
		reverseCharge:			BOOLEAN;								{ 	request reverse charging }
	END;

{******************************************************************************
*	OTCfgRemoteDisconnect
*
*	Use this structure to terminate Remote Access connections.
*******************************************************************************}
	OTCfgRemoteDisconnectPtr = ^OTCfgRemoteDisconnect;
	OTCfgRemoteDisconnect = RECORD
		whenSeconds:			UInt32;									{ 	Number of seconds until disconnect }
		showStatus:				UInt32;									{ 	Show disconnect status window }
	END;

{******************************************************************************
*	OTCfgRemoteIsRemote
*
*	Use this structure to find out if an AppleTalk address is on the 
*	remote side of the current ARA link. The "isRemote" field is set to
*	"true" if the address is remote. 
*******************************************************************************}
	OTCfgRemoteIsRemotePtr = ^OTCfgRemoteIsRemote;
	OTCfgRemoteIsRemote = RECORD
		net:					UInt32;									{ 	AppleTalk network number }
		node:					UInt32;									{ 	AppleTalk node number }
		isRemote:				UInt32;									{ 	returned. }
	END;

{******************************************************************************
*	OTCfgRemoteConnect
*
*	Use this structure to initiate Remote Access connections.
*******************************************************************************}
	OTCfgRemoteConnectPtr = ^OTCfgRemoteConnect;
	OTCfgRemoteConnect = RECORD
		version:				UInt32;
		fType:					UInt32;									{ 	RAConnectType defined above. }
		isGuest:				UInt32;									{ 	(boolean) True for guest login }
		canInteract:			UInt32;									{ 	(boolean) True if dialogs can be displayed }
		showStatus:				UInt32;									{ 	(boolean) Display (dis)connection status dialogs? }
		passwordSaved:			UInt32;									{ 	(boolean) "Save Password" checked in doc. }
		flashConnectedIcon:		UInt32;									{ 	(boolean) Flash icon in menu bar }
		issueConnectedReminders: UInt32;								{ 	(boolean) Use Notification Manager reminders }
		reminderMinutes:		SInt32;									{ 	How long between each reminder? }
		connectManually:		UInt32;									{ 	(boolean) True if we are connecting manually }
		allowModemDataCompression: UInt32;								{ 	(boolean) currently, only for kSerialProtoPPP }
		chatMode:				UInt32;									{ 	Flags defined above }
		serialProtocolMode:		UInt32;									{ 	Flags defined above }
		password:				Ptr;
		userName:				Ptr;
		addressLength:			UInt32;									{ 	Length of phone number or other address }
		address:				Ptr;									{ 	Phone number or address data }
		chatScriptName:			Str63;									{ 	Name of imported chat script (informational only) }
		chatScriptLength:		UInt32;									{ 	Length of Chat script }
		chatScript:				Ptr;									{ 	Chat script data }
		additional:				Ptr;									{ 	Ptr to additional connect info, }
																		{ 	such as OTCfgRemoteX25Info }
		useSecurityModule:		UInt32;									{ 	(boolean) use line-level security module ? }
		securitySignature:		OSType;									{ 	signature of security module file }
		securityDataLength:		UInt32;									{ 	0..kSecurityMaxConfigData }
		securityData:			Ptr;									{ 	Ptr to data of size securityDataLength }
	END;

{******************************************************************************
*	OTCfgRemoteConnectInfo
*
*	If requestCode = kRAGetConnectInfo, "connectInfo" returns a pointer to a
*	new OTCfgRemoteConnect block that describes the current connection.
*
*	If requestCode = kRADisposeConnectInfo, the memory pointed to by
*	"connectInfo" is released for reuse.  "connectInfo" must point to a valid
*	OTCfgRemoteConnect structure previously returned by kRAGetConnectInfo.
*******************************************************************************}
	OTCfgRemoteConnectInfoPtr = ^OTCfgRemoteConnectInfo;
	OTCfgRemoteConnectInfo = RECORD
		connectInfo:			OTCfgRemoteConnectPtr;					{ 	Returned or disposed, depending on requestCode }
	END;

{******************************************************************************
*	OTCfgRemoteStatus
*
*	Use this structure to get the status of Remote Access connections.
*******************************************************************************}

CONST
	kOTCfgRemoteStatusIdle		= 1;
	kOTCfgRemoteStatusConnecting = 2;
	kOTCfgRemoteStatusConnected	= 3;
	kOTCfgRemoteStatusDisconnecting = 4;



TYPE
	OTCfgRemoteStatusPtr = ^OTCfgRemoteStatus;
	OTCfgRemoteStatus = RECORD
		status:					UInt32;									{ 	values defined above }
		answerEnabled:			BOOLEAN;
		pad00:					SInt8;									{ 	This structure is NOT packed }
		secondsConnected:		UInt32;
		secondsRemaining:		UInt32;
		userName:				PACKED ARRAY [0..255] OF UInt8;			{ 	Pascal format }
		serverName:				PACKED ARRAY [0..32] OF UInt8;			{ 	Pascal format }
		pad01:					SInt8;									{ 	This structure is NOT packed }
		messageIndex:			UInt32;
		message:				PACKED ARRAY [0..255] OF UInt8;			{ 	Pascal format }
		serialProtocolMode:		UInt32;									{ 	Flags defined above. }
		baudMessage:			PACKED ARRAY [0..255] OF UInt8;			{ 	Pascal format }
		isServer:				BOOLEAN;
		pad02:					SInt8;									{ 	This structure is NOT packed }
		bytesIn:				UInt32;
		bytesOut:				UInt32;
		linkSpeed:				UInt32;
		localIPAddress:			UInt32;
		remoteIPAddress:		UInt32;
	END;

{******************************************************************************
*	OTCfgRemoteUserMessage
*
*	Use this structure when converting result codes into user messages.
*******************************************************************************}
	OTCfgRemoteUserMessagePtr = ^OTCfgRemoteUserMessage;
	OTCfgRemoteUserMessage = RECORD
		version:				UInt32;
		messageID:				SInt32;
		userMessage:			PACKED ARRAY [0..255] OF UInt8;
		userDiagnostic:			PACKED ARRAY [0..255] OF UInt8;
	END;

{******************************************************************************
*	OTCfgRemoteNotifier
*
*	Use this structure to install a procedure to receive asynchronous 
*	Remote Access notifications.
*******************************************************************************}
	OTCfgRemoteEventCode				= UInt32;
{$IFC TYPED_FUNCTION_POINTERS}
	RANotifyProcPtr = PROCEDURE(contextPtr: UNIV Ptr; code: OTCfgRemoteEventCode; result: OSStatus; cookie: UNIV Ptr); C;
{$ELSEC}
	RANotifyProcPtr = ProcPtr;
{$ENDC}

	OTCfgRemoteNotifierPtr = ^OTCfgRemoteNotifier;
	OTCfgRemoteNotifier = RECORD
		procPtr:				RANotifyProcPtr;
		contextPtr:				Ptr;
	END;

{******************************************************************************
*	OTCfgRemoteRequest
*
*	All Remote Access API calls must pass a pointer to an OTCfgRemoteRequest structure.
*******************************************************************************}
	OTCfgRemoteRequestPtr = ^OTCfgRemoteRequest;
	OTCfgRemoteRequest = RECORD
		reserved1:				ARRAY [0..15] OF SInt8;					{ 	Do not use.  }
		result:					OSErr;									{ 	<-- }
		reserved2:				ARRAY [0..7] OF SInt8;					{ 	Do not use. }
		requestCode:			SInt16;									{ 	 --> }
		portId:					SInt16;									{ 	<--> }
		CASE INTEGER OF
		0: (
			Notifier:			OTCfgRemoteNotifier;
			);
		1: (
			Connect:			OTCfgRemoteConnect;
			);
		2: (
			Disconnect:			OTCfgRemoteDisconnect;
			);
		3: (
			Status:				OTCfgRemoteStatus;
			);
		4: (
			IsRemote:			OTCfgRemoteIsRemote;
			);
		5: (
			ConnectInfo:		OTCfgRemoteConnectInfo;
			);
	END;

	OTCfgRemoteConfigCAPTPtr = ^OTCfgRemoteConfigCAPT;
	OTCfgRemoteConfigCAPT = RECORD
		fWord1:					UInt32;
		fWindowPosition:		Point;
		fWord3:					UInt32;
		fUserLevel:				UInt32;
		fSetupVisible:			UInt32;
	END;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := NetworkSetupIncludes}

{$ENDC} {__NETWORKSETUP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
