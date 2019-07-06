{
     File:       Dictionary.p
 
     Contains:   Dictionary Manager Interfaces
 
     Version:    Technology: System 7
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1992-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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
{$IFC UNDEFINED __AEREGISTRY__}
{$I AERegistry.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{
=============================================================================================
 Modern Dictionary Manager
=============================================================================================
}
{
    Dictionary information
}

CONST
	kDictionaryFileType			= 'dict';
	kDCMDictionaryHeaderSignature = 'dict';
	kDCMDictionaryHeaderVersion	= 2;

	kDCMAnyFieldTag				= '****';
	kDCMAnyFieldType			= '****';

{
    Contents of a Field Info Record (an AERecord)
}
	keyDCMFieldTag				= 'ftag';						{  typeEnumeration  }
	keyDCMFieldType				= 'ftyp';						{  typeEnumeration  }
	keyDCMMaxRecordSize			= 'mrsz';						{  typeMagnitude  }
	keyDCMFieldAttributes		= 'fatr';
	keyDCMFieldDefaultData		= 'fdef';
	keyDCMFieldName				= 'fnam';						{  typeChar  }
	keyDCMFieldFindMethods		= 'ffnd';						{  typeAEList of typeDCMFindMethod  }

{
    Special types for fields of a Field Info Record
}
	typeDCMFieldAttributes		= 'fatr';
	typeDCMFindMethod			= 'fmth';


{
    Field attributes
}
	kDCMIndexedFieldMask		= $00000001;
	kDCMRequiredFieldMask		= $00000002;
	kDCMIdentifyFieldMask		= $00000004;
	kDCMFixedSizeFieldMask		= $00000008;
	kDCMHiddenFieldMask			= $80000000;


TYPE
	DCMFieldAttributes					= OptionBits;
{
    Standard dictionary properties
}

CONST
	pDCMAccessMethod			= 'amtd';						{  data type: typeChar ReadOnly  }
	pDCMPermission				= 'perm';						{  data type: typeUInt16  }
	pDCMListing					= 'list';						{  data type: typeUInt16  }
	pDCMMaintenance				= 'mtnc';						{  data type: typeUInt16  }
	pDCMLocale					= 'locl';						{  data type: typeUInt32.  Optional; default = kLocaleIdentifierWildCard  }
	pDCMClass					= 'pcls';						{  data type: typeUInt16  }
	pDCMCopyright				= 'info';						{  data type: typeChar  }

{
    pDCMPermission property constants
}
	kDCMReadOnlyDictionary		= 0;
	kDCMReadWriteDictionary		= 1;

{
    pDCMListing property constants
}
	kDCMAllowListing			= 0;
	kDCMProhibitListing			= 1;

{
    pDCMClass property constants
}
	kDCMUserDictionaryClass		= 0;
	kDCMSpecificDictionaryClass	= 1;
	kDCMBasicDictionaryClass	= 2;

{
    Standard search method
}
	kDCMFindMethodExactMatch	= '=   ';
	kDCMFindMethodBeginningMatch = 'bgwt';
	kDCMFindMethodContainsMatch	= 'cont';
	kDCMFindMethodEndingMatch	= 'ends';
	kDCMFindMethodForwardTrie	= 'ftri';						{  used for morphological analysis }
	kDCMFindMethodBackwardTrie	= 'btri';						{  used for morphological analysis }


TYPE
	DCMFindMethod						= OSType;
{
    AccessMethod features
}

CONST
	kDCMCanUseFileDictionaryMask = $00000001;
	kDCMCanUseMemoryDictionaryMask = $00000002;
	kDCMCanStreamDictionaryMask	= $00000004;
	kDCMCanHaveMultipleIndexMask = $00000008;
	kDCMCanModifyDictionaryMask	= $00000010;
	kDCMCanCreateDictionaryMask	= $00000020;
	kDCMCanAddDictionaryFieldMask = $00000040;
	kDCMCanUseTransactionMask	= $00000080;


TYPE
	DCMAccessMethodFeature				= OptionBits;
	DCMUniqueID							= UInt32;
	DCMObjectID = ^LONGINT; { an opaque 32-bit type }
	DCMAccessMethodID					= DCMObjectID;
	DCMDictionaryID						= DCMObjectID;
	DCMObjectRef = ^LONGINT; { an opaque 32-bit type }
	DCMDictionaryRef					= DCMObjectRef;
	DCMDictionaryStreamRef				= DCMObjectRef;
	DCMObjectIterator = ^LONGINT; { an opaque 32-bit type }
	DCMAccessMethodIterator				= DCMObjectIterator;
	DCMDictionaryIterator				= DCMObjectIterator;
	DCMFoundRecordIterator = ^LONGINT; { an opaque 32-bit type }
{
    Field specification declarations
}
	DCMFieldTag							= DescType;
	DCMFieldType						= DescType;
{
    Dictionary header information
}
	DCMDictionaryHeaderPtr = ^DCMDictionaryHeader;
	DCMDictionaryHeader = RECORD
		headerSignature:		FourCharCode;
		headerVersion:			UInt32;
		headerSize:				ByteCount;
		accessMethod:			Str63;
	END;

{
    Callback routines
}
{$IFC TYPED_FUNCTION_POINTERS}
	DCMProgressFilterProcPtr = FUNCTION(determinateProcess: BOOLEAN; percentageComplete: UInt16; callbackUD: UInt32): BOOLEAN;
{$ELSEC}
	DCMProgressFilterProcPtr = ProcPtr;
{$ENDC}

	DCMProgressFilterUPP = UniversalProcPtr;

CONST
	uppDCMProgressFilterProcInfo = $00000E50;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewDCMProgressFilterUPP(userRoutine: DCMProgressFilterProcPtr): DCMProgressFilterUPP; { old name was NewDCMProgressFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeDCMProgressFilterUPP(userUPP: DCMProgressFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeDCMProgressFilterUPP(determinateProcess: BOOLEAN; percentageComplete: UInt16; callbackUD: UInt32; userRoutine: DCMProgressFilterUPP): BOOLEAN; { old name was CallDCMProgressFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{
    Library version
}
FUNCTION DCMLibraryVersion: UInt32;
{
    Create/delete dictionary
}
FUNCTION DCMNewDictionary(accessMethodID: DCMAccessMethodID; {CONST}VAR newDictionaryFile: FSSpec; scriptTag: ScriptCode; {CONST}VAR listOfFieldInfoRecords: AEDesc; invisible: BOOLEAN; recordCapacity: ItemCount; VAR newDictionary: DCMDictionaryID): OSStatus;
FUNCTION DCMDeriveNewDictionary(srcDictionary: DCMDictionaryID; {CONST}VAR newDictionaryFile: FSSpec; scriptTag: ScriptCode; invisible: BOOLEAN; recordCapacity: ItemCount; VAR newDictionary: DCMDictionaryID): OSStatus;
FUNCTION DCMDeleteDictionary(dictionaryID: DCMDictionaryID): OSStatus;
{
    Register dictionary
}
FUNCTION DCMRegisterDictionaryFile({CONST}VAR dictionaryFile: FSSpec; VAR dictionaryID: DCMDictionaryID): OSStatus;
FUNCTION DCMUnregisterDictionary(dictionaryID: DCMDictionaryID): OSStatus;
{
    Open dictionary
}
FUNCTION DCMOpenDictionary(dictionaryID: DCMDictionaryID; protectKeySize: ByteCount; protectKey: ConstLogicalAddress; VAR dictionaryRef: DCMDictionaryRef): OSStatus;
FUNCTION DCMCloseDictionary(dictionaryRef: DCMDictionaryRef): OSStatus;
{
    Change access privilege
}
FUNCTION DCMGetDictionaryWriteAccess(dictionaryRef: DCMDictionaryRef; timeOutDuration: Duration): OSStatus;
FUNCTION DCMReleaseDictionaryWriteAccess(dictionaryRef: DCMDictionaryRef; commitTransaction: BOOLEAN): OSStatus;
{
    Find records
}
FUNCTION DCMFindRecords(dictionaryRef: DCMDictionaryRef; keyFieldTag: DCMFieldTag; keySize: ByteCount; keyData: ConstLogicalAddress; findMethod: DCMFindMethod; preFetchedDataNum: ItemCount; VAR preFetchedData: DCMFieldTag; skipCount: ItemCount; maxRecordCount: ItemCount; VAR recordIterator: DCMFoundRecordIterator): OSStatus;
FUNCTION DCMCountRecordIterator(recordIterator: DCMFoundRecordIterator): ItemCount;
FUNCTION DCMIterateFoundRecord(recordIterator: DCMFoundRecordIterator; maxKeySize: ByteCount; VAR actualKeySize: ByteCount; keyData: LogicalAddress; VAR uniqueID: DCMUniqueID; VAR dataList: AEDesc): OSStatus;
FUNCTION DCMDisposeRecordIterator(recordIterator: DCMFoundRecordIterator): OSStatus;
{
    Dump dictionary
}
FUNCTION DCMCountRecord(dictionaryID: DCMDictionaryID; VAR count: ItemCount): OSStatus;
FUNCTION DCMGetRecordSequenceNumber(dictionaryRef: DCMDictionaryRef; keyFieldTag: DCMFieldTag; keySize: ByteCount; keyData: ConstLogicalAddress; uniqueID: DCMUniqueID; VAR sequenceNum: ItemCount): OSStatus;
FUNCTION DCMGetNthRecord(dictionaryRef: DCMDictionaryRef; keyFieldTag: DCMFieldTag; serialNum: ItemCount; maxKeySize: ByteCount; VAR keySize: ByteCount; keyData: LogicalAddress; VAR uniqueID: DCMUniqueID): OSStatus;
FUNCTION DCMGetNextRecord(dictionaryRef: DCMDictionaryRef; keyFieldTag: DCMFieldTag; keySize: ByteCount; keyData: ConstLogicalAddress; uniqueID: DCMUniqueID; maxKeySize: ByteCount; VAR nextKeySize: ByteCount; nextKeyData: LogicalAddress; VAR nextUniqueID: DCMUniqueID): OSStatus;
FUNCTION DCMGetPrevRecord(dictionaryRef: DCMDictionaryRef; keyFieldTag: DCMFieldTag; keySize: ByteCount; keyData: ConstLogicalAddress; uniqueID: DCMUniqueID; maxKeySize: ByteCount; VAR prevKeySize: ByteCount; prevKeyData: LogicalAddress; VAR prevUniqueID: DCMUniqueID): OSStatus;
{
    Get field data
}
FUNCTION DCMGetFieldData(dictionaryRef: DCMDictionaryRef; keyFieldTag: DCMFieldTag; keySize: ByteCount; keyData: ConstLogicalAddress; uniqueID: DCMUniqueID; numOfData: ItemCount; {CONST}VAR dataTag: DCMFieldTag; VAR dataList: AEDesc): OSStatus;
FUNCTION DCMSetFieldData(dictionaryRef: DCMDictionaryRef; keyFieldTag: DCMFieldTag; keySize: ByteCount; keyData: ConstLogicalAddress; uniqueID: DCMUniqueID; {CONST}VAR dataList: AEDesc): OSStatus;
{
    Add record
}
FUNCTION DCMAddRecord(dictionaryRef: DCMDictionaryRef; keyFieldTag: DCMFieldTag; keySize: ByteCount; keyData: ConstLogicalAddress; checkOnly: BOOLEAN; {CONST}VAR dataList: AEDesc; VAR newUniqueID: DCMUniqueID): OSStatus;
FUNCTION DCMDeleteRecord(dictionaryRef: DCMDictionaryRef; keyFieldTag: DCMFieldTag; keySize: ByteCount; keyData: ConstLogicalAddress; uniqueID: DCMUniqueID): OSStatus;
{
    Reorganize/compact dictionary
}
FUNCTION DCMReorganizeDictionary(dictionaryID: DCMDictionaryID; extraCapacity: ItemCount; progressProc: DCMProgressFilterUPP; userData: UInt32): OSStatus;
FUNCTION DCMCompactDictionary(dictionaryID: DCMDictionaryID; progressProc: DCMProgressFilterUPP; userData: UInt32): OSStatus;
{
    DictionaryID utilities
}
FUNCTION DCMGetFileFromDictionaryID(dictionaryID: DCMDictionaryID; VAR fileRef: FSSpec): OSStatus;
FUNCTION DCMGetDictionaryIDFromFile({CONST}VAR fileRef: FSSpec; VAR dictionaryID: DCMDictionaryID): OSStatus;
FUNCTION DCMGetDictionaryIDFromRef(dictionaryRef: DCMDictionaryRef): DCMDictionaryID;
{
    Field information and manipulation
}
FUNCTION DCMGetDictionaryFieldInfo(dictionaryID: DCMDictionaryID; fieldTag: DCMFieldTag; VAR fieldInfoRecord: AEDesc): OSStatus;
{
    Dictionary property
}
FUNCTION DCMGetDictionaryProperty(dictionaryID: DCMDictionaryID; propertyTag: DCMFieldTag; maxPropertySize: ByteCount; VAR actualSize: ByteCount; propertyValue: LogicalAddress): OSStatus;
FUNCTION DCMSetDictionaryProperty(dictionaryID: DCMDictionaryID; propertyTag: DCMFieldTag; propertySize: ByteCount; propertyValue: ConstLogicalAddress): OSStatus;
FUNCTION DCMGetDictionaryPropertyList(dictionaryID: DCMDictionaryID; maxPropertyNum: ItemCount; VAR numProperties: ItemCount; VAR propertyTag: DCMFieldTag): OSStatus;
{
    Seaarch dictionary
}
FUNCTION DCMCreateDictionaryIterator(VAR dictionaryIterator: DCMDictionaryIterator): OSStatus;
{
    Search AccessMethod
}
FUNCTION DCMCreateAccessMethodIterator(VAR accessMethodIterator: DCMAccessMethodIterator): OSStatus;
{
    Iterator Operation
}
FUNCTION DCMCountObjectIterator(iterator: DCMObjectIterator): ItemCount;
FUNCTION DCMIterateObject(iterator: DCMObjectIterator; VAR objectID: DCMObjectID): OSStatus;
FUNCTION DCMResetObjectIterator(iterator: DCMObjectIterator): OSStatus;
FUNCTION DCMDisposeObjectIterator(iterator: DCMObjectIterator): OSStatus;
{
    Get AccessMethod information
}
FUNCTION DCMGetAccessMethodIDFromName(accessMethodName: Str63; VAR accessMethodID: DCMAccessMethodID): OSStatus;
{
    Field Info Record routines
}
FUNCTION DCMCreateFieldInfoRecord(fieldTag: DescType; fieldType: DescType; maxRecordSize: ByteCount; fieldAttributes: DCMFieldAttributes; VAR fieldDefaultData: AEDesc; numberOfFindMethods: ItemCount; VAR findMethods: DCMFindMethod; VAR fieldInfoRecord: AEDesc): OSStatus;
FUNCTION DCMGetFieldTagAndType({CONST}VAR fieldInfoRecord: AEDesc; VAR fieldTag: DCMFieldTag; VAR fieldType: DCMFieldType): OSStatus;
FUNCTION DCMGetFieldMaxRecordSize({CONST}VAR fieldInfoRecord: AEDesc; VAR maxRecordSize: ByteCount): OSStatus;
FUNCTION DCMGetFieldAttributes({CONST}VAR fieldInfoRecord: AEDesc; VAR attributes: DCMFieldAttributes): OSStatus;
FUNCTION DCMGetFieldDefaultData({CONST}VAR fieldInfoRecord: AEDesc; desiredType: DescType; VAR fieldDefaultData: AEDesc): OSStatus;
FUNCTION DCMGetFieldFindMethods({CONST}VAR fieldInfoRecord: AEDesc; findMethodsArrayMaxSize: ItemCount; VAR findMethods: DCMFindMethod; VAR actualNumberOfFindMethods: ItemCount): OSStatus;
{
    Check Dictionary Manager availability
}
{$IFC TARGET_RT_MAC_CFM }
{
        DCMDictionaryManagerAvailable() is a macro available only in C/C++.  
        To get the same functionality from pascal or assembly, you need
        to test if Dictionary Manager functions are not NULL.
        For instance:
        
            IF @DCMLibraryVersion <> kUnresolvedCFragSymbolAddress THEN
                gDictionaryManagerAvailable = TRUE;
            ELSE
                gDictionaryManagerAvailable = FALSE;
            END
    
}
{$ELSEC}
  {$IFC TARGET_RT_MAC_MACHO }
{ Dictionary Manager is always available on OS X }
  {$ENDC}
{$ENDC}

{
=============================================================================================
    Definitions for Japanese Analysis Module
=============================================================================================
}
{
    Default dictionary access method for Japanese analysis
}
{
    Data length limitations of Apple Japanese dictionaries
}

CONST
	kMaxYomiLengthInAppleJapaneseDictionary = 40;
	kMaxKanjiLengthInAppleJapaneseDictionary = 64;

{
    Defined field tags of Apple Japanese dictionary
}
	kDCMJapaneseYomiTag			= 'yomi';
	kDCMJapaneseHyokiTag		= 'hyok';
	kDCMJapaneseHinshiTag		= 'hins';
	kDCMJapaneseWeightTag		= 'hind';
	kDCMJapanesePhoneticTag		= 'hton';
	kDCMJapaneseAccentTag		= 'acnt';
	kDCMJapaneseOnKunReadingTag	= 'OnKn';
	kDCMJapaneseFukugouInfoTag	= 'fuku';

	kDCMJapaneseYomiType		= 'utxt';
	kDCMJapaneseHyokiType		= 'utxt';
	kDCMJapaneseHinshiType		= 'hins';
	kDCMJapaneseWeightType		= 'shor';
	kDCMJapanesePhoneticType	= 'utxt';
	kDCMJapaneseAccentType		= 'byte';
	kDCMJapaneseOnKunReadingType = 'utxt';
	kDCMJapaneseFukugouInfoType	= 'fuku';


{
=============================================================================================
 System 7 Dictionary Manager
=============================================================================================
}
{$ALIGN MAC68K}
																{  Dictionary data insertion modes  }
	kInsert						= 0;							{  Only insert the input entry if there is nothing in the dictionary that matches the key.  }
	kReplace					= 1;							{  Only replace the entries which match the key with the input entry.  }
	kInsertOrReplace			= 2;							{  Insert the entry if there is nothing in the dictionary which matches the key, otherwise replaces the existing matched entries with the input entry.  }

{ This Was InsertMode }

TYPE
	DictionaryDataInsertMode			= INTEGER;

CONST
																{  Key attribute constants  }
	kIsCaseSensitive			= $10;							{  case sensitive = 16        }
	kIsNotDiacriticalSensitive	= $20;							{  diac not sensitive = 32     }

																{  Registered attribute type constants.    }
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

{$IFC CALL_NOT_IN_CARBON }
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



{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DictionaryIncludes}

{$ENDC} {__DICTIONARY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
