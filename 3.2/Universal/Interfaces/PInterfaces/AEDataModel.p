{
 	File:		AEDataModel.p
 
 	Contains:	AppleEvent Data Model Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1996-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AEDataModel;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __AEDATAMODEL__}
{$SETC __AEDATAMODEL__ := 1}

{$I+}
{$SETC AEDataModelIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Apple event descriptor types }

CONST
	typeBoolean					= 'bool';
	typeChar					= 'TEXT';

{ Preferred numeric Apple event descriptor types }
	typeSInt16					= 'shor';
	typeSInt32					= 'long';
	typeUInt32					= 'magn';
	typeSInt64					= 'comp';
	typeIEEE32BitFloatingPoint	= 'sing';
	typeIEEE64BitFloatingPoint	= 'doub';
	type128BitFloatingPoint		= 'ldbl';
	typeDecimalStruct			= 'decm';

{ Non-preferred Apple event descriptor types }
	typeSMInt					= 'shor';
	typeShortInteger			= 'shor';
	typeInteger					= 'long';
	typeLongInteger				= 'long';
	typeMagnitude				= 'magn';
	typeComp					= 'comp';
	typeSMFloat					= 'sing';
	typeShortFloat				= 'sing';
	typeFloat					= 'doub';
	typeLongFloat				= 'doub';
	typeExtended				= 'exte';

{ More Apple event descriptor types }
	typeAEList					= 'list';
	typeAERecord				= 'reco';
	typeAppleEvent				= 'aevt';
	typeEventRecord				= 'evrc';
	typeTrue					= 'true';
	typeFalse					= 'fals';
	typeAlias					= 'alis';
	typeEnumerated				= 'enum';
	typeType					= 'type';
	typeAppParameters			= 'appa';
	typeProperty				= 'prop';
	typeFSS						= 'fss ';
	typeKeyword					= 'keyw';
	typeSectionH				= 'sect';
	typeWildCard				= '****';
	typeApplSignature			= 'sign';
	typeQDRectangle				= 'qdrt';
	typeFixed					= 'fixd';
	typeSessionID				= 'ssid';
	typeTargetID				= 'targ';
	typeProcessSerialNumber		= 'psn ';
	typeKernelProcessID			= 'kpid';
	typeDispatcherID			= 'dspt';
	typeNull					= 'null';						{  null or nonexistent data  }

{ Keywords for Apple event attributes }
	keyTransactionIDAttr		= 'tran';
	keyReturnIDAttr				= 'rtid';
	keyEventClassAttr			= 'evcl';
	keyEventIDAttr				= 'evid';
	keyAddressAttr				= 'addr';
	keyOptionalKeywordAttr		= 'optk';
	keyTimeoutAttr				= 'timo';
	keyInteractLevelAttr		= 'inte';						{  this attribute is read only - will be set in AESend  }
	keyEventSourceAttr			= 'esrc';						{  this attribute is read only  }
	keyMissedKeywordAttr		= 'miss';						{  this attribute is read only  }
	keyOriginalAddressAttr		= 'from';						{  new in 1.0.1  }


{	Constants used for specifying the factoring of AEDescLists. }
	kAEDescListFactorNone		= 0;
	kAEDescListFactorType		= 4;
	kAEDescListFactorTypeAndSize = 8;

{ Constants used creating an AppleEvent }
																{  Constant for the returnID param of AECreateAppleEvent  }
	kAutoGenerateReturnID		= -1;							{  AECreateAppleEvent will generate a session-unique ID  }
																{  Constant for transaction ID’s  }
	kAnyTransactionID			= 0;							{  no transaction is in use  }

{ Apple event manager data types }

TYPE
	DescType							= ResType;
	AEKeyword							= FourCharCode;
	AEDescPtr = ^AEDesc;
	AEDesc = RECORD
		descriptorType:			DescType;
		dataHandle:				Handle;
	END;

	AEKeyDescPtr = ^AEKeyDesc;
	AEKeyDesc = RECORD
		descKey:				AEKeyword;
		descContent:			AEDesc;
	END;

{ a list of AEDesc's is a special kind of AEDesc }
	AEDescList							= AEDesc;
	AEDescListPtr 						= ^AEDescList;
{ AERecord is a list of keyworded AEDesc's }
	AERecord							= AEDescList;
	AERecordPtr 						= ^AERecord;
{ an AEDesc which contains address data }
	AEAddressDesc						= AEDesc;
	AEAddressDescPtr 					= ^AEAddressDesc;
{ an AERecord that contains an AppleEvent, and related data types }
	AppleEvent							= AERecord;
	AppleEventPtr 						= ^AppleEvent;
	AEReturnID							= SInt16;
	AETransactionID						= SInt32;
	AEEventClass						= FourCharCode;
	AEEventID							= FourCharCode;
	AEArrayType							= SInt8;

CONST
	kAEDataArray				= 0;
	kAEPackedArray				= 1;
	kAEDescArray				= 3;
	kAEKeyDescArray				= 4;


	kAEHandleArray				= 2;


TYPE
	AEArrayDataPtr = ^AEArrayData;
	AEArrayData = RECORD
		CASE INTEGER OF
		0: (
			kAEDataArray:		ARRAY [0..0] OF INTEGER;
			);
		1: (
			kAEPackedArray:		SInt8;
			);
		2: (
			kAEHandleArray:		ARRAY [0..0] OF Handle;
			);
		3: (
			kAEDescArray:		ARRAY [0..0] OF AEDesc;
			);
		4: (
			kAEKeyDescArray:	ARRAY [0..0] OF AEKeyDesc;
			);
	END;

	AEArrayDataPointer					= ^AEArrayData;
	AEArrayDataPointerPtr 				= ^AEArrayDataPointer;

{*************************************************************************
  These calls are used to set up and modify the coercion dispatch table.
*************************************************************************}
{$IFC TYPED_FUNCTION_POINTERS}
	AECoerceDescProcPtr = FUNCTION({CONST}VAR fromDesc: AEDesc; toType: DescType; handlerRefcon: LONGINT; VAR toDesc: AEDesc): OSErr;
{$ELSEC}
	AECoerceDescProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	AECoercePtrProcPtr = FUNCTION(typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size; toType: DescType; handlerRefcon: LONGINT; VAR result: AEDesc): OSErr;
{$ELSEC}
	AECoercePtrProcPtr = ProcPtr;
{$ENDC}

	AECoerceDescUPP = UniversalProcPtr;
	AECoercePtrUPP = UniversalProcPtr;

CONST
	uppAECoerceDescProcInfo = $00003FE0;
	uppAECoercePtrProcInfo = $0003FFE0;

FUNCTION NewAECoerceDescProc(userRoutine: AECoerceDescProcPtr): AECoerceDescUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewAECoercePtrProc(userRoutine: AECoercePtrProcPtr): AECoercePtrUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallAECoerceDescProc({CONST}VAR fromDesc: AEDesc; toType: DescType; handlerRefcon: LONGINT; VAR toDesc: AEDesc; userRoutine: AECoerceDescUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallAECoercePtrProc(typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size; toType: DescType; handlerRefcon: LONGINT; VAR result: AEDesc; userRoutine: AECoercePtrUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	AECoercionHandlerUPP				= UniversalProcPtr;
FUNCTION AEInstallCoercionHandler(fromType: DescType; toType: DescType; handler: AECoercionHandlerUPP; handlerRefcon: LONGINT; fromTypeIsDesc: BOOLEAN; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A22, $A816;
	{$ENDC}
FUNCTION AERemoveCoercionHandler(fromType: DescType; toType: DescType; handler: AECoercionHandlerUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0723, $A816;
	{$ENDC}
FUNCTION AEGetCoercionHandler(fromType: DescType; toType: DescType; VAR handler: AECoercionHandlerUPP; VAR handlerRefcon: LONGINT; VAR fromTypeIsDesc: BOOLEAN; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B24, $A816;
	{$ENDC}
{*************************************************************************
  The following calls provide for a coercion interface.
*************************************************************************}
FUNCTION AECoercePtr(typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size; toType: DescType; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A02, $A816;
	{$ENDC}
FUNCTION AECoerceDesc({CONST}VAR theAEDesc: AEDesc; toType: DescType; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0603, $A816;
	{$ENDC}

{*************************************************************************
 The following calls apply to any AEDesc. Every 'result' descriptor is
 created for you, so you will be responsible for memory management
 (including disposing) of the descriptors so created.  
*************************************************************************}
FUNCTION AECreateDesc(typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0825, $A816;
	{$ENDC}
FUNCTION AEDisposeDesc(VAR theAEDesc: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0204, $A816;
	{$ENDC}
FUNCTION AEDuplicateDesc({CONST}VAR theAEDesc: AEDesc; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0405, $A816;
	{$ENDC}

{*************************************************************************
  The following calls apply to AEDescList. Since AEDescList is a subtype of
  AEDesc, the calls in the previous section can also be used for AEDescList.
  All list and array indices are 1-based. If the data was greater than
  maximumSize in the routines below, then actualSize will be greater than
  maximumSize, but only maximumSize bytes will actually be retrieved.
*************************************************************************}
FUNCTION AECreateList(factoringPtr: UNIV Ptr; factoredSize: Size; isRecord: BOOLEAN; VAR resultList: AEDescList): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0706, $A816;
	{$ENDC}
FUNCTION AECountItems({CONST}VAR theAEDescList: AEDescList; VAR theCount: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0407, $A816;
	{$ENDC}
FUNCTION AEPutPtr(VAR theAEDescList: AEDescList; index: LONGINT; typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A08, $A816;
	{$ENDC}
FUNCTION AEPutDesc(VAR theAEDescList: AEDescList; index: LONGINT; {CONST}VAR theAEDesc: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0609, $A816;
	{$ENDC}
FUNCTION AEGetNthPtr({CONST}VAR theAEDescList: AEDescList; index: LONGINT; desiredType: DescType; VAR theAEKeyword: AEKeyword; VAR typeCode: DescType; dataPtr: UNIV Ptr; maximumSize: Size; VAR actualSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $100A, $A816;
	{$ENDC}
FUNCTION AEGetNthDesc({CONST}VAR theAEDescList: AEDescList; index: LONGINT; desiredType: DescType; VAR theAEKeyword: AEKeyword; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A0B, $A816;
	{$ENDC}
FUNCTION AESizeOfNthItem({CONST}VAR theAEDescList: AEDescList; index: LONGINT; VAR typeCode: DescType; VAR dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $082A, $A816;
	{$ENDC}
FUNCTION AEGetArray({CONST}VAR theAEDescList: AEDescList; arrayType: AEArrayType; arrayPtr: AEArrayDataPointer; maximumSize: Size; VAR itemType: DescType; VAR itemSize: Size; VAR itemCount: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0D0C, $A816;
	{$ENDC}
FUNCTION AEPutArray(VAR theAEDescList: AEDescList; arrayType: AEArrayType; {CONST}VAR arrayPtr: AEArrayData; itemType: DescType; itemSize: Size; itemCount: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B0D, $A816;
	{$ENDC}
FUNCTION AEDeleteItem(VAR theAEDescList: AEDescList; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040E, $A816;
	{$ENDC}

{*************************************************************************
 The following calls apply to AERecord. Since AERecord is a subtype of
 AEDescList, the calls in the previous sections can also be used for
 AERecord an AERecord can be created by using AECreateList with isRecord
 set to true. 
*************************************************************************}
{
  Note: none of the “key” calls were available in the PowerPC 7.x IntefaceLib.
  In C, a #define is used to map “key” calls to “param” calls.  In pascal
  this mapping is done in externally linked glue code.
}

FUNCTION AEPutKeyPtr(VAR theAERecord: AERecord; theAEKeyword: AEKeyword; typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A0F, $A816;
	{$ENDC}
FUNCTION AEPutKeyDesc(VAR theAERecord: AERecord; theAEKeyword: AEKeyword; {CONST}VAR theAEDesc: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0610, $A816;
	{$ENDC}
FUNCTION AEGetKeyPtr({CONST}VAR theAERecord: AERecord; theAEKeyword: AEKeyword; desiredType: DescType; VAR typeCode: DescType; dataPtr: UNIV Ptr; maximumSize: Size; VAR actualSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0E11, $A816;
	{$ENDC}
FUNCTION AEGetKeyDesc({CONST}VAR theAERecord: AERecord; theAEKeyword: AEKeyword; desiredType: DescType; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0812, $A816;
	{$ENDC}
FUNCTION AESizeOfKeyDesc({CONST}VAR theAERecord: AERecord; theAEKeyword: AEKeyword; VAR typeCode: DescType; VAR dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0829, $A816;
	{$ENDC}
FUNCTION AEDeleteKeyDesc(VAR theAERecord: AERecord; theAEKeyword: AEKeyword): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0413, $A816;
	{$ENDC}
{*************************************************************************
  The following calls create and manipulate the AppleEvent data type.
*************************************************************************}
FUNCTION AECreateAppleEvent(theAEEventClass: AEEventClass; theAEEventID: AEEventID; {CONST}VAR target: AEAddressDesc; returnID: AEReturnID; transactionID: AETransactionID; VAR result: AppleEvent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B14, $A816;
	{$ENDC}

{*************************************************************************
  The following calls are used to pack and unpack parameters from records
  of type AppleEvent. Since AppleEvent is a subtype of AERecord, the calls
  in the previous sections can also be used for variables of type
  AppleEvent. The next six calls are in fact identical to the six calls
  for AERecord.
*************************************************************************}
FUNCTION AEPutParamPtr(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A0F, $A816;
	{$ENDC}
FUNCTION AEPutParamDesc(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; {CONST}VAR theAEDesc: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0610, $A816;
	{$ENDC}
FUNCTION AEGetParamPtr({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; desiredType: DescType; VAR typeCode: DescType; dataPtr: UNIV Ptr; maximumSize: Size; VAR actualSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0E11, $A816;
	{$ENDC}
FUNCTION AEGetParamDesc({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; desiredType: DescType; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0812, $A816;
	{$ENDC}
FUNCTION AESizeOfParam({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; VAR typeCode: DescType; VAR dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0829, $A816;
	{$ENDC}
FUNCTION AEDeleteParam(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0413, $A816;
	{$ENDC}


{*************************************************************************
 The following calls also apply to type AppleEvent. Message attributes are
 far more restricted, and can only be accessed through the following 5
 calls. The various list and record routines cannot be used to access the
 attributes of an event. 
*************************************************************************}
FUNCTION AEGetAttributePtr({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; desiredType: DescType; VAR typeCode: DescType; dataPtr: UNIV Ptr; maximumSize: Size; VAR actualSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0E15, $A816;
	{$ENDC}
FUNCTION AEGetAttributeDesc({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; desiredType: DescType; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0826, $A816;
	{$ENDC}
FUNCTION AESizeOfAttribute({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; VAR typeCode: DescType; VAR dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0828, $A816;
	{$ENDC}
FUNCTION AEPutAttributePtr(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A16, $A816;
	{$ENDC}
FUNCTION AEPutAttributeDesc(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; {CONST}VAR theAEDesc: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0627, $A816;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AEDataModelIncludes}

{$ENDC} {__AEDATAMODEL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
