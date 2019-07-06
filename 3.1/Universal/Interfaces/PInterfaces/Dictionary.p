{
 	File:		Dictionary.p
 
 	Contains:	Dictionary Manager Interfaces
 
 	Version:	Technology:	System 7
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1992-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Dictionary;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DICTIONARY__}
{$SETC __DICTIONARY__ := 1}

{$I+}
{$SETC DictionaryIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}



CONST
																{  Dictionary data insertion modes  }
	kInsert						= 0;							{  Only insert the input entry if there is nothing in the dictionary that matches the key.  }
	kReplace					= 1;							{  Only replace the entries which match the key with the input entry.  }
	kInsertOrReplace			= 2;							{  Insert the entry if there is nothing in the dictionary which matches the key, otherwise replaces the existing matched entries with the input entry.  }

{ This Was InsertMode }

TYPE
	DictionaryDataInsertMode			= INTEGER;

CONST
																{  Key attribute constants  }
	kIsCaseSensitive			= $10;							{  case sensitive = 16		 }
	kIsNotDiacriticalSensitive	= $20;							{  diac not sensitive = 32	 }

																{  Registered attribute type constants.	 }
	kNoun						= -1;
	kVerb						= -2;
	kAdjective					= -3;
	kAdverb						= -4;

{ This Was AttributeType }

TYPE
	DictionaryEntryAttribute			= SInt8;
{ Dictionary information record }
	DictionaryInformationPtr = ^DictionaryInformation;
	DictionaryInformation = RECORD
		dictionaryFSSpec:		FSSpec;
		numberOfRecords:		SInt32;
		currentGarbageSize:		SInt32;
		script:					ScriptCode;
		maximumKeyLength:		SInt16;
		keyAttributes:			SInt8;
	END;

	DictionaryAttributeTablePtr = ^DictionaryAttributeTable;
	DictionaryAttributeTable = PACKED RECORD
		datSize:				UInt8;
		datTable:				ARRAY [0..0] OF DictionaryEntryAttribute;
	END;

FUNCTION InitializeDictionary({CONST}VAR theFsspecPtr: FSSpec; maximumKeyLength: SInt16; keyAttributes: SInt8; script: ScriptCode): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0500, $AA53;
	{$ENDC}
FUNCTION OpenDictionary({CONST}VAR theFsspecPtr: FSSpec; accessPermission: SInt8; VAR dictionaryReference: SInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0501, $AA53;
	{$ENDC}
FUNCTION CloseDictionary(dictionaryReference: SInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0202, $AA53;
	{$ENDC}
FUNCTION InsertRecordToDictionary(dictionaryReference: SInt32; key: Str255; recordDataHandle: Handle; whichMode: DictionaryDataInsertMode): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0703, $AA53;
	{$ENDC}
FUNCTION DeleteRecordFromDictionary(dictionaryReference: SInt32; key: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0404, $AA53;
	{$ENDC}
FUNCTION FindRecordInDictionary(dictionaryReference: SInt32; key: Str255; requestedAttributeTablePointer: DictionaryAttributeTablePtr; recordDataHandle: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0805, $AA53;
	{$ENDC}
FUNCTION FindRecordByIndexInDictionary(dictionaryReference: SInt32; recordIndex: SInt32; requestedAttributeTablePointer: DictionaryAttributeTablePtr; VAR recordKey: Str255; recordDataHandle: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A06, $AA53;
	{$ENDC}
FUNCTION GetDictionaryInformation(dictionaryReference: SInt32; VAR theDictionaryInformation: DictionaryInformation): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0407, $AA53;
	{$ENDC}
FUNCTION CompactDictionary(dictionaryReference: SInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0208, $AA53;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DictionaryIncludes}

{$ENDC} {__DICTIONARY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
