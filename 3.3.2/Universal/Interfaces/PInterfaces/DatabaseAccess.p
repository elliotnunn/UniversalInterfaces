{
     File:       DatabaseAccess.p
 
     Contains:   Database Access Manager Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1989-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT DatabaseAccess;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DATABASEACCESS__}
{$SETC __DATABASEACCESS__ := 1}

{$I+}
{$SETC DatabaseAccessIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __RESOURCES__}
{$I Resources.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ data type codes }

CONST
	typeNone					= 'none';
	typeDate					= 'date';
	typeTime					= 'time';
	typeTimeStamp				= 'tims';
	typeDecimal					= 'deci';
	typeMoney					= 'mone';
	typeVChar					= 'vcha';
	typeVBin					= 'vbin';
	typeLChar					= 'lcha';
	typeLBin					= 'lbin';
	typeDiscard					= 'disc';						{  "dummy" types for DBResultsToText  }
	typeUnknown					= 'unkn';
	typeColBreak				= 'colb';
	typeRowBreak				= 'rowb';						{  pass this in to DBGetItem for any data type  }
	typeAnyType					= 0;

{ infinite timeout value for DBGetItem }
																{  messages for status functions for DBStartQuery  }
	kDBUpdateWind				= 0;
	kDBAboutToInit				= 1;
	kDBInitComplete				= 2;
	kDBSendComplete				= 3;
	kDBExecComplete				= 4;
	kDBStartQueryComplete		= 5;

																{  messages for status functions for DBGetQueryResults  }
	kDBGetItemComplete			= 6;
	kDBGetQueryResultsComplete	= 7;
	kDBWaitForever				= -1;

																{   flags for DBGetItem   }
	kDBLastColFlag				= $0001;
	kDBNullFlag					= $0004;


TYPE
	DBType								= OSType;
	DBAsyncParamBlockRecPtr = ^DBAsyncParamBlockRec;
	DBAsyncParmBlkPtr					= ^DBAsyncParamBlockRec;
{$IFC TYPED_FUNCTION_POINTERS}
	DBCompletionProcPtr = PROCEDURE(pb: DBAsyncParmBlkPtr);
{$ELSEC}
	DBCompletionProcPtr = Register68kProcPtr;
{$ENDC}

	DBCompletionUPP = UniversalProcPtr;
{ structure for asynchronous parameter block }
	DBAsyncParamBlockRec = RECORD
		completionProc:			DBCompletionUPP;						{  pointer to completion routine  }
		result:					OSErr;									{  result of call  }
		userRef:				LONGINT;								{  for application's use  }
		ddevRef:				LONGINT;								{  for ddev's use  }
		reserved:				LONGINT;								{  for internal use  }
	END;

{ structure for resource list in QueryRecord }
	ResListElemPtr = ^ResListElem;
	ResListElem = RECORD
		theType:				ResType;								{  resource type  }
		id:						INTEGER;								{  resource id  }
	END;

	ResListPtr							= ^ResListElem;
	ResListHandle						= ^ResListPtr;
{ structure for query list in QueryRecord }
	QueryArray							= ARRAY [0..255] OF Handle;
	QueryListPtr						= ^QueryArray;
	QueryListHandle						= ^QueryListPtr;
	QueryRecordPtr = ^QueryRecord;
	QueryRecord = RECORD
		version:				INTEGER;								{  version  }
		id:						INTEGER;								{  id of 'qrsc' this came from  }
		queryProc:				Handle;									{  handle to query def proc  }
		ddevName:				Str63;									{  ddev name  }
		host:					Str255;									{  host name  }
		user:					Str255;									{  user name  }
		password:				Str255;									{  password  }
		connStr:				Str255;									{  connection string  }
		currQuery:				INTEGER;								{  index of current query  }
		numQueries:				INTEGER;								{  number of queries in list  }
		queryList:				QueryListHandle;						{  handle to array of handles to text  }
		numRes:					INTEGER;								{  number of resources in list  }
		resList:				ResListHandle;							{  handle to array of resource list elements  }
		dataHandle:				Handle;									{  for use by query def proc  }
		refCon:					LONGINT;								{  for use by application  }
	END;

	QueryPtr							= ^QueryRecord;
	QueryHandle							= ^QueryPtr;
{ structure of column types array in ResultsRecord }
	ColTypesArray						= ARRAY [0..255] OF DBType;
	ColTypesPtr							= ^ColTypesArray;
	ColTypesHandle						= ^ColTypesPtr;
{ structure for column info in ResultsRecord }
	DBColInfoRecordPtr = ^DBColInfoRecord;
	DBColInfoRecord = RECORD
		len:					INTEGER;
		places:					INTEGER;
		flags:					INTEGER;
	END;

	ColInfoArray						= ARRAY [0..255] OF DBColInfoRecord;
	ColInfoPtr							= ^ColInfoArray;
	ColInfoHandle						= ^ColInfoPtr;
{ structure of results returned by DBGetResults }
	ResultsRecordPtr = ^ResultsRecord;
	ResultsRecord = RECORD
		numRows:				INTEGER;								{  number of rows in result  }
		numCols:				INTEGER;								{  number of columns per row  }
		colTypes:				ColTypesHandle;							{  data type array  }
		colData:				Handle;									{  actual results  }
		colInfo:				ColInfoHandle;							{  DBColInfoRecord array  }
	END;


CONST
																{  messages sent to a 'ddev' }
	kDBInit						= 0;
	kDBEnd						= 1;
	kDBGetConnInfo				= 2;
	kDBGetSessionNum			= 3;
	kDBSend						= 4;
	kDBSendItem					= 5;
	kDBExec						= 6;
	kDBState					= 7;
	kDBGetErr					= 8;
	kDBBreak					= 9;
	kDBGetItem					= 10;
	kDBUngetItem				= 11;
	kDBKill						= 12;
	kDBOpen						= 100;
	kDBClose					= 101;
	kDBIdle						= 102;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	DBQueryDefProcPtr = FUNCTION(VAR sessID: LONGINT; query: QueryHandle): OSErr;
{$ELSEC}
	DBQueryDefProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DBStatusProcPtr = FUNCTION(message: INTEGER; result: OSErr; dataLen: INTEGER; dataPlaces: INTEGER; dataFlags: INTEGER; dataType: DBType; dataPtr: Ptr): BOOLEAN;
{$ELSEC}
	DBStatusProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DBResultHandlerProcPtr = FUNCTION(dataType: DBType; theLen: INTEGER; thePlaces: INTEGER; theFlags: INTEGER; theData: Ptr; theText: Handle): OSErr;
{$ELSEC}
	DBResultHandlerProcPtr = ProcPtr;
{$ENDC}

	DBQueryDefUPP = UniversalProcPtr;
	DBStatusUPP = UniversalProcPtr;
	DBResultHandlerUPP = UniversalProcPtr;

CONST
	uppDBCompletionProcInfo = $0000B802;
	uppDBQueryDefProcInfo = $000003E0;
	uppDBStatusProcInfo = $000FAA90;
	uppDBResultHandlerProcInfo = $0003EAE0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewDBCompletionUPP(userRoutine: DBCompletionProcPtr): DBCompletionUPP; { old name was NewDBCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDBQueryDefUPP(userRoutine: DBQueryDefProcPtr): DBQueryDefUPP; { old name was NewDBQueryDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDBStatusUPP(userRoutine: DBStatusProcPtr): DBStatusUPP; { old name was NewDBStatusProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDBResultHandlerUPP(userRoutine: DBResultHandlerProcPtr): DBResultHandlerUPP; { old name was NewDBResultHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeDBCompletionUPP(userUPP: DBCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeDBQueryDefUPP(userUPP: DBQueryDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeDBStatusUPP(userUPP: DBStatusUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeDBResultHandlerUPP(userUPP: DBResultHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeDBCompletionUPP(pb: DBAsyncParmBlkPtr; userRoutine: DBCompletionUPP); { old name was CallDBCompletionProc }

FUNCTION InvokeDBQueryDefUPP(VAR sessID: LONGINT; query: QueryHandle; userRoutine: DBQueryDefUPP): OSErr; { old name was CallDBQueryDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeDBStatusUPP(message: INTEGER; result: OSErr; dataLen: INTEGER; dataPlaces: INTEGER; dataFlags: INTEGER; dataType: DBType; dataPtr: Ptr; userRoutine: DBStatusUPP): BOOLEAN; { old name was CallDBStatusProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeDBResultHandlerUPP(dataType: DBType; theLen: INTEGER; thePlaces: INTEGER; theFlags: INTEGER; theData: Ptr; theText: Handle; userRoutine: DBResultHandlerUPP): OSErr; { old name was CallDBResultHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION InitDBPack: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $303C, $0100, $A82F;
	{$ENDC}
FUNCTION DBInit(VAR sessID: LONGINT; ddevName: Str63; host: Str255; user: Str255; passwd: Str255; connStr: Str255; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0E02, $A82F;
	{$ENDC}
FUNCTION DBEnd(sessID: LONGINT; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0403, $A82F;
	{$ENDC}
FUNCTION DBGetConnInfo(sessID: LONGINT; sessNum: INTEGER; VAR returnedID: LONGINT; VAR version: LONGINT; VAR ddevName: Str63; VAR host: Str255; VAR user: Str255; VAR network: Str255; VAR connStr: Str255; VAR start: LONGINT; VAR state: OSErr; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $1704, $A82F;
	{$ENDC}
FUNCTION DBGetSessionNum(sessID: LONGINT; VAR sessNum: INTEGER; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0605, $A82F;
	{$ENDC}
FUNCTION DBSend(sessID: LONGINT; text: Ptr; len: INTEGER; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0706, $A82F;
	{$ENDC}
FUNCTION DBSendItem(sessID: LONGINT; dataType: DBType; len: INTEGER; places: INTEGER; flags: INTEGER; buffer: UNIV Ptr; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B07, $A82F;
	{$ENDC}
FUNCTION DBExec(sessID: LONGINT; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0408, $A82F;
	{$ENDC}
FUNCTION DBState(sessID: LONGINT; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0409, $A82F;
	{$ENDC}
FUNCTION DBGetErr(sessID: LONGINT; VAR err1: LONGINT; VAR err2: LONGINT; VAR item1: Str255; VAR item2: Str255; VAR errorMsg: Str255; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0E0A, $A82F;
	{$ENDC}
FUNCTION DBBreak(sessID: LONGINT; abort: BOOLEAN; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050B, $A82F;
	{$ENDC}
FUNCTION DBGetItem(sessID: LONGINT; timeout: LONGINT; VAR dataType: DBType; VAR len: INTEGER; VAR places: INTEGER; VAR flags: INTEGER; buffer: UNIV Ptr; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $100C, $A82F;
	{$ENDC}
FUNCTION DBUnGetItem(sessID: LONGINT; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040D, $A82F;
	{$ENDC}
FUNCTION DBKill(asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020E, $A82F;
	{$ENDC}
FUNCTION DBGetNewQuery(queryID: INTEGER; VAR query: QueryHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $030F, $A82F;
	{$ENDC}
FUNCTION DBDisposeQuery(query: QueryHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0210, $A82F;
	{$ENDC}
FUNCTION DBStartQuery(VAR sessID: LONGINT; query: QueryHandle; statusProc: DBStatusUPP; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0811, $A82F;
	{$ENDC}
FUNCTION DBGetQueryResults(sessID: LONGINT; VAR results: ResultsRecord; timeout: LONGINT; statusProc: DBStatusUPP; asyncPB: DBAsyncParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A12, $A82F;
	{$ENDC}
FUNCTION DBResultsToText(VAR results: ResultsRecord; VAR theText: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0413, $A82F;
	{$ENDC}
FUNCTION DBInstallResultHandler(dataType: DBType; theHandler: DBResultHandlerUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0514, $A82F;
	{$ENDC}
FUNCTION DBRemoveResultHandler(dataType: DBType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0215, $A82F;
	{$ENDC}
FUNCTION DBGetResultHandler(dataType: DBType; VAR theHandler: DBResultHandlerUPP; getSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0516, $A82F;
	{$ENDC}
FUNCTION DBIdle: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00FF, $A82F;
	{$ENDC}


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DatabaseAccessIncludes}

{$ENDC} {__DATABASEACCESS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
