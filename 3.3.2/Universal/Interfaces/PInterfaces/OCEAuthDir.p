{
     File:       OCEAuthDir.p
 
     Contains:   Apple Open Collaboration Environment Authentication Interfaces.
 
     Version:    Technology: AOCE Toolbox 1.02
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1994-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OCEAuthDir;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OCEAUTHDIR__}
{$SETC __OCEAUTHDIR__ := 1}

{$I+}
{$SETC OCEAuthDirIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __APPLETALK__}
{$I AppleTalk.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}

{$IFC UNDEFINED __OCE__}
{$I OCE.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{***************************************************************************}

CONST
	kRC4KeySizeInBytes			= 8;							{  size of an RC4 key  }
	kRefNumUnknown				= 0;

	kEnumDistinguishedNameBit	= 0;
	kEnumAliasBit				= 1;
	kEnumPseudonymBit			= 2;
	kEnumDNodeBit				= 3;
	kEnumInvisibleBit			= 4;

{ Values of DirEnumChoices }
	kEnumDistinguishedNameMask	= $00000001;
	kEnumAliasMask				= $00000002;
	kEnumPseudonymMask			= $00000004;
	kEnumDNodeMask				= $00000008;
	kEnumInvisibleMask			= $00000010;
	kEnumAllMask				= $0000001F;


TYPE
	DirEnumChoices						= UInt32;
{ Values of DirSortOption }

CONST
	kSortByName					= 0;
	kSortByType					= 1;


{ Values of DirSortDirection }
	kSortForwards				= 0;
	kSortBackwards				= 1;

{ Values of DirMatchWith }
	kMatchAll					= 0;
	kExactMatch					= 1;
	kBeginsWith					= 2;
	kEndingWith					= 3;
	kContaining					= 4;


TYPE
	DirMatchWith						= SInt8;

CONST
	kCurrentOCESortVersion		= 1;

{  Access controls are implemented on three levels:
 *      DNode, Record, and Attribute Type levels
 *  Some access control bits apply to the container itself, and some apply to its contents.
 *
 *  The Catalog Toolbox supports six functions.  These calls are:
 *  DSGetDNodeAccessControl : to get Access Controls at the DNode level
 *  DSGetRecordAccessControl  : to get Access Controls at the record level
 *  DSGetAttributeAccessControl : to get Access Privileges at the attribute type level
 * 
 *  The GetXXXAccessControl calls will return access control masks for various categories
 *  of users.  Please refer to the access control document for a description of the
 *  categories of users.  In general these are:
 *      ThisRecordOwner         - means the identity of the record itself
 *      Friends                  - means any one of the assigned friends for the record
 *      AuthenticatedInDNode     - means any valid user that is an authenticated entity
 *          in the DNode in which this record is located
 *      AuthenticatedInDirectory - means any valid authenticated catalog user
 *      Guest                    - means an unauthenticated user.
 *  Bit masks for various permitted access controls are defined below.
 *
 *  GetXXXAccessControl calls will return access control masks for various categories of
 *  users for this record. In addition they also return the level of access controls
 *  that the user (who is making the GetXXXAccessControl call) has for the DNode,
 *  record, or attribute type.
 *
 *  For records, the access control granted will be minimum of the DNode access
 *  control and record access control masks.  For example, to add an attribute type to a
 *  record, a user must have access control kCreateAttributeTypes at the record and
 *  DNode levels.  Similarly, at the attribute type level, access controls will be the
 *  minimum of the DNode, record, and attribute type access controls.
 *
 *  
 }
{ access privileges bit numbers }
	kSeeBit						= 0;
	kAddBit						= 1;
	kDeleteBit					= 2;
	kChangeBit					= 3;
	kRenameBit					= 4;
	kChangePrivsBit				= 5;
	kSeeFoldersBit				= 6;

{ Values of AccessMask }
	kSeeMask					= $00000001;
	kAddMask					= $00000002;
	kDeleteMask					= $00000004;
	kChangeMask					= $00000008;
	kRenameMask					= $00000010;
	kChangePrivsMask			= $00000020;
	kSeeFoldersMask				= $00000040;

	kAllPrivs					= $0000007F;
	kNoPrivs					= 0;

{

kSupportsDNodeNumberBit:
If this bit is set, a DNode can be referenced using DNodeNumbers. 
RecordLocationInfo can be specified using DNodeNumber and PathName component can be nil. 
If this bit is not set, a DNode can be referenced only by PathName to the DNode. In the 
later case DNodeNumber component inside record location info must be set to zero.

kSupportsRecordCreationIDBit:
If this bit is set, a record can be referenced by specifying CreationID 
in most catalog manager calls. If this bit is not set recordName and recordType are 
required in the recordID specification for all catalog manager calls.

kSupportsAttributeCreationIDBit:
If this bit is set, an attribute value can be obtained by specifying it's 
CreationID in Lookup call staring point and also can be used in operations 
like DeleteAttributeValue and ChangeAttributeValue an Attribute can be 
specified by AttributeType and CreationID.

*************************************************************************
Implicit assumption with creationID's and dNodeNumbers are, when supported
they are persistent and will preserved across boots and life of the system.
*************************************************************************

Following three bits are for determining the sort order in enumeration.
kSupportsMatchAllBit:
If this bit is set, enumeration of all the records is supported

kSupportsBeginsWithBit:
If this bit is set, enumeration of records matching prefix (e.g. Begin with abc)
is supported

kSupportsExactMatchBit:
If this bit is set, existence of a record matching exact matchNameString and recordType
is supported.

kSupportsEndsWithBit:
If this bit is set, enumeration of records matching suffix (e.g. end with abc)
is supported.

kSupportsContainsBit:
If this bit is set, enumeration of records containing a matchNameString (e.g. containing abc)
is supported


Implicit assumption in all these is, a record type can be specified either as one of the above or
a type list(more then one) to match exact type.
The Following four bits will indicate sort ordering in enumeration.

kSupportsOrderedEnumerationBit:
If this bit is set, Enumerated records or in some order possibly in name order.

kCanSupportNameOrderBit:
If this is set, catalog will support sortbyName option in Enumerate.

kCanSupportTypeOrderBit:
If this bit is set, catalog will support sortbyType option in enumearte.

kSupportSortBackwardsBit:
If this bit is set, catalog supports backward sorting.

kSupportIndexRatioBit:
If this bit is set, it indicates that enumeration will return approximate position
of a record (percentile) among all records.

kSupportsEnumerationContinueBit:
If this bit is set, catalog supports enumeration continue.

kSupportsLookupContinueBit:
If this bit is set, catalog supports lookup continue.

kSupportsEnumerateAttributeTypeContinueBit:
If this bit is set, catalog supports EnumerateAttributeType continue.

kSupportsEnumeratePseudonymContinueBit:
If this bit is set, catalog supports EnumeratePseudonym continue.

kSupportsAliasesBit:
If this bit is set, catalog supports create/delte/enumerate 
of Alias Records.

kSupportPseudonymBit: 
If this bit is set, catalog supports create/delte/enumerate of 
pseudonyms for a record.

kSupportsPartialPathNameBit:
If this bit is set, catalog nodes can be specified using DNodeNumber of a 
intermediate DNode and a partial name starting from that DNode to the intended 
DNode.

kSupportsAuthenticationBit:
If this bit is set, catalog supports authentication manager calls.

kSupportsProxiesBit:
If this bit is set, catalog supports proxy related calls in authentication manager. 

kSupportsFindRecordBit:
If this bit is set, catalog supports find record call.

Bits and corresponding masks are as defined below.
}
	kSupportsDNodeNumberBit		= 0;
	kSupportsRecordCreationIDBit = 1;
	kSupportsAttributeCreationIDBit = 2;
	kSupportsMatchAllBit		= 3;
	kSupportsBeginsWithBit		= 4;
	kSupportsExactMatchBit		= 5;
	kSupportsEndsWithBit		= 6;
	kSupportsContainsBit		= 7;
	kSupportsOrderedEnumerationBit = 8;
	kCanSupportNameOrderBit		= 9;
	kCanSupportTypeOrderBit		= 10;
	kSupportSortBackwardsBit	= 11;
	kSupportIndexRatioBit		= 12;
	kSupportsEnumerationContinueBit = 13;
	kSupportsLookupContinueBit	= 14;
	kSupportsEnumerateAttributeTypeContinueBit = 15;
	kSupportsEnumeratePseudonymContinueBit = 16;
	kSupportsAliasesBit			= 17;
	kSupportsPseudonymsBit		= 18;
	kSupportsPartialPathNamesBit = 19;
	kSupportsAuthenticationBit	= 20;
	kSupportsProxiesBit			= 21;
	kSupportsFindRecordBit		= 22;

{ values of DirGestalt }
	kSupportsDNodeNumberMask	= $00000001;
	kSupportsRecordCreationIDMask = $00000002;
	kSupportsAttributeCreationIDMask = $00000004;
	kSupportsMatchAllMask		= $00000008;
	kSupportsBeginsWithMask		= $00000010;
	kSupportsExactMatchMask		= $00000020;
	kSupportsEndsWithMask		= $00000040;
	kSupportsContainsMask		= $00000080;
	kSupportsOrderedEnumerationMask = $00000100;
	kCanSupportNameOrderMask	= $00000200;
	kCanSupportTypeOrderMask	= $00000400;
	kSupportSortBackwardsMask	= $00000800;
	kSupportIndexRatioMask		= $00001000;
	kSupportsEnumerationContinueMask = $00002000;
	kSupportsLookupContinueMask	= $00004000;
	kSupportsEnumerateAttributeTypeContinueMask = $00008000;
	kSupportsEnumeratePseudonymContinueMask = $00010000;
	kSupportsAliasesMask		= $00020000;
	kSupportsPseudonymsMask		= $00040000;
	kSupportsPartialPathNamesMask = $00080000;
	kSupportsAuthenticationMask	= $00100000;
	kSupportsProxiesMask		= $00200000;
	kSupportsFindRecordMask		= $00400000;


{ Values of AuthLocalIdentityOp }
	kAuthLockLocalIdentityOp	= 1;
	kAuthUnlockLocalIdentityOp	= 2;
	kAuthLocalIdentityNameChangeOp = 3;

{ Values of AuthLocalIdentityLockAction }
	kAuthLockPending			= 1;
	kAuthLockWillBeDone			= 2;


{ Values of AuthNotifications }
	kNotifyLockBit				= 0;
	kNotifyUnlockBit			= 1;
	kNotifyNameChangeBit		= 2;

	kNotifyLockMask				= $00000001;
	kNotifyUnlockMask			= $00000002;
	kNotifyNameChangeMask		= $00000004;

	kPersonalDirectoryFileCreator = 'kl03';
	kPersonalDirectoryFileType	= 'pabt';
	kBusinessCardFileType		= 'bust';
	kDirectoryFileType			= 'dirt';
	kDNodeFileType				= 'dnod';
	kDirsRootFileType			= 'drtt';
	kRecordFileType				= 'rcrd';


TYPE
	DirSortOption						= UInt16;
	DirSortDirection					= UInt16;
	AccessMask							= UInt32;
	DirGestalt							= UInt32;
	AuthLocalIdentityOp					= UInt32;
	AuthLocalIdentityLockAction			= UInt32;
	AuthNotifications					= UInt32;
	DNodeIDPtr = ^DNodeID;
	DNodeID = RECORD
		dNodeNumber:			DNodeNum;								{  dNodenumber   }
		reserved1:				LONGINT;
		name:					RStringPtr;
		reserved2:				LONGINT;
	END;

	DirEnumSpecPtr = ^DirEnumSpec;
	DirEnumSpec = RECORD
		enumFlag:				DirEnumChoices;
		indexRatio:				UInt16;									{  Approx Record Position between 1 and 100 If supported, 0 If not supported  }
		CASE INTEGER OF
		0: (
			recordIdentifier:	LocalRecordID;
			);
		1: (
			dNodeIdentifier:	DNodeID;
			);
	END;

	DirMetaInfoPtr = ^DirMetaInfo;
	DirMetaInfo = RECORD
		info:					ARRAY [0..3] OF UInt32;
	END;

	SLRVPtr = ^SLRV;
	SLRV = RECORD
		script:					ScriptCode;								{    Script code in which entries are sorted  }
		language:				INTEGER;								{    Language code in which entries are sorted  }
		regionCode:				INTEGER;								{    Region code in which entries are sorted  }
		version:				INTEGER;								{   version of oce sorting software  }
	END;

{ Catalog types and operations }
{ unique identifier for an identity }
	AuthIdentity						= UInt32;
{ Umbrella LocalIdentity }
	LocalIdentity						= AuthIdentity;
{ A DES key is 8 bytes of data }
	DESKeyPtr = ^DESKey;
	DESKey = RECORD
		a:						UInt32;
		b:						UInt32;
	END;

	RC4Key								= ARRAY [0..7] OF SignedByte;
	AuthKeyType							= UInt32;
{ key type followed by its data }
	AuthKeyPtr = ^AuthKey;
	AuthKey = RECORD
		keyType:				AuthKeyType;
		CASE INTEGER OF
		0: (
			des:				DESKey;
			);
		1: (
			rc4:				RC4Key;
			);
	END;

	AuthParamBlockPtr = ^AuthParamBlock;
{ Fix parameter passing convention (#1274062) ggs, 8-7-95 }
{$IFC TYPED_FUNCTION_POINTERS}
	AuthIOCompletionProcPtr = PROCEDURE(paramBlock: AuthParamBlockPtr);
{$ELSEC}
	AuthIOCompletionProcPtr = Register68kProcPtr;
{$ENDC}

	AuthIOCompletionUPP = UniversalProcPtr;
{****************************************************************************


        Authentication Manager operations 

****************************************************************************}
{
kAuthResolveCreationID:
userRecord will contain the user information whose creationID has to be
returned. A client must make this call when he does not know the creaitionID.
The creationID must be set to nil before making the call. The server will attempt
to match the recordid's in the data base which match the user name and
type in the record.  Depending on number of matchings, following
results will be returned.
Exactly One Match : CreationID in RecordID and also in buffer (if buffer is given)
totalMatches = actualMatches = 1.
> 1 Match:
    Buffer is Large Enough:
    totalMatches = actualMatches
    Buffer will contain all the CIDs, kOCEAmbiguousMatches error.
> 1 Match:
    Buffer is not Large Enough:
    totalMatches > actualMatches
    Buffer will contain all the CIDs (equal to actualMatches), daMoreDataError error.
0 Matches:
 kOCENoSuchRecord error
}
	AuthResolveCreationIDPBPtr = ^AuthResolveCreationIDPB;
	AuthResolveCreationIDPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userRecord:				RecordIDPtr;							{   --> OCE name(Record) of the user  }
		bufferLength:			UInt32;									{   --> Buffer Size to hold duplicate Info  }
		buffer:					Ptr;									{   --> Buffer  to hold duplicate Info  }
		totalMatches:			UInt32;									{  <--  Total Number of matching names found  }
		actualMatches:			UInt32;									{  <--  Number of matches returned in the buffer  }
	END;

{
kAuthBindSpecificIdentity:
userRecord will contain the user information whose identity has to be
verified. userKey will contain the userKey. An Identity is returned which
binds the key and the userRecord. The identity returned can be used in the 'identity'
field in the header portion (AuthParamHeader) for authenticating the Catalog and
Authentication manager calls.
}
	AuthBindSpecificIdentityPBPtr = ^AuthBindSpecificIdentityPB;
	AuthBindSpecificIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userIdentity:			AuthIdentity;							{  <--  binding identity  }
		userRecord:				RecordIDPtr;							{   --> OCE name(Record) of the user  }
		userKey:				AuthKeyPtr;								{   --> OCE Key for the user  }
	END;

{
kAuthUnbindSpecificIdentity:
This call will unbind the userRecord and key which were bind earlier.
}
	AuthUnbindSpecificIdentityPBPtr = ^AuthUnbindSpecificIdentityPB;
	AuthUnbindSpecificIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userIdentity:			AuthIdentity;							{   --> identity to be deleted  }
	END;


{
kAuthGetSpecificIdentityInfo:
This call will return the userRecord for the given identity. Note: key is not
returned because this would compromise security.
}
	AuthGetSpecificIdentityInfoPBPtr = ^AuthGetSpecificIdentityInfoPB;
	AuthGetSpecificIdentityInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userIdentity:			AuthIdentity;							{   --> identity of initiator  }
		userRecord:				RecordIDPtr;							{  <--  OCE name(Record) of the user  }
	END;


{
kAuthAddKey:
userRecord will contain the user information whose identity has to be
created. userKey will point to the key to be created. password points to
an RString containing the password used to generate the key.
}
	AuthAddKeyPBPtr = ^AuthAddKeyPB;
	AuthAddKeyPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userRecord:				RecordIDPtr;							{   --> OCE name(Record) of the user  }
		userKey:				AuthKeyPtr;								{  <--  OCE Key for the user  }
		password:				RStringPtr;								{   --> Pointer to password string  }
	END;

{
kAuthChangeKey:
userRecord will contain the user information whose identity has to be
created. userKey will point to the key to be created. password points to
an RString containing the password used to generate the key.
}
	AuthChangeKeyPBPtr = ^AuthChangeKeyPB;
	AuthChangeKeyPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userRecord:				RecordIDPtr;							{   --> OCE name(Record) of the user  }
		userKey:				AuthKeyPtr;								{  <--  New OCE Key for the user  }
		password:				RStringPtr;								{   -->Pointer to the new password string  }
	END;

{
AuthDeleteKey:
userRecord will contain the user information whose Key has to be deleted.
}
	AuthDeleteKeyPBPtr = ^AuthDeleteKeyPB;
	AuthDeleteKeyPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userRecord:				RecordIDPtr;							{   --> OCE name(Record) of the user  }
	END;

{ AuthPasswordToKey: Converts an RString into a key. }
	AuthPasswordToKeyPBPtr = ^AuthPasswordToKeyPB;
	AuthPasswordToKeyPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userRecord:				RecordIDPtr;							{   --> OCE name(Record) of the user  }
		key:					AuthKeyPtr;								{  <--   }
		password:				RStringPtr;								{   -->Pointer to the new password string  }
	END;

{
kAuthGetCredentials:
userRecord will contain the user information whose identity has to be
kMailDeletedMask. keyType (e.g. asDESKey) will indicate what type of key has to
be deleted.
}
	AuthGetCredentialsPBPtr = ^AuthGetCredentialsPB;
	AuthGetCredentialsPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userIdentity:			AuthIdentity;							{   --> identity of initiator  }
		recipient:				RecordIDPtr;							{   --> OCE name of recipient  }
		sessionKey:				AuthKeyPtr;								{  <--  session key  }
		expiry:					UTCTime;								{  <--> desired/actual expiry  }
		credentialsLength:		UInt32;									{  <--> max/actual credentials size  }
		credentials:			Ptr;									{  <--  buffer where credentials are returned  }
	END;

{
AuthDecryptCredentialsPB:
Changes:
userKey is changed userIdentity.
userRecord is changed to initiatorRecord. User must supply buffer
to hold initiatorRecord.
agentList has changed to agent. There wil be no call back.
User must supply buffer to hold agent Record.
An additional boolean parameter 'hasAgent' is included.
Toolbox will set this if an 'Agent' record is found in the
credentials. If RecordIDPtr is 'nil', no agent record will
be copied. However user can examine 'hasAgent', If true user
can reissue this call with apprpriate buffer for getting a recordID.
agent has changed to intermediary.  User must supply buffer to hold 
intermediary Record.  The toolbox will set 'hasIntermediary' if an
'intermediary' record is found in the credentials. 
}
	AuthDecryptCredentialsPBPtr = ^AuthDecryptCredentialsPB;
	AuthDecryptCredentialsPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userIdentity:			AuthIdentity;							{   --> user's Identity  }
		initiatorRecord:		RecordIDPtr;							{  <--  OCE name of the initiator  }
		sessionKey:				AuthKeyPtr;								{  <--  session key  }
		expiry:					UTCTime;								{  <--  credentials expiry time  }
		credentialsLength:		UInt32;									{   --> actual credentials size  }
		credentials:			Ptr;									{   --> credentials to be decrypted  }
		issueTime:				UTCTime;								{  <--  credentials expiry time  }
		hasIntermediary:		BOOLEAN;								{  <--  if true, An intermediary Record was found in credentials  }
		filler1:				BOOLEAN;
		intermediary:			RecordIDPtr;							{  <--  recordID of the intermediary  }
	END;


	AuthMakeChallengePBPtr = ^AuthMakeChallengePB;
	AuthMakeChallengePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		key:					AuthKeyPtr;								{   --> UnEncrypted SessionKey  }
		challenge:				Ptr;									{  <--  Encrypted Challenge  }
		challengeBufferLength:	UInt32;									{   ->length of challenge buffer  }
		challengeLength:		UInt32;									{   <-length of Encrypted Challenge  }
	END;

	AuthMakeReplyPBPtr = ^AuthMakeReplyPB;
	AuthMakeReplyPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		key:					AuthKeyPtr;								{   --> UnEncrypted SessionKey  }
		challenge:				Ptr;									{   --> Encrypted Challenge  }
		reply:					Ptr;									{  <--  Encrypted Reply  }
		replyBufferLength:		UInt32;									{   -->length of challenge buffer  }
		challengeLength:		UInt32;									{   --> length of Encrypted Challenge  }
		replyLength:			UInt32;									{  <--  length of Encrypted Reply  }
	END;

	AuthVerifyReplyPBPtr = ^AuthVerifyReplyPB;
	AuthVerifyReplyPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		key:					AuthKeyPtr;								{   --> UnEncrypted SessionKey  }
		challenge:				Ptr;									{   --> Encrypted Challenge  }
		reply:					Ptr;									{   --> Encrypted Reply  }
		challengeLength:		UInt32;									{   --> length of Encrypted Challenge  }
		replyLength:			UInt32;									{   --> length of Encrypted Reply  }
	END;



{
kAuthGetUTCTime:
RLI will contain a valid RLI for a cluster server.
UTC(GMT) time from one of the cluster server will be returned.
An 'offSet' from UTC(GMT) to Mac Local Time will also be returned.
If RLI is nil Map DA is used to determine UTC(GMT).
Mac Local Time = theUTCTime + theUTCOffset.
}
	AuthGetUTCTimePBPtr = ^AuthGetUTCTimePB;
	AuthGetUTCTimePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		pRLI:					PackedRLIPtr;							{   --> packed RLI of the Node, whose server's UTC is requested  }
		theUTCTime:				UTCTime;								{  <--  current UTC(GMT) Time utc seconds since 1/1/1904  }
		theUTCOffset:			UTCOffset;								{  <--  offset from UTC(GMT) seconds EAST of Greenwich  }
	END;


{
kAuthMakeProxy:
A user represented bu the 'userIdentity' can make a proxy using this call.
'recipient' is the RecordID of the recipient whom user is requesting proxy.
'intermediary' is the RecordID of the intermediary holding proxy for the user.
'firstValid' is time at which proxy becomes valid.
'expiry' is the time at which proxy must expire.
'proxyLength' will have the length of the buffer pointed by 'proxy' as input.
When the call completes, it will hold the actual length of proxy. If the
call completes 'kOCEMoreData' error, client can reissue the call with the
buffer size as 'proxyLength' returned.
expiry is a suggestion, and may be adjusted to be earlier by the ADAP/OCE server.
The 'proxy' obtained like this might be used by the 'intermediary' to obtain credentials
for the server using TradeProxyForCredentials call.
authDataLength and authData are intended for possible future work, but are
ignored for now.
}
	AuthMakeProxyPBPtr = ^AuthMakeProxyPB;
	AuthMakeProxyPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userIdentity:			AuthIdentity;							{   --> identity of principal  }
		recipient:				RecordIDPtr;							{   --> OCE name of recipient  }
		firstValid:				UTCTime;								{   --> time at which proxy becomes valid  }
		expiry:					UTCTime;								{   --> time at which proxy expires  }
		authDataLength:			UInt32;									{   --> size of authorization data  }
		authData:				Ptr;									{   --> pointer to authorization data  }
		proxyLength:			UInt32;									{  <--> max/actual proxy size  }
		proxy:					Ptr;									{  <--> buffer where proxy is returned  }
		intermediary:			RecordIDPtr;							{   --> RecordID of intermediary  }
	END;

{
kAuthTradeProxyForCredentials:
Using this call, intermediary holding a 'proxy' for a recipient may obtain credentials
for that recipient. 'userIdentity' is the identity for the 'intermediary'.
'recipient' is the RecordID for whom credetials are requested.
'principal' is the RecordID of the user who created the proxy.
'proxyLength' is the length of data pointed by 'proxy.
If the call is succesfull, credentials will be returned in the
buffer pointed by 'credentials'. 'expiry' is the desired expiry time at input.
When call succeds this will have expiry time of credentials.
This is very similar to GetCredentials except that we (of course) need the proxy,
but we also need the name of the principal who created the proxy.
}
	AuthTradeProxyForCredentialsPBPtr = ^AuthTradeProxyForCredentialsPB;
	AuthTradeProxyForCredentialsPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userIdentity:			AuthIdentity;							{   --> identity of intermediary  }
		recipient:				RecordIDPtr;							{   --> OCE name of recipient  }
		sessionKey:				AuthKeyPtr;								{  <--  session key  }
		expiry:					UTCTime;								{  <--> desired/actual expiry  }
		credentialsLength:		UInt32;									{  <--> max/actual credentials size  }
		credentials:			Ptr;									{  <--> buffer where credentials are returned  }
		proxyLength:			UInt32;									{   --> actual proxy size  }
		proxy:					Ptr;									{   --> buffer containing proxy  }
		principal:				RecordIDPtr;							{   --> RecordID of principal  }
	END;

{ API for Local Identity Interface }
{
AuthGetLocalIdentityPB:
A Collaborative application intended to work under the umbrella of LocalIdentity
for the OCE toolbox will have to make this call to obtain LocalIdentity.
If LocalIdentity has not been setup, then application will get
'kOCEOCESetupRequired.'. In this case application should put the dialog
recommended by the OCE Setup document and guide the user through OCE Setup.
If the OCESetup contains local identity, but user has not unlocked, it will get
kOCELocalAuthenticationFail. In this case application should use SDPPromptForLocalIdentity
to prompt user for the password.
If a backGround application or stand alone code requires LocalIdentity, if it gets the
OSErr from LocalIdentity and can not call SDPPromptForLocalIdentity, it should it self
register with the toolbox using kAuthAddToLocalIdentityQueue call. It will be notified
when a LocalIdentity gets created by a foreground application.
}
	AuthGetLocalIdentityPBPtr = ^AuthGetLocalIdentityPB;
	AuthGetLocalIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		theLocalIdentity:		LocalIdentity;							{  <--  LocalIdentity  }
	END;

{
kAuthUnlockLocalIdentity:
The LocalIdentity can be created using this call.
The userName and password correspond to the LocalIdentity setup.
If the password matches, then collabIdentity will be returned.
Typically SDPPromptForLocalIdentity call will make this call.
All applications which are registered through kAuthAddToLocalIdentityQueue
will be notified.
}
	AuthUnlockLocalIdentityPBPtr = ^AuthUnlockLocalIdentityPB;
	AuthUnlockLocalIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		theLocalIdentity:		LocalIdentity;							{  <--  LocalIdentity  }
		userName:				RStringPtr;								{   --> userName  }
		password:				RStringPtr;								{   -->user password  }
	END;

{
kAuthLockLocalIdentity:
With this call existing LocalIdentity can be locked. If the ASDeleteLocalIdetity
call fails with 'kOCEOperationDenied' error, name will contain the application which
denied the operation. This name will be supplied by the application
when it registered through kAuthAddToLocalIdentityQueue call
}
	AuthLockLocalIdentityPBPtr = ^AuthLockLocalIdentityPB;
	AuthLockLocalIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		theLocalIdentity:		LocalIdentity;							{   --> LocalIdentity  }
		name:					StringPtr;								{  <--  name of the app which denied delete  }
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	NotificationProcPtr = FUNCTION(clientData: LONGINT; callValue: AuthLocalIdentityOp; actionValue: AuthLocalIdentityLockAction; identity: LocalIdentity): BOOLEAN;
{$ELSEC}
	NotificationProcPtr = ProcPtr;
{$ENDC}

	NotificationUPP = UniversalProcPtr;
	NotificationProc					= NotificationUPP;
{
kAuthAddToLocalIdentityQueue:
An application requiring notification of locking/unlocking of the
LocalIdentity can install itself using this call. The function provided
in 'notifyProc' will be called whenever the requested event happens.
When an AuthLockLocalIdentity call is made to the toolbox, the notificationProc
will be called with 'kAuthLockPending'. The application may refuse the lock by returning
a 'true' value. If all the registered entries return 'false' value, locking will be done
successfully. Otherwise 'kOCEOperationDenied' error is returned to the caller. The appName
(registered with the notificationProc) of the application which denied locking is also
returned to the caller making the AuthLockIdentity call.
}
	AuthAddToLocalIdentityQueuePBPtr = ^AuthAddToLocalIdentityQueuePB;
	AuthAddToLocalIdentityQueuePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		notifyProc:				NotificationUPP;						{   --> notification procedure  }
		notifyFlags:			AuthNotifications;						{   --> notifyFlags  }
		appName:				StringPtr;								{   --> name of application to be returned in Delete/Stop  }
	END;

{
kAuthRemoveFromLocalIdentityQueue:}
	AuthRemoveFromLocalIdentityQueuePBPtr = ^AuthRemoveFromLocalIdentityQueuePB;
	AuthRemoveFromLocalIdentityQueuePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		notifyProc:				NotificationUPP;						{   --> notification procedure  }
	END;

{
kAuthSetupLocalIdentity:
The LocalIdentity can be Setup using this call.
The userName and password correspond to the LocalIdentity setup.
If a LocalIdentity Setup already exists 'kOCELocalIdentitySetupExists' error
will be returned.
}
	AuthSetupLocalIdentityPBPtr = ^AuthSetupLocalIdentityPB;
	AuthSetupLocalIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aReserved:				LONGINT;								{   --   }
		userName:				RStringPtr;								{   --> userName  }
		password:				RStringPtr;								{   -->user password  }
	END;

{
kAuthChangeLocalIdentity:
An existing LocalIdentity  Setup can be changed using this call.
The userName and password correspond to the LocalIdentity setup.
If a LocalIdentity Setup does not exists 'kOCEOCESetupRequired' error
will be returned. The user can use  kAuthSetupLocalIdentity call to setit up.
If the 'password' does not correspond to the existing setup, 'kOCELocalAuthenticationFail'
OSErr will be returned. If successful, LocalID will have new name as 'userName' and
password as 'newPassword' and if any applications has installed into 
LocalIdentityQueue with kNotifyNameChangeMask set, it will be notified with 
kAuthLocalIdentityNameChangeOp action value. 

}
	AuthChangeLocalIdentityPBPtr = ^AuthChangeLocalIdentityPB;
	AuthChangeLocalIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aReserved:				LONGINT;								{   --   }
		userName:				RStringPtr;								{   --> userName  }
		password:				RStringPtr;								{   --> current password  }
		newPassword:			RStringPtr;								{   --> new password  }
	END;

{
kAuthRemoveLocalIdentity:
An existing LocalIdentity  Setup can be removed using this call.
The userName and password correspond to the LocalIdentity setup.
If a LocalIdentity Setup does not exists 'kOCEOCESetupRequired' error
will be returned.
If the 'password' does not correspond to the existing setup, 'kOCELocalAuthenticationFail'
OSErr will be returned. If successful, LocalIdentity will be removed from the OCE Setup.
This is a very distructive operation, user must be warned enough before actually making
this call.
}
	AuthRemoveLocalIdentityPBPtr = ^AuthRemoveLocalIdentityPB;
	AuthRemoveLocalIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aReserved:				LONGINT;								{   --   }
		userName:				RStringPtr;								{   --> userName  }
		password:				RStringPtr;								{   --> current password  }
	END;

{
kOCESetupAddDirectoryInfo:
Using this call identity for a catalog can be setup under LocalIdentity umbrella.
ASCreateLocalIdentity should have been done succesfully before making this call.    
directoryRecordCID -> is the record creationID obtained when DirAddOCEDirectory or
DirAddDSAMDirectory call was made.
rid-> is the recordID in which the identity for the catalog will be established.
password-> the password associated with the rid in the catalog world.
}
	OCESetupAddDirectoryInfoPBPtr = ^OCESetupAddDirectoryInfoPB;
	OCESetupAddDirectoryInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryRecordCID:		CreationID;								{   --> CreationID for the catalog  }
		recordID:				RecordIDPtr;							{   --> recordID for the identity  }
		password:				RStringPtr;								{   --> password in the catalog world  }
	END;

{
kOCESetupChangeDirectoryInfo:
Using this call an existing identity for a catalog under LocalIdentity umbrella
can be changed.
ASCreateLocalIdentity should have been done succesfully before making this call.
directoryRecordCID -> is the record creationID obtained when DirAddOCEDirectory or
DirAddDSAMDirectory call was made.
rid-> is the recordID in which the identity for the catalog will be established.
password-> the password associated with the rid in the catalog world.
newPassword -> the new password for the catalog
}
	OCESetupChangeDirectoryInfoPBPtr = ^OCESetupChangeDirectoryInfoPB;
	OCESetupChangeDirectoryInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryRecordCID:		CreationID;								{   --> CreationID for the catalog  }
		recordID:				RecordIDPtr;							{   --> recordID for the identity  }
		password:				RStringPtr;								{   --> password in the catalog world  }
		newPassword:			RStringPtr;								{   --> new password in the catalog  }
	END;

{
kOCESetupRemoveDirectoryInfo:
Using this call an existing identity for a catalog under LocalIdentity umbrella
can be changed.
ASCreateLocalIdentity should have been done succesfully before making this call.
directoryRecordCID -> is the record creationID obtained when DirAddOCEDirectory or
}
	OCESetupRemoveDirectoryInfoPBPtr = ^OCESetupRemoveDirectoryInfoPB;
	OCESetupRemoveDirectoryInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryRecordCID:		CreationID;								{   --> CreationID for the catalog  }
	END;

{
kOCESetupGetDirectoryInfo:
Using this call info on an existing identity for a particular catalog under LocalIdentity umbrella
can be obtained.
For the specified catalog 'directoryName' and 'discriminator', rid and nativeName will
returned. Caller must provide appropriate buffer to get back rid and nativeName.
'password' will be returned  for  non-ADAP Catalogs.
}
	OCESetupGetDirectoryInfoPBPtr = ^OCESetupGetDirectoryInfoPB;
	OCESetupGetDirectoryInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryName:			DirectoryNamePtr;						{   --> catalog name  }
		discriminator:			DirDiscriminator;						{   --> discriminator for the catalog  }
		recordID:				RecordIDPtr;							{  <--  rid for the catalog identity  }
		nativeName:				RStringPtr;								{  <--  user name in the catalog world  }
		password:				RStringPtr;								{  <--  password in the catalog world  }
	END;

{****************************************************************************


        Catalog Manager operations


****************************************************************************}
	DirParamBlockPtr = ^DirParamBlock;
{$IFC TYPED_FUNCTION_POINTERS}
	DirIOCompletionProcPtr = PROCEDURE(paramBlock: DirParamBlockPtr);
{$ELSEC}
	DirIOCompletionProcPtr = Register68kProcPtr;
{$ENDC}

	DirIOCompletionUPP = UniversalProcPtr;
{ AddRecord }
	DirAddRecordPBPtr = ^DirAddRecordPB;
	DirAddRecordPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   --> CreationID returned here  }
		allowDuplicate:			BOOLEAN;								{   -->  }
		filler1:				BOOLEAN;
	END;



{ DeleteRecord }
	DirDeleteRecordPBPtr = ^DirDeleteRecordPB;
	DirDeleteRecordPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   -->  }
	END;

{ aRecord must contain valid PackedRLI and a CreationID. }


{********************************************************************************}
{
DirEnumerate:
This call can be used to enumerate both DNodes and records under a specified
DNode. A DNode is specified by the PackedRLIPtr 'aRLI'.

startingPoint indicates where to start the enumeration.  Initially,
it should be set to a value of nil.  After some records are enumerated,
the client can issue the call again with the same aRLI and recordName and
typeList. The last received DirEnumSpec in the startingPoint field.  The server
will continue the enumeration from that record on. if user wants to get back the
value specified in the startingRecord also, the Boolean 'includeStartingPoint'
must be set to 'true'. If this is set to 'false', records specified after the
startingPoint record will be returned.

sortBy indicates to the server to return the records that match in name-first
or type-first order.  sortDirection indicates to the server to search in forward
or backward sort order for RecordIDs Specified.

RecordIDS and Enumeration Criteria:

PackedRLIPtr parameter 'aRLI' will be accepted for DNode
specification.

One RStringPtr 'nameMatchString' is provided. User is allowed to
specify a wild card in the name. WildCard specification is specified in 
matchNameHow parameter and possible values are defined in DirMatchWith Enum.

'typeCount' parameter indicate how many types are in the 'typeList'.

'typeList' parmeter is a pointer to an RString array of size 'typeCount'.

If 'typeCount' is exactly equal to one, a wild card can be specified
for the entity type; otherwise types have to be completely specified.
WildCard specification is specified in  matchNameHow parameter
 and possible values are defined in DirMatchWith Enum.


A nil value for 'startingPoint' is allowed when sortDirection specified
is 'kSortBackwards'. This was not allowed previously.

'enumFlags' parameter is a bit field. The following bits can be set:
    kEnumDistinguishedNameMask to get back records in the cluster data base.
    kEnumAliasMask to get back record aliases
    kEnumPseudonymMask to get back record pseudonyms
    kEnumDNodeMask to get back any children dNodes for the DNode specified in the
    'aRLI' parameter.
    kEnumForeignDNodeMask to get back any children dNodes which have ForeignDnodes in the
    dNode specified in the 'aRLI' parameter.

    kEnumAll is combination of all five values and can be used to enumerate
    everything under a specified DNode.



The results returned for each element will consist of a DirEnumSpec.
The DirEnumSpec contains 'enumFlag' which indicates the type of entity and a
union which will have either DNodeID or LocalRecordID depending on the value of 'enumFlag'.
The 'enumFlag'  will indicate whether the returned element is a
record(kEnumDistinguishedNameMask bit) or a alias(kEnumAliasMask bit) or a
Pseudonym(kEnumPseudonymMask) or a child DNode(kEnumDNodeMask bit).  If the 'enumFlag' value
is kEnumDnodeMask, it indicates the value returned in the union is a DNodeID (i.e. 'dNodeNumber'
is the 'dNodeNumber' of the child dnode(if the catalog supports dNodeNumbers, otherwise
this will be set to zero). The name will be the child dnode name. For other values of the
'enumFlag', the value in the union will be LocalRecordID. In addition to kEnumDnodeMask it is
possible that kEnumForeignDNodeMask is also set. This is an advisory bit and application must make
it's own decision before displaying these records. If catalog supports kSupportIndexRatioMask, it
may also return the relative position of the record (percentile of total records) in the 
indexRatio field in EnumSpec.


responseSLRV will contain the script, language, region and version of the oce sorting software.
The results will be collected in the 'getBuffer' supplied by the user.
If buffer can not hold all the data returned 'kOCEMoreData' error will be returned.

If user receives 'noErr' or 'kOCEMoreData', buffer will contain valid results. A user
can extract the results in the 'getBuffer' by making DirEnumerateParse' call.
}

	DirEnumerateGetPBPtr = ^DirEnumerateGetPB;
	DirEnumerateGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRLI:					PackedRLIPtr;							{   --> an RLI specifying the cluster to be enumerated  }
		startingPoint:			DirEnumSpecPtr;							{   -->  }
		sortBy:					DirSortOption;							{   -->  }
		sortDirection:			DirSortDirection;						{   -->  }
		dReserved:				LONGINT;								{   --   }
		nameMatchString:		RStringPtr;								{   --> name from which enumeration should start  }
		typesList:				^RStringPtr;							{   --> list of entity types to be enumerated  }
		typeCount:				UInt32;									{   --> number of types in the list  }
		enumFlags:				DirEnumChoices;							{   --> indicates what to enumerate  }
		includeStartingPoint:	BOOLEAN;								{   --> if true return the record specified in starting point  }
		padByte:				SInt8;
		matchNameHow:			DirMatchWith;							{   --> Matching Criteria for nameMatchString  }
		matchTypeHow:			DirMatchWith;							{   --> Matching Criteria for typeList  }
		getBuffer:				Ptr;									{   -->  }
		getBufferSize:			UInt32;									{   -->  }
		responseSLRV:			SLRV;									{   <--  response SLRV  }
	END;

{ The EnumerateRecords call-back function is defined as follows: }
{$IFC TYPED_FUNCTION_POINTERS}
	ForEachDirEnumSpecProcPtr = FUNCTION(clientData: LONGINT; {CONST}VAR enumSpec: DirEnumSpec): BOOLEAN;
{$ELSEC}
	ForEachDirEnumSpecProcPtr = ProcPtr;
{$ENDC}

	ForEachDirEnumSpecUPP = UniversalProcPtr;
	ForEachDirEnumSpec					= ForEachDirEnumSpecUPP;
{
EnumerateParse:
After an EnumerateGet call has completed, call EnumerateParse
to parse through the buffer that was filled in EnumerateGet.

'eachEnumSpec' will be called each time to return to the client a
DirEnumSpec that matches the pattern for enumeration. 'enumFlag' indicates the type
of information returned in the DirEnumSpec
The clientData parameter that you pass in the parameter block will be passed
to 'forEachEnumDSSpecFunc'.  You are free to put anything in clientData - it is intended
to allow you some way to match the call-back to the original call (for
example, you make more then one aysynchronous EnumerateGet calls and you want to
associate returned results in some way).

The client should return FALSE from 'eachEnumSpec' to continue
processing of the EnumerateParse request.  Returning TRUE will
terminate the EnumerateParse request.

For synchronous calls, the call-back routine actually runs as part of the same thread
of execution as the thread that made the EnumerateParse call.  That means that the
same low-memory globals, A5, stack, etc. are in effect during the call-back
that were in effect when the call was made.  Because of this, the call-back
routine has the same restrictions as the caller of EnumerateParse:
if EnumerateParse was not called from interrupt level, then the call-
back routine can allocate memory. For asynchronous calls, call-back routine is
like a ioCompletion except that A5 will be preserved for the application.
}
	DirEnumerateParsePBPtr = ^DirEnumerateParsePB;
	DirEnumerateParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRLI:					PackedRLIPtr;							{   --> an RLI specifying the cluster to be enumerated  }
		bReserved:				LONGINT;								{   --   }
		cReserved:				LONGINT;								{   --   }
		eachEnumSpec:			ForEachDirEnumSpec;						{   -->  }
		eReserved:				LONGINT;								{   --   }
		fReserved:				LONGINT;								{   --   }
		gReserved:				LONGINT;								{   --   }
		hReserved:				LONGINT;								{   --   }
		iReserved:				LONGINT;								{   --   }
		getBuffer:				Ptr;									{   -->  }
		getBufferSize:			UInt32;									{   -->  }
		l1Reserved:				INTEGER;								{   --  }
		l2Reserved:				INTEGER;								{   --   }
		l3Reserved:				INTEGER;								{   --  }
		l4Reserved:				INTEGER;								{   --   }
	END;

{
 * FindRecordGet operates similarly to DirEnumerate except it returns a list
 * of records instead of records local to a cluster.
}
	DirFindRecordGetPBPtr = ^DirFindRecordGetPB;
	DirFindRecordGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		startingPoint:			RecordIDPtr;
		reservedA:				ARRAY [0..1] OF LONGINT;
		nameMatchString:		RStringPtr;
		typesList:				^RStringPtr;
		typeCount:				UInt32;
		reservedB:				LONGINT;
		reservedC:				INTEGER;
		matchNameHow:			DirMatchWith;
		matchTypeHow:			DirMatchWith;
		getBuffer:				Ptr;
		getBufferSize:			UInt32;
		directoryName:			DirectoryNamePtr;
		discriminator:			DirDiscriminator;
	END;

{ The FindRecordParse call-back function is defined as follows: }
{$IFC TYPED_FUNCTION_POINTERS}
	ForEachRecordProcPtr = FUNCTION(clientData: LONGINT; {CONST}VAR enumSpec: DirEnumSpec; pRLI: PackedRLIPtr): BOOLEAN;
{$ELSEC}
	ForEachRecordProcPtr = ProcPtr;
{$ENDC}

	ForEachRecordUPP = UniversalProcPtr;
	ForEachRecord						= ForEachRecordUPP;
{
 * This PB same as DirFindRecordGet except it includes the callback function
}
	DirFindRecordParsePBPtr = ^DirFindRecordParsePB;
	DirFindRecordParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		startingPoint:			RecordIDPtr;
		reservedA:				ARRAY [0..1] OF LONGINT;
		nameMatchString:		RStringPtr;
		typesList:				^RStringPtr;
		typeCount:				UInt32;
		reservedB:				LONGINT;
		reservedC:				INTEGER;
		matchNameHow:			DirMatchWith;
		matchTypeHow:			DirMatchWith;
		getBuffer:				Ptr;
		getBufferSize:			UInt32;
		directoryName:			DirectoryNamePtr;
		discriminator:			DirDiscriminator;
		forEachRecordFunc:		ForEachRecord;
	END;



{
LookupGet:

aRecordList is an array of pointers to RecordIDs, each of which must
contain valid PackedRLI and a CreationID.  recordIDCount is
the size of this array.

attrTypeList is an array of pointers to AttributeTypes.  attrTypeCount is
the size of this array.

staringRecordIndex is the record from which to continue the lookup.
If you want to start from first record in the list, this must be 1 (not zero).
This value must always be <= recordIDCount.

startingAttributeIndex is the AttributeType from which we want to continue the lookup.
If you want to start from first attribute in the list, this must be 1 (not zero).
This value must always be <= attrTypeCount.

startingAttribute is the value of the attribute value from which we want to
continue lookup. In case of catalogs supporting creationIDs, startingAttribute
may contain only a CID. Other catalogs may require the entire value.
If a non-null cid is given and if an attribute value with that cid is not found, this
call will terminate with kOCENoSuchAttribute error. A client should not make a LookupParse call
after getting this error.

'includeStartingPoint' boolean can be set to 'true' to receive the value specified in the
startingPoint in the results returned. If this is set to 'false', the value
specified in the startingAttribute will not be returned.

When LookupGet call fails with kOCEMoreData, the client will be able to find out where the call ended
with a subsequent LookupParse call. When the LookupParse call completes with kOCEMoreData,
lastRecordIndex, lastAttributeIndex and lastValueCID will point to the corresponding
recordID, attributeType and the CreationID of the last value returned successfully. These parameters
are exactly the same ones for the startingRecordIndex, startingAttributeIndex, and startingAttrValueCID
so they can be used in a subsequent LookupGet call to continue the lookup.

In an extreme case, It is possible that we had an attribute value that is too large to fit
in the client's buffer. In such cases, if it was the only thing that we tried to fit
into the buffer, the client will not able to proceed further because he will not know the
attributeCID of the attribute to continue with.  Also he does not know how big a buffer
would be needed for the next call to get this 'mondo' attribute value successfully.

to support this, LookupParse call will do the following:

If LookupGet has failed with kOCEMoreData error, LookupParse will check to make sure that
ForEachAttributeValueFunc has been called at least once. If so, the client has the option
to continue from that attribute CreationID (for PAB/ADAP) in the next LookupGet call.
However, if it was not even called once, then the attribute value may be too big to fit in the
user's buffer. In this case, lastAttrValueCID (lastAttribute) and attrSize are returned in the
parse buffer and the call will fail with kOCEMoreAttrValue. However, it is possible that
ForEachAttributeValue was not called because the user does not have read access to some of
the attributeTypes in the list, and the buffer was full before even reading the creationID of
any of the attribute values.  A kOCEMoreData error is returned.

The Toolbox will check for duplicate RecordIDs in the aRecordList. If found, it will return
'daDuplicateRecordIDErr'.

The Toolbox will check for duplicate AttributeTypes in the attrTypeList. If found it will
return 'daDuplicateAttrTypeErr'.
}
	DirLookupGetPBPtr = ^DirLookupGetPB;
	DirLookupGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecordList:			^RecordIDPtr;							{   --> an array of RecordID pointers  }
		attrTypeList:			^AttributeTypePtr;						{   --> an array of attribute types  }
		cReserved:				LONGINT;								{   --   }
		dReserved:				LONGINT;								{   --   }
		eReserved:				LONGINT;								{   --   }
		fReserved:				LONGINT;								{   --   }
		recordIDCount:			UInt32;									{   -->  }
		attrTypeCount:			UInt32;									{   -->  }
		includeStartingPoint:	BOOLEAN;								{   --> if true return the value specified by the starting indices  }
		padByte:				SInt8;
		i1Reserved:				INTEGER;								{   --   }
		getBuffer:				Ptr;									{   -->  }
		getBufferSize:			UInt32;									{   -->  }
		startingRecordIndex:	UInt32;									{   --> start from this record  }
		startingAttrTypeIndex:	UInt32;									{   --> start from this attribute type  }
		startingAttribute:		Attribute;								{   --> start from this attribute value  }
		pReserved:				LONGINT;								{   --   }
	END;

{ The Lookup call-back functions are defined as follows: }
{$IFC TYPED_FUNCTION_POINTERS}
	ForEachLookupRecordIDProcPtr = FUNCTION(clientData: LONGINT; {CONST}VAR recordID: RecordID): BOOLEAN;
{$ELSEC}
	ForEachLookupRecordIDProcPtr = ProcPtr;
{$ENDC}

	ForEachLookupRecordIDUPP = UniversalProcPtr;
	ForEachLookupRecordID				= ForEachLookupRecordIDUPP;
{$IFC TYPED_FUNCTION_POINTERS}
	ForEachAttrTypeLookupProcPtr = FUNCTION(clientData: LONGINT; {CONST}VAR attrType: AttributeType; myAttrAccMask: AccessMask): BOOLEAN;
{$ELSEC}
	ForEachAttrTypeLookupProcPtr = ProcPtr;
{$ENDC}

	ForEachAttrTypeLookupUPP = UniversalProcPtr;
	ForEachAttrTypeLookup				= ForEachAttrTypeLookupUPP;
{$IFC TYPED_FUNCTION_POINTERS}
	ForEachAttrValueProcPtr = FUNCTION(clientData: LONGINT; {CONST}VAR attribute: Attribute): BOOLEAN;
{$ELSEC}
	ForEachAttrValueProcPtr = ProcPtr;
{$ENDC}

	ForEachAttrValueUPP = UniversalProcPtr;
	ForEachAttrValue					= ForEachAttrValueUPP;
{
LookupParse:

After a LookupGet call has completed, call LookupParse
to parse through the buffer that was filled in LookupGet.  The
toolbox will parse through the buffer and call the appropriate call-back routines
for each item in the getBuffer.

'eachRecordID' will be called each time to return to the client one of the
RecordIDs from aRecordList.  The clientData parameter that you
pass in the parameter block will be passed to eachRecordID.
You are free to put anything in clientData - it is intended to allow
you some way to match the call-back to the original call (in case, for
example, you make simultaneous asynchronous LookupGet calls).  If you don't
want to get a call-back for each RecordID (for example, if you're looking up
attributes for only one RecordID), pass nil for eachRecordID.

After forEachLocalRecordIDFunc is called, eachAttrType may be called to pass an
attribute type (one from attrTypeList) that exists in the record specified
in the last eachRecordID call.  If you don't want to get a call-back for
each AttributeType (for example, if you're looking up only one attribute type,
or you prefer to read the type from the Attribute struct during the eachAttrValue
call-back routine), pass nil for eachAttrType. However access controls may
prohibit you from reading some attribute types; in that case eachAttrValue
may not be called even though the value exists. Hence the client should
supply this call-back function to see the access controls for each attribute type.

This will be followed by one or more calls to eachAttrValue, to pass the
type, tag, and attribute value.  NOTE THIS CHANGE:  you are no longer expected to
pass a pointer to a buffer in which to put the value.  Now you get a pointer to
the value, and you can process it within the call-back routine.
After one or more values are returned, eachAttrType may be called again to pass
another attribute type that exists in the last-specified RecordID.

The client should return FALSE from eachRecordID, eachAttrType, and
eachAttrValue to continue processing of the LookupParse request.  Returning TRUE
from any call-back will terminate the LookupParse request.

If LookupGet has failed with kOCEMoreData error, LookupParse will check to make sure that
ForEachAttributeValueFunc has been called at least once. If so, the client has the option
to continue from that attribute CreationID (for PAB/ADAP) in the next LookupGet call.
However, if it was not even called once, then the attribute value may be too big to fit in the
user's buffer. In this case, lastAttrValueCID (lastAttribute) and attrSize are returned in the
parse buffer and the call will fail with kOCEMoreAttrValue. However, it is possible that
ForEachAttributeValue was not called because the user does not have read access to some of
the attributeTypes in the list, and the buffer was full before even reading the creationID of
any of the attribute values.  A kOCEMoreData error is returned.

For synchronous calls, the call-back routine actually runs as part of the same thread
of execution as the thread that made the LookupParse call.  That means that the
same low-memory globals, A5, stack, etc. are in effect during the call-back
that were in effect when the call was made.  Because of this, the call-back
routine has the same restrictions as the caller of LookupParse:
if LookupParse was not called from interrupt level, then the call-
back routine can allocate memory. For asynchronous calls, call-back routine is
like a ioCompletion except that A5 will be preserved for the application.
}
	DirLookupParsePBPtr = ^DirLookupParsePB;
	DirLookupParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecordList:			^RecordIDPtr;							{   --> must be same from the corresponding Get call  }
		attrTypeList:			^AttributeTypePtr;						{   --> must be same from the corresponding Get call  }
		cReserved:				LONGINT;								{   --   }
		eachRecordID:			ForEachLookupRecordID;					{   -->  }
		eachAttrType:			ForEachAttrTypeLookup;					{   -->  }
		eachAttrValue:			ForEachAttrValue;						{   -->  }
		recordIDCount:			UInt32;									{   --> must be same from the corresponding Get call  }
		attrTypeCount:			UInt32;									{   --> must be same from the corresponding Get call  }
		iReserved:				LONGINT;								{   --   }
		getBuffer:				Ptr;									{   --> must be same from the corresponding Get call }
		getBufferSize:			UInt32;									{   --> must be same from the corresponding Get call }
		lastRecordIndex:		UInt32;									{  <--  last RecordID processed when parse completed  }
		lastAttributeIndex:		UInt32;									{  <--  last Attribute Type processed when parse completed  }
		lastAttribute:			Attribute;								{  <--  last attribute value (with this CreationID) processed when parse completed  }
		attrSize:				UInt32;									{  <--  length of the attribute we did not return  }
	END;



{ AddAttributeValue }
	DirAddAttributeValuePBPtr = ^DirAddAttributeValuePB;
	DirAddAttributeValuePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   -->  }
		attr:					AttributePtr;							{   --> AttributeCreationID returned here  }
	END;

{
aRecord must contain valid PackedRLI and a CreationID.

Instead of passing type, length, and value in three separate
fields, we take a pointer to an Attribute structure that contains
all three, and has room for the AttributeCreationNumber.
The AttributeCreationID will be returned in the attr itself.

The AttributeTag tells the catalog service that the attribute is an RString,
binary, or a RecordID.
}
{
DeleteAttributeType:
This call is provided so that an existing AttributeType can be deleted.
If any attribute values exist for this type, they will all be deleted
(if the user has access rights to delete the values) and then the attribute type
will be deleted. Otherwise dsAccessDenied error will be returned.
}
	DirDeleteAttributeTypePBPtr = ^DirDeleteAttributeTypePB;
	DirDeleteAttributeTypePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   -->  }
		attrType:				AttributeTypePtr;						{   -->  }
	END;

{
    DeleteAttributeValue
}
	DirDeleteAttributeValuePBPtr = ^DirDeleteAttributeValuePB;
	DirDeleteAttributeValuePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   ->  }
		attr:					AttributePtr;							{   ->  }
	END;



{
    ChangeAttributeValue:
    currentAttr ==> the attribute to be changed. For ADAS and PAB CreationID is
                    sufficient
    newAttr     ==> new value for the attribute. For ADAS and PAB 
                    CreationID field will be set when
                    the call succeesfully completes
    
    aRecord     ==> must contain valid PackedRecordLocationInfo and a CreationID.


    
}
	DirChangeAttributeValuePBPtr = ^DirChangeAttributeValuePB;
	DirChangeAttributeValuePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   ->  }
		currentAttr:			AttributePtr;							{   ->  }
		newAttr:				AttributePtr;							{   ->  }
	END;


{ VerifyAttributeValue }
	DirVerifyAttributeValuePBPtr = ^DirVerifyAttributeValuePB;
	DirVerifyAttributeValuePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   -->  }
		attr:					AttributePtr;							{   -->  }
	END;

{
aRecord must contain valid PackedRLI and a CreationID.

The attribute type and value are passed in the attribute structure.  If the
attribute CreationID is non-zero, the server will verify that an attribute with
the specified value and creation number exists in aRecord.  If the attribute
CreationID is zero, the server will verify the attribute by type and value
alone, and return the attribute CreationID in the Attribute struct if the
attribute exists.
}

{
EnumerateAttributeTypesGet:
The following two calls can be used to enumerate the attribute types present in
a specified RecordID.  The first, EnumerateAttributeTypesGet, processes the request
and reads the response into getBuffer, as much as will fit.  A kOCEMoreData error will
be returned if the buffer was not large enough.  After this call completes, the
client can call EnumerateAttributeTypesParse (see below).

The user will able to continue from a startingPoint by setting a startingAttrType.
Typically, this should be the last value returned in EnumerateAttributeTypesParse call
when 'kOCEMoreData' is returned.

If 'includeStartingPoint' is true when a 'startingAttrType' is specified, the starting value
will be included in the results, if it exists. If this is set to false, this value will not
be included. AttributeTypes following this type will be returned.
}
	DirEnumerateAttributeTypesGetPBPtr = ^DirEnumerateAttributeTypesGetPB;
	DirEnumerateAttributeTypesGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   -->  }
		startingAttrType:		AttributeTypePtr;						{   --> starting point  }
		cReserved:				LONGINT;								{   --   }
		dReserved:				LONGINT;								{   --   }
		eReserved:				LONGINT;								{   --   }
		fReserved:				LONGINT;								{   --   }
		gReserved:				LONGINT;								{   --   }
		hReserved:				LONGINT;								{   --   }
		includeStartingPoint:	BOOLEAN;								{   --> if true return the attrType specified by starting point  }
		padByte:				SInt8;
		i1Reserved:				INTEGER;								{   --   }
		getBuffer:				Ptr;									{   -->  }
		getBufferSize:			UInt32;									{   -->  }
	END;

{ The call-back function is defined as follows: }
{$IFC TYPED_FUNCTION_POINTERS}
	ForEachAttrTypeProcPtr = FUNCTION(clientData: LONGINT; {CONST}VAR attrType: AttributeType): BOOLEAN;
{$ELSEC}
	ForEachAttrTypeProcPtr = ProcPtr;
{$ENDC}

	ForEachAttrTypeUPP = UniversalProcPtr;
	ForEachAttrType						= ForEachAttrTypeUPP;
{
EnumerateAttributeTypesParse:
After an EnumerateAttributeTypesGet call has completed, call EnumerateAttributeTypesParse
to parse through the buffer that was filled in EnumerateAttributeTypesGet.  The
toolbox will parse through the buffer and call the call-back routine for
each attribute type in the getBuffer.

The client should return false from eachAttrType to continue
processing of the EnumerateAttributeTypesParse request.  Returning true will
terminate the EnumerateAttributeTypesParse request.  The clientData parameter that
you pass in the parameter block will be passed to eachAttrType.
You are free to put anything in clientData - it is intended to allow
you some way to match the call-back to the original call (in case, for
example, you make simultaneous asynchronous calls).

For synchronous calls, the call-back routine actually runs as part of the same thread
of execution as the thread that made the EnumerateAttributeTypesParse call.  That means that the
same low-memory globals, A5, stack, etc. are in effect during the call-back
that were in effect when the call was made.  Because of this, the call-back
routine has the same restrictions as the caller of EnumerateAttributeTypesParse.
If EnumerateAttributeTypesParse was not called from interrupt level, then the call-
back routine can allocate memory. For asynchronous calls, call-back routine is
like a ioCompletion except that A5 will be preserved for the application.
}
	DirEnumerateAttributeTypesParsePBPtr = ^DirEnumerateAttributeTypesParsePB;
	DirEnumerateAttributeTypesParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   --> Same as DirEnumerateAttributeTypesGetPB  }
		bReserved:				LONGINT;								{   --   }
		cReserved:				LONGINT;								{   --   }
		dReserved:				LONGINT;								{   --   }
		eachAttrType:			ForEachAttrType;						{   -->  }
		fReserved:				LONGINT;								{   --   }
		gReserved:				LONGINT;								{   --   }
		hReserved:				LONGINT;								{   --   }
		iReserved:				LONGINT;								{   --   }
		getBuffer:				Ptr;									{   -->  }
		getBufferSize:			UInt32;									{   -->  }
	END;

{
DirAbort:
With this call a user will able to abort an outstanding catalog service call.
A user must pass a pointer to the parameter block for the outstanding call.
In the current version of the product, the toolbox will process this call
for NetSearchADAPDirectoriesGet or FindADAPDirectoryByNetSearch calls and if possible
it will abort. For other calls for ADAP and PAB this will return 'daAbortFailErr'.
For CSAM catalogs, this call will be passed to the corresponding CSAM driver.
The CSAM driver may process this call or may return 'daAbortFailErr'. This call can
be called only in synchronous mode. Since the abort call makes references to fields in
the pb associated with the original call, this pb must not be disposed or or altered if
the original call completes before the abort call has completed.
}
	DirAbortPBPtr = ^DirAbortPB;
	DirAbortPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		pb:						DirParamBlockPtr;						{   --> pb for the call which must be aborted  }
	END;


{
AddPseudonym:
An alternate name and type can be added to a given record. If allowDuplicate
is set the name and type will be added even if the same name and type already
exists.
}
	DirAddPseudonymPBPtr = ^DirAddPseudonymPB;
	DirAddPseudonymPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   --> RecordID to which pseudonym is to be added  }
		pseudonymName:			RStringPtr;								{   --> new name to be added as pseudonym  }
		pseudonymType:			RStringPtr;								{   --> new name to be added as pseudonym  }
		allowDuplicate:			BOOLEAN;								{   -->  }
		filler1:				BOOLEAN;
	END;

{
DeletePseudonym:
An alternate name and type for a given record can be deleted.
}
	DirDeletePseudonymPBPtr = ^DirDeletePseudonymPB;
	DirDeletePseudonymPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   --> RecordID to which pseudonym to be added  }
		pseudonymName:			RStringPtr;								{   --> pseudonymName to be deleted  }
		pseudonymType:			RStringPtr;								{   --> pseudonymType to be deleted  }
	END;


{
    AddAlias:
    This call can be used to create an alias  record. The alias
    can be created either in the same or different cluster. ADAS will not support
    this call for this release. A new catalog capability flag 'kSupportsAlias' will indicate
    if the catalog supports this call. PAB's will support this call. For the PAB implementation,
    this call will create a record with the name and type specified an aRecord.
    This call works exactly like AddRecord.
    If 'allowDuplicate' is false and another record with same name and type already exists
    'daNoDupAllowed' error will be returned.
}
	DirAddAliasPBPtr = ^DirAddAliasPB;
	DirAddAliasPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   ->  }
		allowDuplicate:			BOOLEAN;								{   ->  }
		filler1:				BOOLEAN;
	END;

{
DirFindValue:
This call can be used to find the occurrence of a value. The value
to be matched is passed in the buffer 'matchingData' field. The current
ADAP/PAB implementation will match a maximum of 32 bytes of data.
For attribute values in the PAB/ADAP implementation, only the first 32 bytes will
be used for comparing the occurrence of data. Search can be restricted to
a particular record and/or attribute type by specifying 'aRecord' or 'aType'.
After finding one occurrence, 'startingRecord' and 'startingAttribute'
can be specified to find the next occurrence of the same value.
'sortDirection' can be specified with starting values to search forward or backward.
When a matching value is found, the 'recordFound' indicates the reccordID in which the
data occurrence was found, 'attributeFound' indicates the attribute with in which the
matching data was found. ADAP/PAB implementation returns only the type and creationID of
attributes. Catalogs which don't support creationIDs may return the
complete value; hence this call may need a buffer to hold the data. For ADAP/PAB implementations
the user has to make a DirLookup call to get the actual data. 'recordFound' and
'attributeFound' can be used to initialize 'startingRecord' and 'startingAttribute' to
find the next occurrence of the value.
}
	DirFindValuePBPtr = ^DirFindValuePB;
	DirFindValuePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRLI:					PackedRLIPtr;							{   --> an RLI specifying the cluster to be enumerated  }
		aRecord:				LocalRecordIDPtr;						{   --> if not nil, look only in this record  }
		attrType:				AttributeTypePtr;						{   --> if not nil, look only in this attribute type  }
		startingRecord:			LocalRecordIDPtr;						{   --> record in which to start searching  }
		startingAttribute:		AttributePtr;							{   --> attribute in which to start searching  }
		recordFound:			LocalRecordIDPtr;						{  <--  record in which data was found  }
		attributeFound:			Attribute;								{  <--  attribute in which data was found  }
		matchSize:				UInt32;									{   --> length of matching bytes  }
		matchingData:			Ptr;									{   --> data bytes to be matched in search  }
		sortDirection:			DirSortDirection;						{   --> sort direction (forwards or backwards)  }
	END;



{
EnumeratePseudonymGet:
This call can be used to enumerate the existing pseudonyms for
a given record specified in 'aRecord'. A starting point can be specified
by 'startingName' and 'startingType'. If the 'includeStartingPoint' boolean
is true and a starting point is specified, the name specified by startingName
and startingType also is returned in the results, if it exists. If this is set to false,
the pseudonym in startingName and Type is not included.
Pseudonyms returned in the 'getBuffer' can be extracted by making an
EnumeratePseudonymParse call. The results will consist of a RecordID with the
name and type of the pseudonym. If the buffer could not hold all the results, then
'kOCEMoreData' error will be returned. The user will be able to continue the call by
using the last result returned as starting point for the next call.
}
	DirEnumeratePseudonymGetPBPtr = ^DirEnumeratePseudonymGetPB;
	DirEnumeratePseudonymGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   -->  }
		startingName:			RStringPtr;								{   -->  }
		startingType:			RStringPtr;								{   -->  }
		dReserved:				LONGINT;								{   --   }
		eReserved:				LONGINT;								{   --   }
		fReserved:				LONGINT;								{   --   }
		gReserved:				LONGINT;								{   --   }
		hReserved:				LONGINT;								{   --   }
		includeStartingPoint:	BOOLEAN;								{   --> if true return the Pseudonym specified by starting point will be included  }
		padByte:				SInt8;
		i1Reserved:				INTEGER;								{   --   }
		getBuffer:				Ptr;									{   -->  }
		getBufferSize:			UInt32;									{   -->  }
	END;

{ The call-back function is defined as follows: }
{$IFC TYPED_FUNCTION_POINTERS}
	ForEachRecordIDProcPtr = FUNCTION(clientData: LONGINT; {CONST}VAR recordID: RecordID): BOOLEAN;
{$ELSEC}
	ForEachRecordIDProcPtr = ProcPtr;
{$ENDC}

	ForEachRecordIDUPP = UniversalProcPtr;
	ForEachRecordID						= ForEachRecordIDUPP;
{
EnumeratePseudonymParse:
The pseudonyms returned in the 'getBuffer' from the EnumeratePseudonymGet call
can be extracted by using the EnumeratePseudonymParse call. 'eachRecordID'
will be called for each pseudonym.

Returning true from any call-back will terminate the EnumeratePseudonymParse call.

For synchronous calls, the call-back routine actually runs as part of the same thread
of execution as the thread that made the EnumeratePseudonymParse call.  That means that the
same low-memory globals, A5, stack, etc. are in effect during the call-back
that were in effect when the call was made.  Because of this, the call-back
routine has the same restrictions as the caller of EnumeratePseudonymParse:
if EnumeratePseudonymParse was not called from interrupt level, then the call-
back routine can allocate memory. For asynchronous calls, call-back routine is
like a ioCompletion except that A5 will be preserved for the application.
}
	DirEnumeratePseudonymParsePBPtr = ^DirEnumeratePseudonymParsePB;
	DirEnumeratePseudonymParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   --> same as DirEnumerateAliasesGetPB  }
		bReserved:				LONGINT;								{   --   }
		cReserved:				LONGINT;								{   --   }
		eachRecordID:			ForEachRecordID;						{   -->  }
		eReserved:				LONGINT;								{   --   }
		fReserved:				LONGINT;								{   --   }
		gReserved:				LONGINT;								{   --   }
		hReserved:				LONGINT;								{   --   }
		iReserved:				LONGINT;								{   --   }
		getBuffer:				Ptr;									{   -->  }
		getBufferSize:			UInt32;									{   -->  }
	END;



{ GetNameAndType }
	DirGetNameAndTypePBPtr = ^DirGetNameAndTypePB;
	DirGetNameAndTypePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   -->  }
	END;

{
aRecord must contain valid RLI and a CreationID.  It
must also contain pointers to maximum-length RStrings (name and type fields)
in which will be returned the record's distinguished name and type.
}

{
SetNameAndType:
This call can be used to change a name and type for a record. The record
to be renamed is specified using 'aRecord'.
'newName' and 'newType' indicate the name and type to be set.
'allowDuplicate' if true indicates that name is to be set even if another
name and type exactly matches the newName and newType specified.

'newName' and 'newType' are required since the catalogs not supporting
CreationID require name and type fields in the recordID to identify a given
record.
}
	DirSetNameAndTypePBPtr = ^DirSetNameAndTypePB;
	DirSetNameAndTypePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   -->  }
		allowDuplicate:			BOOLEAN;								{   -->  }
		padByte:				SInt8;
		newName:				RStringPtr;								{   --> new name for the record  }
		newType:				RStringPtr;								{   --> new type for the record  }
	END;




{
DirGetMetaRecordInfo: This call can be made to obtain
the MetaRecordInfo for a given record. Information returned
is 16 bytes of OPAQUE information about the record.
}
	DirGetRecordMetaInfoPBPtr = ^DirGetRecordMetaInfoPB;
	DirGetRecordMetaInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   -->  }
		metaInfo:				DirMetaInfo;							{  <--   }
	END;


{
DirGetDNodeMetaInfo: This call can be made to obtain
the DNodeMetaInfo for a given Packed RLI. Information returned
is 16 bytes of OPAQUE information about the DNode.
}
	DirGetDNodeMetaInfoPBPtr = ^DirGetDNodeMetaInfoPB;
	DirGetDNodeMetaInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		pRLI:					PackedRLIPtr;							{   -->  }
		metaInfo:				DirMetaInfo;							{  <--   }
	END;


{
EnumerateDirectoriesGet:
A user can enumerate all the catalogs installed. This includes installed
ADAP and CSAM catalogs. The user can specify a signature as input to restrict
the results. kDirADAPKind will return only ADAP catalogs, kDirDSAMKind
will return all CSAM catalogs. kDirAllKinds will get both ADAP & CSAM catalogs.
A specific signature (e.g. X.500) may be used to get catalogs with an X.500 signature.
The information for each catalog returned will have directoryName, discriminator and features.

If the user receives 'noErr' or 'kOCEMoreData', the buffer will contain valid results. A user
can extract the results in the 'getBuffer' by making an DirEnumerateDirectories call.

If 'kOCEMoreData' is received, the user can continue enumeration by using the last catalog and
discriminator as startingDirectoryName and staringDirDiscriminator in the next call.

If 'includeStartingPoint' is true and a starting point is specified,
the staring point will be returned in the result. If false, it is not included.
}
	DirEnumerateDirectoriesGetPBPtr = ^DirEnumerateDirectoriesGetPB;
	DirEnumerateDirectoriesGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryKind:			OCEDirectoryKind;						{   --> enumerate catalogs bearing this signature  }
		startingDirectoryName:	DirectoryNamePtr;						{   --> staring catalog name  }
		startingDirDiscriminator: DirDiscriminator;						{   --> staring catalog discriminator  }
		eReserved:				LONGINT;								{   --   }
		fReserved:				LONGINT;								{   --   }
		gReserved:				LONGINT;								{   --   }
		hReserved:				LONGINT;								{   --   }
		includeStartingPoint:	BOOLEAN;								{   --> if true return the catalog specified by starting point  }
		padByte:				SInt8;
		i1Reserved:				INTEGER;								{   --   }
		getBuffer:				Ptr;									{   -->  }
		getBufferSize:			UInt32;									{   -->  }
	END;



{$IFC TYPED_FUNCTION_POINTERS}
	ForEachDirectoryProcPtr = FUNCTION(clientData: LONGINT; {CONST}VAR dirName: DirectoryName; {CONST}VAR discriminator: DirDiscriminator; features: DirGestalt): BOOLEAN;
{$ELSEC}
	ForEachDirectoryProcPtr = ProcPtr;
{$ENDC}

	ForEachDirectoryUPP = UniversalProcPtr;
	ForEachDirectory					= ForEachDirectoryUPP;
{
EnumerateDirectoriesParse:
The catalog info returned in 'getBuffer' from the EnumerateDirectoriesGet call
can be extracted using the EnumerateDirectoriesParse call. 'eachDirectory' will
be called for each catalog.

Returning true from any call-back will terminate the EnumerateDirectoriesParse call.

For synchronous calls, the call-back routine actually runs as part of the same thread
of execution as the thread that made the EnumerateDirectoriesParse call.  That means that the
same low-memory globals, A5, stack, etc. are in effect during the call-back
that were in effect when the call was made.  Because of this, the call-back
routine has the same restrictions as the caller of EnumerateDirectoriesParse:
if EnumerateDirectoriesParse was not called from interrupt level, then the call-
back routine can allocate memory. For asynchronous calls, call-back routine is
like a ioCompletion except that A5 will be preserved for the application.

eachDirectory will be called each time to return to the client a
DirectoryName, DirDiscriminator, and features for that catalog.
}
	DirEnumerateDirectoriesParsePBPtr = ^DirEnumerateDirectoriesParsePB;
	DirEnumerateDirectoriesParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aReserved:				LONGINT;								{   --   }
		bReserved:				LONGINT;								{   --   }
		cReserved:				LONGINT;								{   --   }
		dReserved:				LONGINT;								{   --   }
		eachDirectory:			ForEachDirectory;						{   -->  }
		fReserved:				LONGINT;								{   --   }
		gReserved:				LONGINT;								{   --   }
		hReserved:				LONGINT;								{   --   }
		iReserved:				LONGINT;								{   --   }
		getBuffer:				Ptr;									{   -->  }
		getBufferSize:			UInt32;									{   -->  }
	END;


{
The Following five call are specific to ADAP Catalogs. Toolbox
remembers a list of catalogs across boots. If any catalog service
call is intended for a ADAP catalog, then it must be in the list.
In order for managing this list, A client (Probably DE will use these
calls.
DirAddADAPDirectoryPB: Add a new ADAP catalog to the list.
DirRemoveADAPDirectory: Remove a ADAP catalog from the list.
DirNetSearchADAPDirectoriesGet:   search an internet for adas catalogs.
DirNetSearchADAPDirectoriesParse: extract the results obtained NetSearchADAPDirectoriesGet.
DirFindADAPDirectoryByNetSearch: Find a specified catalog through net search.
}
{
NetSearchADAPDirectoriesGet:
This call can be used to make a network wide search for finding ADAP catalogs.
This call will be supported only by 'ADAP' and involve highly expensive
network operations, so the user is advised to use utmost discretion before
making this call. The results will be collected in the 'getbuffer' and can be
extracted using NetSearchADAPDirectoriesParse call. The directoryName,
the directoryDiscriminator, features and serverHint (AppleTalk address for
a PathFinder serving that catalog) are collected for each catalog found
on the network. If buffer is too small to hold all the catalogs found on
the network, a 'kOCEMoreData' error will be returned.
}
	DirNetSearchADAPDirectoriesGetPBPtr = ^DirNetSearchADAPDirectoriesGetPB;
	DirNetSearchADAPDirectoriesGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		getBuffer:				Ptr;									{   -->  }
		getBufferSize:			UInt32;									{   -->  }
		cReserved:				LONGINT;								{   --   }
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	ForEachADAPDirectoryProcPtr = FUNCTION(clientData: LONGINT; {CONST}VAR dirName: DirectoryName; {CONST}VAR discriminator: DirDiscriminator; features: DirGestalt; serverHint: AddrBlock): BOOLEAN;
{$ELSEC}
	ForEachADAPDirectoryProcPtr = ProcPtr;
{$ENDC}

	ForEachADAPDirectoryUPP = UniversalProcPtr;
	ForEachADAPDirectory				= ForEachADAPDirectoryUPP;
{
DirNetSearchADAPDirectoriesParse:
This call can be used to extract the results obtained in the 'getBuffer'.
The directoryName, directoryDiscriminator, features and
serverHint (AppleTalk address for a PathFinder serving that catalog) are
returned in each call-back. These values may be used to make an
AddADAPDirectory call.

Returning TRUE from any call-back will terminate the NetSearchADAPDirectoriesParse request.

For synchronous calls, the call-back routine actually runs as part of the same thread
of execution as the thread that made the DirNetSearchADAPDirectoriesParse call. That means that the
same low-memory globals, A5, stack, etc. are in effect during the call-back
that were in effect when the call was made.  Because of this, the call-back
routine has the same restrictions as the caller of DirNetSearchADAPDirectoriesParse:
if DirNetSearchADAPDirectoriesParse was not called from interrupt level, then the call-
back routine can allocate memory. For asynchronous calls, call-back routine is
like a ioCompletion except that A5 will be preserved for the application.
}
	DirNetSearchADAPDirectoriesParsePBPtr = ^DirNetSearchADAPDirectoriesParsePB;
	DirNetSearchADAPDirectoriesParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		getBuffer:				Ptr;									{   -->  }
		getBufferSize:			UInt32;									{   -->  }
		eachADAPDirectory:		ForEachADAPDirectory;					{   -->  }
	END;

{
DirFindADAPDirectoryByNetSearch:
This call can be used to make a network wide search to find an ADAP catalog.
This call will be supported only by 'ADAP' and involves highly expensive
network operations, so the user is advised to use utmost discretion before
making this call. The catalog is specified using directoryName and discriminator.
If 'addToOCESetup' is true, the catalog will be automatically added to the setup
list and will be visible through the EnumerateDirectories call and also
also a creationID to the directoryRecord will be returned.
If this parameter is set to 'false', the catalog will be added to temporary list
and will be available for making other catalog service calls. The catalogs
which are not in the preference catalog list will not be visible through the
EnumerateDirectories call.
}
	DirFindADAPDirectoryByNetSearchPBPtr = ^DirFindADAPDirectoryByNetSearchPB;
	DirFindADAPDirectoryByNetSearchPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryName:			DirectoryNamePtr;						{   --> catalog name  }
		discriminator:			DirDiscriminator;						{   --> discriminate between dup catalog names  }
		addToOCESetup:			BOOLEAN;								{   --> add this catalog to OCE Setup List  }
		padByte:				SInt8;
		directoryRecordCID:		CreationID;								{  <--  creationID for the catalog record  }
	END;


{
DirAddADAPDirectory:
The catalog specified by 'directoryName' and 'discriminator' will be
added to the list of catalogs maintained by the Toolbox. Once added,
the catalog is available across boots, until the catalog is removed
explicitly through a DirRemoveADAPDirectory call.
If 'serverHint' is not nil, the address provided will be used
to contact a PathFinder for the catalog specified.
If 'serverHint' is nil or does not point to a valid PathFinder server
for that catalog, this call will fail.
If 'addToOCESetup' is true, the catalog will be automatically added to the setup
catalog list and will be visible through EnumerateDirectories calls and
also a creationID to the directoryRecord will be returned.
If this parameter is set to 'false', catalog will be added to temprary list
and will be available for making other catalog service calls. The catalogs
which are not in the setup  list will not be visible through
EnumerateDirectories call.
}
	DirAddADAPDirectoryPBPtr = ^DirAddADAPDirectoryPB;
	DirAddADAPDirectoryPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryName:			DirectoryNamePtr;						{   --> catalog name  }
		discriminator:			DirDiscriminator;						{   --> discriminate between dup catalog names  }
		addToOCESetup:			BOOLEAN;								{   --> add this catalog to OCE Setup  }
		padByte:				SInt8;
		directoryRecordCID:		CreationID;								{  <--  creationID for the catalog record  }
	END;



{
GetDirectoryInfo:
DirGetDirectoryInfo will do:

If a 'dsRefNum' is non-Zero, the catalog information for
    the corresponding  PAB will be  returned.
 If 'dsRefNum' is zero and 'serverHint' is non-zero, If the
 'serverHint' points to a valid ADAP Catalog Server(Path Finder),
 the catalog information (i.e. directoryName, discriminator, features)
 for that catalog will be returned.
    If a  valid catalog name and discriminator are provided
    features (Set of capability flags) for that catalog will be returned.
}
	DirGetDirectoryInfoPBPtr = ^DirGetDirectoryInfoPB;
	DirGetDirectoryInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryName:			DirectoryNamePtr;						{   --> catalog name  }
		discriminator:			DirDiscriminator;						{  <--> descriminate between dup catalog names  }
		features:				DirGestalt;								{  <--  capability bit flags  }
	END;


{
 * Note on Access Controls:
 * Access control is based on a list model.
 * You can get access controls list which gives dsObject and accMask for each dsObject.
 * GetAccessControl can be limited to currently supplied identity by setting forCurrentUserOnly.
 * There are special DSObjects are defined in ADASTypes.h for each of the category
 * supported in ADAS Catalogs. (kOwner, kFriends, kAuthenticatedToCluster, 
 * kAuthenticatedToDirectory, kGuest) and DUGetActlDSSpec call can be used
 * to obtain appropraiate DSSpec before making set calls to ADAS catalogs.
 *
 }





{
    GetDNodeAccessControlGet:
    This call can be done to get back access control list for a DNode.
    pRLI -> RLI of the DNode whose access control list is sought
    curUserAccMask -> If this is 'true', Access controls for the user specified by
                      the identity parameter will be returned other wise entire list
                      will be returned.
    startingDsObj  -> If this is not nil, list should be started after this object.
    startingPointInclusive -> If staringDsObj is specified, include that in the returned
                              results.
                              
    The results will be collected in the 'getBuffer' supplied by the user.
    If buffer can not hold all the data returned 'daMoreData' error will be returned.
     
    If user receives 'noErr' or 'daMoreData', buffer will contain valid results. A user
    can extract the results in the 'getBuffer' by making 'DsGetDNodeAccessControlParse' call.
    
    Results returned for each DSObject will contain DSSpecPtr and three sets of access mask. 

}

	DirGetDNodeAccessControlGetPBPtr = ^DirGetDNodeAccessControlGetPB;
	DirGetDNodeAccessControlGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		pRLI:					PackedRLIPtr;							{   -> RLI of the cluster whose access control list is sought   }
		bReserved:				LONGINT;								{   -- unused  }
		cReserved:				LONGINT;								{   -- unused  }
		dReserved:				LONGINT;								{   -- unused  }
		eResreved:				LONGINT;								{  -->  }
		forCurrentUserOnly:		BOOLEAN;								{  -->   }
		filler1:				BOOLEAN;
		startingPoint:			DSSpecPtr;								{  --> starting Point  }
		includeStartingPoint:	BOOLEAN;								{  --> if true return the DsObject specified in starting point  }
		filler2:				BOOLEAN;
		getBuffer:				Ptr;									{     ->  }
		getBufferSize:			UInt32;									{   ->  }
	END;

{ The Access Control call-back function is defined as follows: }
{$IFC TYPED_FUNCTION_POINTERS}
	ForEachDNodeAccessControlProcPtr = FUNCTION(clientData: LONGINT; {CONST}VAR dsObj: DSSpec; activeDnodeAccMask: AccessMask; defaultRecordAccMask: AccessMask; defaultAttributeAccMask: AccessMask): BOOLEAN;
{$ELSEC}
	ForEachDNodeAccessControlProcPtr = ProcPtr;
{$ENDC}

	ForEachDNodeAccessControlUPP = UniversalProcPtr;
	ForEachDNodeAccessControl			= ForEachDNodeAccessControlUPP;
{
    GetDNodeAccessControlParse:
    After an GetDNodeAccessControlGet call has completed, 
    call GetDNodeAccessControlParse to parse through the buffer that
    that was filled in GetDNodeAccessControlGet.
    
    'eachObject' will be called each time to return to the client a
    DsObject and a set of three accMasks (three long words) for that object.
    Acceesmasks returned apply to the dsObject in the callback :
    1. Currently Active Access mask for the specified DNode.
    2. Default Access mask for any Record in the DNode
    3. Default Access mask for any Attribute in the DNode
    The clientData parameter that you pass in the parameter block will be passed
    to 'eachObject'.  You are free to put anything in clientData - it is intended
    to allow you some way to match the call-back to the original call (for
    example, you make more then one aysynchronous GetDNodeAccessControlGet calls and you want to
    associate returned results in some way).
    
    The client should return FALSE from 'eachObject' to continue
    processing of the GetDNodeAccessControlParse request.  Returning TRUE will
    terminate the GetDNodeAccessControlParse request.

    For synchronous calls, the call-back routine actually runs as part of the same thread 
    of execution as the thread that made the GetDNodeAccessControlParse call.  That means that the
    same low-memory globals, A5, stack, etc. are in effect during the call-back
    that were in effect when the call was made.  Because of this, the call-back
    routine has the same restrictions as the caller of GetDNodeAccessControlParse:
    if GetDNodeAccessControlParse was not called from interrupt level, then the call-
    back routine can allocate memory. For asynchronous calls, call-back routine is
    like a ioCompletion except that A5 will be preserved for the application.


}

	DirGetDNodeAccessControlParsePBPtr = ^DirGetDNodeAccessControlParsePB;
	DirGetDNodeAccessControlParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		pRLI:					PackedRLIPtr;							{   -> RLI of the cluster   }
		bReserved:				LONGINT;								{   -- unused  }
		cReserved:				LONGINT;								{   -- unused  }
		dReserved:				LONGINT;								{   -- unused  }
		eachObject:				ForEachDNodeAccessControl;				{  -->  }
		forCurrentUserOnly:		BOOLEAN;								{  -->   }
		filler1:				BOOLEAN;
		startingPoint:			DSSpecPtr;								{  --> starting Point  }
		includeStartingPoint:	BOOLEAN;								{  --> if true return the record specified in starting point  }
		filler2:				BOOLEAN;
		getBuffer:				Ptr;									{     ->  }
		getBufferSize:			UInt32;									{   ->  }
	END;

{
    GetRecordAccessControlGet:
    This call can be done to get back access control list for a RecordID.
    aRecord -> RecordID to which access control list is sought
    curUserAccMask -> If this is 'true', Access controls for the user specified by
                      the identity parameter will be returned other wise entire list
                      will be returned.
    startingDsObj  -> If this is not nil, list should be started after this object.
    startingPointInclusive -> If staringDsObj is specified, include that in the returned
                              results.
                              
    The results will be collected in the 'getBuffer' supplied by the user.
    If buffer can not hold all the data returned 'daMoreData' error will be returned.
     
    If user receives 'noErr' or 'daMoreData', buffer will contain valid results. A user
    can extract the results in the 'getBuffer' by making 'DsGetDNodeAccessControlParse' call.
    
    Results returned for each DSObject will contain DSSpecPtr and accMask. 

}

	DirGetRecordAccessControlGetPBPtr = ^DirGetRecordAccessControlGetPB;
	DirGetRecordAccessControlGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   -> RecordID to which access control list is sought list is sought   }
		bReserved:				LONGINT;								{   -- unused  }
		cReserved:				LONGINT;								{   -- unused  }
		dReserved:				LONGINT;								{   -- unused  }
		eResreved:				LONGINT;								{  -->  }
		forCurrentUserOnly:		BOOLEAN;								{  -->   }
		filler1:				BOOLEAN;
		startingPoint:			DSSpecPtr;								{  --> starting Point  }
		includeStartingPoint:	BOOLEAN;								{  --> if true return the record specified in starting point  }
		filler2:				BOOLEAN;
		getBuffer:				Ptr;									{     ->  }
		getBufferSize:			UInt32;									{   ->  }
	END;

{ The Access Control call-back function is defined as follows: }
{$IFC TYPED_FUNCTION_POINTERS}
	ForEachRecordAccessControlProcPtr = FUNCTION(clientData: LONGINT; {CONST}VAR dsObj: DSSpec; activeDnodeAccMask: AccessMask; activeRecordAccMask: AccessMask; defaultAttributeAccMask: AccessMask): BOOLEAN;
{$ELSEC}
	ForEachRecordAccessControlProcPtr = ProcPtr;
{$ENDC}

	ForEachRecordAccessControlUPP = UniversalProcPtr;
	ForEachRecordAccessControl			= ForEachRecordAccessControlUPP;
{
    GetRecordAccessControlParse:
    After an GetRecordAccessControlGet call has completed, 
    call GetRecordAccessControlParse to parse through the buffer that
    that was filled in GetRecordAccessControlGet.
    
    'eachObject' will be called each time to return to the client a
    DsObject and a set of three accMasks (three long words) for that object.
    Acceesmasks returned apply to the dsObject in the callback :
    1. Active Access mask for the DNode Containing the Record.
    2. Active Access mask for the Record specified.
    3. Defualt Access mask for Attributes in the record.
    The clientData parameter that you pass in the parameter block will be passed
    to 'eachObject'.  You are free to put anything in clientData - it is intended
    to allow you some way to match the call-back to the original call (for
    example, you make more then one aysynchronous GetRecordAccessControlGet calls and you want to
    associate returned results in some way).
    
    The client should return FALSE from 'eachObject' to continue
    processing of the GetRecordAccessControlParse request.  Returning TRUE will
    terminate the GetRecordAccessControlParse request.

    For synchronous calls, the call-back routine actually runs as part of the same thread 
    of execution as the thread that made the GetRecordAccessControlParse call.  That means that the
    same low-memory globals, A5, stack, etc. are in effect during the call-back
    that were in effect when the call was made.  Because of this, the call-back
    routine has the same restrictions as the caller of GetRecordAccessControlParse:
    if GetRecordAccessControlParse was not called from interrupt level, then the call-
    back routine can allocate memory. For asynchronous calls, call-back routine is
    like a ioCompletion except that A5 will be preserved for the application.


}

	DirGetRecordAccessControlParsePBPtr = ^DirGetRecordAccessControlParsePB;
	DirGetRecordAccessControlParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   -> RecordID to which access control list is sought list is sought   }
		bReserved:				LONGINT;								{   -- unused  }
		cReserved:				LONGINT;								{   -- unused  }
		dReserved:				LONGINT;								{   -- unused  }
		eachObject:				ForEachRecordAccessControl;				{  -->  }
		forCurrentUserOnly:		BOOLEAN;								{  -->   }
		filler1:				BOOLEAN;
		startingPoint:			DSSpecPtr;								{  --> starting Point  }
		includeStartingPoint:	BOOLEAN;								{  --> if true return the record specified in starting point  }
		filler2:				BOOLEAN;
		getBuffer:				Ptr;									{     ->  }
		getBufferSize:			UInt32;									{   ->  }
	END;

{
    GetAttributeAccessControlGet:
    This call can be done to get back access control list for a attributeType with in a RecordID.
    aRecord -> RecordID to which access control list is sought
    aType   -> Attribute Type to which access controls are sought
    curUserAccMask -> If this is 'true', Access controls for the user specified by
                      the identity parameter will be returned other wise entire list
                      will be returned.
    startingDsObj  -> If this is not nil, list should be started after this object.
    startingPointInclusive -> If staringDsObj is specified, include that in the returned
                              results.
                              
    The results will be collected in the 'getBuffer' supplied by the user.
    If buffer can not hold all the data returned 'daMoreData' error will be returned.
     
    If user receives 'noErr' or 'daMoreData', buffer will contain valid results. A user
    can extract the results in the 'getBuffer' by making 'DsGetDNodeAccessControlParse' call.
    
    Results returned for each DSObject will contain DSSpecPtr and accMask. 

}

	DirGetAttributeAccessControlGetPBPtr = ^DirGetAttributeAccessControlGetPB;
	DirGetAttributeAccessControlGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   -> RecordID to which access control list is sought list is sought   }
		aType:					AttributeTypePtr;						{   -> Attribute Type to which access controls are sought           }
		cReserved:				LONGINT;								{   -- unused  }
		dReserved:				LONGINT;								{   -- unused  }
		eResreved:				LONGINT;								{  -->  }
		forCurrentUserOnly:		BOOLEAN;								{  -->   }
		filler1:				BOOLEAN;
		startingPoint:			DSSpecPtr;								{  --> starting Point  }
		includeStartingPoint:	BOOLEAN;								{  --> if true return the record specified in starting point  }
		filler2:				BOOLEAN;
		getBuffer:				Ptr;									{     ->  }
		getBufferSize:			UInt32;									{   ->  }
	END;

{ The Access Control call-back function is defined as follows: }
{$IFC TYPED_FUNCTION_POINTERS}
	ForEachAttributeAccessControlProcPtr = FUNCTION(clientData: LONGINT; {CONST}VAR dsObj: DSSpec; activeDnodeAccMask: AccessMask; activeRecordAccMask: AccessMask; activeAttributeAccMask: AccessMask): BOOLEAN;
{$ELSEC}
	ForEachAttributeAccessControlProcPtr = ProcPtr;
{$ENDC}

	ForEachAttributeAccessControlUPP = UniversalProcPtr;
	ForEachAttributeAccessControl		= ForEachAttributeAccessControlUPP;
{
    GetAttributeAccessControlParse:
    After an GetAttributeAccessControlGet call has completed, 
    call GetAttributeAccessControlParse to parse through the buffer that
    that was filled in GetAttributeAccessControlGet.
    
    'eachObject' will be called each time to return to the client a
    DsObject and a set of three accMasks (three long words) for that object.
    Acceesmasks returned apply to the dsObject in the callback :
    1. Active Access mask for the DNode Containing the Attribute.
    2. Active Access mask for the Record in the Containing the Attribute.
    3. Active Access mask for the specified Attribute.
    The clientData parameter that you pass in the parameter block will be passed
    to 'eachObject'.  You are free to put anything in clientData - it is intended
    to allow you some way to match the call-back to the original call (for
    example, you make more then one aysynchronous GetAttributeAccessControlGet calls and you want to
    associate returned results in some way).
    
    The client should return FALSE from 'eachObject' to continue
    processing of the GetAttributeAccessControlParse request.  Returning TRUE will
    terminate the GetAttributeAccessControlParse request.

    For synchronous calls, the call-back routine actually runs as part of the same thread 
    of execution as the thread that made the GetAttributeAccessControlParse call.  That means that the
    same low-memory globals, A5, stack, etc. are in effect during the call-back
    that were in effect when the call was made.  Because of this, the call-back
    routine has the same restrictions as the caller of GetAttributeAccessControlParse:
    if GetAttributeAccessControlParse was not called from interrupt level, then the call-
    back routine can allocate memory. For asynchronous calls, call-back routine is
    like a ioCompletion except that A5 will be preserved for the application.


}

	DirGetAttributeAccessControlParsePBPtr = ^DirGetAttributeAccessControlParsePB;
	DirGetAttributeAccessControlParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{   -> RecordID to which access control list is sought list is sought   }
		aType:					AttributeTypePtr;						{   -> Attribute Type to which access controls are sought           }
		cReserved:				LONGINT;								{   -- unused  }
		dReserved:				LONGINT;								{   -- unused  }
		eachObject:				ForEachAttributeAccessControl;			{  -->  }
		forCurrentUserOnly:		BOOLEAN;								{  -->   }
		filler1:				BOOLEAN;
		startingPoint:			DSSpecPtr;								{  --> starting Point  }
		includeStartingPoint:	BOOLEAN;								{  --> if true return the record specified in starting point  }
		filler2:				BOOLEAN;
		getBuffer:				Ptr;									{     ->  }
		getBufferSize:			UInt32;									{   ->  }
	END;






{
MapPathNameToDNodeNumber:
This call maps a given PathName within a catalog to its DNodeNumber.
}
	DirMapPathNameToDNodeNumberPBPtr = ^DirMapPathNameToDNodeNumberPB;
	DirMapPathNameToDNodeNumberPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryName:			DirectoryNamePtr;						{   --> catalog name  }
		discriminator:			DirDiscriminator;						{   --> discriminator  }
		dNodeNumber:			DNodeNum;								{  <--  dNodenumber to the path  }
		path:					PackedPathNamePtr;						{   --> Path Name to be mapped  }
	END;

{
PathName in the path field will be mapped to the cooresponding dNodeNumber and
returned in the DNodeNumber field. directoryName and descriminator Fields are
ignored. DSRefNum is used to identify the catalog.
}


{
MapDNodeNumberToPathName:
This call will map a given DNodeNumber with in a catalog to the
corresponding PathName.
}
	DirMapDNodeNumberToPathNamePBPtr = ^DirMapDNodeNumberToPathNamePB;
	DirMapDNodeNumberToPathNamePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryName:			DirectoryNamePtr;						{   --> catalog name  }
		discriminator:			DirDiscriminator;						{   --> discriminator  }
		dNodeNumber:			DNodeNum;								{   --> dNodenumber to be mapped  }
		path:					PackedPathNamePtr;						{  <--  Packed Path Name returned  }
		lengthOfPathName:		UInt16;									{   --> length of packed pathName structure }
	END;

{
dNodeNumber in the DNodeNumber field will be mapped to the cooresponding
pathName and returned in the PackedPathName field.
lengthOfPathName is to be set the length of pathName structure.
If length of PackedPathName is larger then the lengthOfPathName, kOCEMoreData
OSErr will be returned.
}
{
GetLocalNetworkSpec:
This call will return the Local NetworkSpec. Client should supply
an RString big enough to hold the NetworkSpec.
}
	DirGetLocalNetworkSpecPBPtr = ^DirGetLocalNetworkSpecPB;
	DirGetLocalNetworkSpecPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryName:			DirectoryNamePtr;						{   --> catalog name  }
		discriminator:			DirDiscriminator;						{   --> discriminator  }
		networkSpec:			NetworkSpecPtr;							{  <--  NetworkSpec  }
	END;

{
PathName in the path field must be set to nil. internetName should be large
enough to hold the internetName. InterNetname returned indicates path finder's
local internet (configured by administrator).
}
{
GetDNodeInfo:
This call will return the information (internetName and descriptor)
for the given RLI of a DNode.
}
	DirGetDNodeInfoPBPtr = ^DirGetDNodeInfoPB;
	DirGetDNodeInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		pRLI:					PackedRLIPtr;							{   --> packed RLI whose info is requested  }
		descriptor:				DirNodeKind;							{  <--  dNode descriptor  }
		networkSpec:			NetworkSpecPtr;							{  <--  cluster's networkSpec if kIsCluster  }
	END;

{
If DnodeNumber is set to a non zero value, path should be set to nil.
if DnodeNumber is set to zero, pathName should point to a packed path name.
internetName should be large enough to hold
the internetName. (If the internetName is same as the one got by
GetLocalInternetName call, it indicates cluster is reachable  without
forwarders, --> Tell me if I am wrong)
}

{
DirCreatePersonalDirectory:
A new  personal catalog can be created by specifying an FSSpec for
the file. If a file already exists dupFNErr will be returned. This call is
supported 'synchronous' mode only.
}
	DirCreatePersonalDirectoryPBPtr = ^DirCreatePersonalDirectoryPB;
	DirCreatePersonalDirectoryPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		fsSpec:					FSSpecPtr;								{   --> FSSpec for the Personal Catalog  }
		fdType:					OSType;									{   --> file type for the Personal Catalog  }
		fdCreator:				OSType;									{   --> file creator for the Personal Catalog  }
	END;

{
DirOpenPersonalDirectory:
An existing personal catalog can be opened using this call.
User can specify the personal catalog by FSSpec for the AddressBook file.
'accessRequested' field specifies open permissions. 'fsRdPerm'  & 'fsRdWrPerm'
are the only accepted open modes for the address book.
When the call completes successfully, a dsRefNum will be returned. The 'dsRefNum'
field is in the DSParamBlockHeader. In addittion 'accessGranted' indicates
actual permission with personal catalog is opened and 'features' indicate the capabilty flags
associated with the personal catalog.
This call is supported 'synchronous' mode only.
}

	DirOpenPersonalDirectoryPBPtr = ^DirOpenPersonalDirectoryPB;
	DirOpenPersonalDirectoryPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		fsSpec:					FSSpecPtr;								{   --> Open an existing Personal Catalog  }
		accessRequested:		SInt8;									{   --> Open: permissions Requested(byte) }
		accessGranted:			SInt8;									{   <-- Open: permissions (byte) (Granted) }
		features:				DirGestalt;								{  <--  features for Personal Catalog  }
	END;

{
DirClosePersonalDirectory: This call lets a client close AddressBook opened by DirOpenPersonalDirectory.
The Personal Catalog specified by the 'dsRefNum' will be closed.
This call is supported 'synchronous' mode only.
}
	DirClosePersonalDirectoryPBPtr = ^DirClosePersonalDirectoryPB;
	DirClosePersonalDirectoryPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
	END;


{
DirMakePersonalDirectoryRLI: With this call a client can make an RLI
for a Personal Catalog opened by DirOpenPersonalDirectory Call.
A packed RLI is created for the Personal Catalog specified by the 'dsRefNum'.
If a client has a need to make the AddressBook reference to persistent
acrross boots it should make use of this call. In the current implementaion
PackedRLI has an embeeded System7.0 'alias'. If in later time
If client has a need to make reference to the AddressBook, it must use
ADAPLibrary call 'DUExtractAlias' and resole the 'alias' to 'FSSpec' and
make DirOpenPersonalDirectory call to get a 'dsRefNum'.
  'fromFSSpec'          FSPecPtr from which relative alias to be created. If nil,
                        absolute alias is created.
 'pRLIBufferSize' indicates the size of buffer pointed by 'pRLI'
 'pRLISize' indicates the actual length of 'pRLI'. If the call
                        fails with 'kOCEMoreData' error a client can reissue
                    this call with a larger buffer of this length.
  'pRLI' is pointer to the buffer in which 'PackedRLI' is
  returned.
This call is supported in 'synchronous' mode only.
}
	DirMakePersonalDirectoryRLIPBPtr = ^DirMakePersonalDirectoryRLIPB;
	DirMakePersonalDirectoryRLIPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		fromFSSpec:				FSSpecPtr;								{   --> FSSpec for creating relative alia  }
		pRLIBufferSize:			UInt16;									{   --> Length of 'pRLI' buffer  }
		pRLISize:				UInt16;									{  <--  Length of actual 'pRLI'  }
		pRLI:					PackedRLIPtr;							{  <--  pRLI for the specified AddressBook  }
	END;


{****************************************************************************
The calls described below apply only for CSAM Drivers:

The following three calls provide capability to Install/Remove a CSAM at RunTime.
    DirAddDSAM
    DirRemoveDSAM
    DirInstantiateDSAM

The following two calls provide capability to Install/Remove a CSAM Catalog at RunTime.
    DirAddDSAMDirectory
    DirRemoveDirectory

DirGetDirectoryIcon call is used by clients to get any special icon associated
with a CSAM catalog.

****************************************************************************}

{
DirAddDSAM: This call can be used to inorm the availability of a CSAM file
after discovering the CSAM file.
    dsamName -> is generic CSAM name e.g. Untitled X.500 directory
    dsamSignature -> could be generic CSAM kind e.g. 'X500'.
    fsSpec -> is the FileSpec for the file containing CSAM resources.
If the call is successfull 'DSAMRecordCID' will be returned. If the
call returns 'daDSAMRecordCIDExists', record was already there and
'dsamRecordCID' will be returned.
This call can be done only in synchronous mode.
}
	DirAddDSAMPBPtr = ^DirAddDSAMPB;
	DirAddDSAMPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		dsamRecordCID:			CreationID;								{  <--  CreationID for the CSAM record  }
		dsamName:				RStringPtr;								{   --> CSAM name  }
		dsamKind:				OCEDirectoryKind;						{   --> CSAM kind  }
		fsSpec:					FSSpecPtr;								{   --> FSSpec for the file containing CSAM  }
	END;

{
DirInstantiateDSAM: This call should be used by the CSAM driver in response
Driver Open call to indicate the toolbox about the availability of the CSAM.
    dsamName -> is generic CSAM name e.g. Untitled X.500 directory
    dsamKind -> could be generic CSAM kind e.g. 'X500'.
    dsamData -> pointer to private DSAMData. This will be paased back to the CSAM
    when the CSAM functions (DSAMDirProc,DSAMDirParseProc, DSAMAuthProc) are called.
    CSAM should already be setup using DirAddDSAM call.
    DSAMDirProc -> This procedure will be called when  any catalog service
    call intended for the CSAM (other then parse calls)
    DSAMDirParseProc -> This procedure will be called when any of the parse calls
    are called.
    DSAMAuthProc -> This procedure will be called when any of the Authentication Calls
    are made to the CSAM. If the CSAM does not support authentication, this can be nil.
This call can be done only in synchronous mode.
}
{$IFC TYPED_FUNCTION_POINTERS}
	DSAMDirProcPtr = FUNCTION(dsamData: UNIV Ptr; paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
{$ELSEC}
	DSAMDirProcPtr = ProcPtr;
{$ENDC}

	DSAMDirUPP = UniversalProcPtr;
	DSAMDirProc							= DSAMDirUPP;
{$IFC TYPED_FUNCTION_POINTERS}
	DSAMDirParseProcPtr = FUNCTION(dsamData: UNIV Ptr; paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
{$ELSEC}
	DSAMDirParseProcPtr = ProcPtr;
{$ENDC}

	DSAMDirParseUPP = UniversalProcPtr;
	DSAMDirParseProc					= DSAMDirParseUPP;
{$IFC TYPED_FUNCTION_POINTERS}
	DSAMAuthProcPtr = FUNCTION(dsamData: UNIV Ptr; pb: AuthParamBlockPtr; async: BOOLEAN): OSErr;
{$ELSEC}
	DSAMAuthProcPtr = ProcPtr;
{$ENDC}

	DSAMAuthUPP = UniversalProcPtr;
	DSAMAuthProc						= DSAMAuthUPP;
	DirInstantiateDSAMPBPtr = ^DirInstantiateDSAMPB;
	DirInstantiateDSAMPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		dsamName:				RStringPtr;								{   --> dsamName name  }
		dsamKind:				OCEDirectoryKind;						{   --> DSAMKind  }
		dsamData:				Ptr;									{   --> dsamData   }
		dsamDirProc:			DSAMDirUPP;								{   --> of type DSAMDirProc: for catalog service calls  }
		dsamDirParseProc:		DSAMDirParseUPP;						{   --> of type DSAMDirParseProc: for catalog service parse calls  }
		dsamAuthProc:			DSAMAuthUPP;							{   --> of type DSAMAuthProc: for authetication service calls  }
	END;


{
DirRemoveDSAM: This call can be used to remove  a CSAM file from the OCE Setup.
    dsamRecordCID -> is the creationID of the CSAM record.
This call can be made only in synchronous mode.
}
	DirRemoveDSAMPBPtr = ^DirRemoveDSAMPB;
	DirRemoveDSAMPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		dsamRecordCID:			CreationID;								{  <--  CreationID for the CSAM record  }
	END;


{
DirAddDSAMDirectory: This call can be used to inorm the availability of a CSAM catalog.
    dsamRecordCID ->  recordID for the CSAM serving this catalog
    directoryName ->  name of the catalog
    discriminator -> discriminator for the catalog
    directoryRecordCID -> If the call is successful, creationID for the record will
                            be returned.
}
	DirAddDSAMDirectoryPBPtr = ^DirAddDSAMDirectoryPB;
	DirAddDSAMDirectoryPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		dsamRecordCID:			CreationID;								{   --> CreationID for the CSAM record  }
		directoryName:			DirectoryNamePtr;						{   --> catalog name  }
		discriminator:			DirDiscriminator;						{   --> catalog discriminator  }
		features:				DirGestalt;								{   --> capabilty flags for the catalog  }
		directoryRecordCID:		CreationID;								{  <--  creationID for the catalog record  }
	END;

{
DirRemoveDirectory: This call can be used to inform the toolbox that
catalog specified by 'directoryRecordCID'
}
	DirRemoveDirectoryPBPtr = ^DirRemoveDirectoryPB;
	DirRemoveDirectoryPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryRecordCID:		CreationID;								{   --> creationID for the catalog record  }
	END;

{
 * DSGetExtendedDirectoriesInfo::  This call can be used to get
 * the information of various foreign catalogs supported.
 * Typically a DE Template  may make this call to create a
 * Address template or a Gateway may make this call to findout
 * catalog name space in which MSAM may would support. 
 * Client will supply a buffer pointed by 'bufferPtr' of size 'bufferLength'. 
 * When the call completes with 'daMoreData' error, client can examine 'totalEntries'
 * returned and reissue the call with increaing buffer.
 * Toolbox will findout the private information of each of the Foreign Catalogs
 * by polling CSAM's, Gateways, and MnMServers. The Information returned
 * for each catalog will be packed in the format: 
 * typedef struct EachDirectoryData (
 *  PackedRLI                       pRLI;          //  packed RLI for the catalog
 *  OSType                          entnType;      //  Entn Type
 *  long                            hasMailSlot;   //  If this catalog has mail slot this will be 1 otherwise zero
 *  ProtoRString                    RealName;      //  Packed RString for Real Name (padded to even boundary) 
 *  ProtoRString                    comment;       //  Packed RString holding any comment for Display (padded to even boundary)
 *  long                            length;        //  data length
 *  char                            data[length];  //  data padded to even boundary
 * );
 *
 *
 *
 * typedef struct myData (
 *      EachDirectoryData   data[numberOfEntries];    // data packed in the above format
 *  );
 *
 }
	DirGetExtendedDirectoriesInfoPBPtr = ^DirGetExtendedDirectoriesInfoPB;
	DirGetExtendedDirectoriesInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		buffer:					Ptr;									{   --> Pointer to a buufer where data will be returned  }
		bufferSize:				UInt32;									{   --> Length of the buffer, Length of actual data will be returned here  }
		totalEntries:			UInt32;									{  <--  Total Number of Catalogs found  }
		actualEntries:			UInt32;									{  <--  Total Number of Catalogs entries returned  }
	END;

{
DirGetDirectoryIconPB: With this call a client can find out about
the icons supported by the Catalog.
Both ADAP and Personal Catalog will not support this call for now.
A CSAM can support a call so that DE Extension can use this
call to find appropriate Icons.

Returns kOCEBufferTooSmall if icon is too small, but will update iconSize.
}
	DirGetDirectoryIconPBPtr = ^DirGetDirectoryIconPB;
	DirGetDirectoryIconPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		pRLI:					PackedRLIPtr;							{   --> packed RLI for the catalog  }
		iconType:				OSType;									{   --> Type of Icon requested  }
		iconBuffer:				Ptr;									{   --> Buffer to hold Icon Data  }
		bufferSize:				UInt32;									{   <-> size of buffer to hold icon data  }
	END;

{
DirGetOCESetupRefNum: This call will return 'dsRefnum' for the OCE Setup Personal Catalog
and oceSetupRecordCID for the oceSetup Record.
Clients interested in manipulating OCE Setup Personal Catalog directly should
make this call to get 'dsRefNum'.
'dsRefNum' will be returned in the standard field in the DirParamHeader.
}
	DirGetOCESetupRefNumPBPtr = ^DirGetOCESetupRefNumPB;
	DirGetOCESetupRefNumPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					UInt32;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					UInt32;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		oceSetupRecordCID:		CreationID;								{  --> creationID for the catalog record  }
	END;


{***************************************************************************}
{ Catalog and Authentication control blocks and operation definitions }
	AuthParamBlock = RECORD
		CASE INTEGER OF
		0: (
			qLink:				Ptr;
			reserved1:			LONGINT;
			reserved2:			LONGINT;
			ioCompletion:		AuthIOCompletionUPP;
			ioResult:			OSErr;
			saveA5:				UInt32;
			reqCode:			INTEGER;
			reserved:			ARRAY [0..1] OF LONGINT;
			serverHint:			AddrBlock;
			dsRefNum:			INTEGER;
			callID:				UInt32;
			identity:			AuthIdentity;
			gReserved1:			LONGINT;
			gReserved2:			LONGINT;
			gReserved3:			LONGINT;
			clientData:			LONGINT;
		   );
		1: (
			bindIdentityPB:		AuthBindSpecificIdentityPB;
			);
		2: (
			unbindIdentityPB:	AuthUnbindSpecificIdentityPB;
			);
		3: (
			resolveCreationIDPB: AuthResolveCreationIDPB;
			);
		4: (
			getIdentityInfoPB:	AuthGetSpecificIdentityInfoPB;
			);
		5: (
			addKeyPB:			AuthAddKeyPB;
			);
		6: (
			changeKeyPB:		AuthChangeKeyPB;
			);
		7: (
			deleteKeyPB:		AuthDeleteKeyPB;
			);
		8: (
			passwordToKeyPB:	AuthPasswordToKeyPB;
			);
		9: (
			getCredentialsPB:	AuthGetCredentialsPB;
			);
		10: (
			decryptCredentialsPB: AuthDecryptCredentialsPB;
			);
		11: (
			makeChallengePB:	AuthMakeChallengePB;
			);
		12: (
			makeReplyPB:		AuthMakeReplyPB;
			);
		13: (
			verifyReplyPB:		AuthVerifyReplyPB;
			);
		14: (
			getUTCTimePB:		AuthGetUTCTimePB;
			);
		15: (
			makeProxyPB:		AuthMakeProxyPB;
			);
		16: (
			tradeProxyForCredentialsPB: AuthTradeProxyForCredentialsPB;
			);
		17: (
			getLocalIdentityPB:	AuthGetLocalIdentityPB;
			);
		18: (
			unLockLocalIdentityPB: AuthUnlockLocalIdentityPB;
			);
		19: (
			lockLocalIdentityPB: AuthLockLocalIdentityPB;
			);
		20: (
			localIdentityQInstallPB: AuthAddToLocalIdentityQueuePB;
			);
		21: (
			localIdentityQRemovePB: AuthRemoveFromLocalIdentityQueuePB;
			);
		22: (
			setupLocalIdentityPB: AuthSetupLocalIdentityPB;
			);
		23: (
			changeLocalIdentityPB: AuthChangeLocalIdentityPB;
			);
		24: (
			removeLocalIdentityPB: AuthRemoveLocalIdentityPB;
			);
		25: (
			setupDirectoryIdentityPB: OCESetupAddDirectoryInfoPB;
			);
		26: (
			changeDirectoryIdentityPB: OCESetupChangeDirectoryInfoPB;
			);
		27: (
			removeDirectoryIdentityPB: OCESetupRemoveDirectoryInfoPB;
			);
		28: (
			getDirectoryIdentityInfoPB: OCESetupGetDirectoryInfoPB;
			);
	END;

	DirParamBlock = RECORD
		CASE INTEGER OF
		0: (
			qLink:				Ptr;
			reserved1:			LONGINT;
			reserved2:			LONGINT;
			ioCompletion:		DirIOCompletionUPP;
			ioResult:			OSErr;
			saveA5:				UInt32;
			reqCode:			INTEGER;
			reserved:			ARRAY [0..1] OF LONGINT;
			serverHint:			AddrBlock;
			dsRefNum:			INTEGER;
			callID:				UInt32;
			identity:			AuthIdentity;
			gReserved1:			LONGINT;
			gReserved2:			LONGINT;
			gReserved3:			LONGINT;
			clientData:			LONGINT;
		   );
		1: (
			addRecordPB:		DirAddRecordPB;
			);
		2: (
			deleteRecordPB:		DirDeleteRecordPB;
			);
		3: (
			enumerateGetPB:		DirEnumerateGetPB;
			);
		4: (
			enumerateParsePB:	DirEnumerateParsePB;
			);
		5: (
			findRecordGetPB:	DirFindRecordGetPB;
			);
		6: (
			findRecordParsePB:	DirFindRecordParsePB;
			);
		7: (
			lookupGetPB:		DirLookupGetPB;
			);
		8: (
			lookupParsePB:		DirLookupParsePB;
			);
		9: (
			addAttributeValuePB: DirAddAttributeValuePB;
			);
		10: (
			deleteAttributeTypePB: DirDeleteAttributeTypePB;
			);
		11: (
			deleteAttributeValuePB: DirDeleteAttributeValuePB;
			);
		12: (
			changeAttributeValuePB: DirChangeAttributeValuePB;
			);
		13: (
			verifyAttributeValuePB: DirVerifyAttributeValuePB;
			);
		14: (
			findValuePB:		DirFindValuePB;
			);
		15: (
			enumeratePseudonymGetPB: DirEnumeratePseudonymGetPB;
			);
		16: (
			enumeratePseudonymParsePB: DirEnumeratePseudonymParsePB;
			);
		17: (
			addPseudonymPB:		DirAddPseudonymPB;
			);
		18: (
			deletePseudonymPB:	DirDeletePseudonymPB;
			);
		19: (
			addAliasPB:			DirAddAliasPB;
			);
		20: (
			enumerateAttributeTypesGetPB: DirEnumerateAttributeTypesGetPB;
			);
		21: (
			enumerateAttributeTypesParsePB: DirEnumerateAttributeTypesParsePB;
			);
		22: (
			getNameAndTypePB:	DirGetNameAndTypePB;
			);
		23: (
			setNameAndTypePB:	DirSetNameAndTypePB;
			);
		24: (
			getRecordMetaInfoPB: DirGetRecordMetaInfoPB;
			);
		25: (
			getDNodeMetaInfoPB:	DirGetDNodeMetaInfoPB;
			);
		26: (
			getDirectoryInfoPB:	DirGetDirectoryInfoPB;
			);
		27: (
			getDNodeAccessControlGetPB: DirGetDNodeAccessControlGetPB;
			);
		28: (
			getDNodeAccessControlParsePB: DirGetDNodeAccessControlParsePB;
			);
		29: (
			getRecordAccessControlGetPB: DirGetRecordAccessControlGetPB;
			);
		30: (
			getRecordAccessControlParsePB: DirGetRecordAccessControlParsePB;
			);
		31: (
			getAttributeAccessControlGetPB: DirGetAttributeAccessControlGetPB;
			);
		32: (
			getAttributeAccessControlParsePB: DirGetAttributeAccessControlParsePB;
			);
		33: (
			enumerateDirectoriesGetPB: DirEnumerateDirectoriesGetPB;
			);
		34: (
			enumerateDirectoriesParsePB: DirEnumerateDirectoriesParsePB;
			);
		35: (
			addADAPDirectoryPB:	DirAddADAPDirectoryPB;
			);
		36: (
			removeDirectoryPB:	DirRemoveDirectoryPB;
			);
		37: (
			netSearchADAPDirectoriesGetPB: DirNetSearchADAPDirectoriesGetPB;
			);
		38: (
			netSearchADAPDirectoriesParsePB: DirNetSearchADAPDirectoriesParsePB;
			);
		39: (
			findADAPDirectoryByNetSearchPB: DirFindADAPDirectoryByNetSearchPB;
			);
		40: (
			mapDNodeNumberToPathNamePB: DirMapDNodeNumberToPathNamePB;
			);
		41: (
			mapPathNameToDNodeNumberPB: DirMapPathNameToDNodeNumberPB;
			);
		42: (
			getLocalNetworkSpecPB: DirGetLocalNetworkSpecPB;
			);
		43: (
			getDNodeInfoPB:		DirGetDNodeInfoPB;
			);
		44: (
			createPersonalDirectoryPB: DirCreatePersonalDirectoryPB;
			);
		45: (
			openPersonalDirectoryPB: DirOpenPersonalDirectoryPB;
			);
		46: (
			closePersonalDirectoryPB: DirClosePersonalDirectoryPB;
			);
		47: (
			makePersonalDirectoryRLIPB: DirMakePersonalDirectoryRLIPB;
			);
		48: (
			addDSAMPB:			DirAddDSAMPB;
			);
		49: (
			instantiateDSAMPB:	DirInstantiateDSAMPB;
			);
		50: (
			removeDSAMPB:		DirRemoveDSAMPB;
			);
		51: (
			addDSAMDirectoryPB:	DirAddDSAMDirectoryPB;
			);
		52: (
			getExtendedDirectoriesInfoPB: DirGetExtendedDirectoriesInfoPB;
			);
		53: (
			getDirectoryIconPB:	DirGetDirectoryIconPB;
			);
		54: (
			dirGetOCESetupRefNumPB: DirGetOCESetupRefNumPB;
			);
		55: (
			abortPB:			DirAbortPB;
			);
	END;


CONST
	uppAuthIOCompletionProcInfo = $00009802;
	uppNotificationProcInfo = $00003FD0;
	uppDirIOCompletionProcInfo = $00009802;
	uppForEachDirEnumSpecProcInfo = $000003D0;
	uppForEachRecordProcInfo = $00000FD0;
	uppForEachLookupRecordIDProcInfo = $000003D0;
	uppForEachAttrTypeLookupProcInfo = $00000FD0;
	uppForEachAttrValueProcInfo = $000003D0;
	uppForEachAttrTypeProcInfo = $000003D0;
	uppForEachRecordIDProcInfo = $000003D0;
	uppForEachDirectoryProcInfo = $00003FD0;
	uppForEachADAPDirectoryProcInfo = $0000FFD0;
	uppForEachDNodeAccessControlProcInfo = $0000FFD0;
	uppForEachRecordAccessControlProcInfo = $0000FFD0;
	uppForEachAttributeAccessControlProcInfo = $0000FFD0;
	uppDSAMDirProcInfo = $000007E0;
	uppDSAMDirParseProcInfo = $000007E0;
	uppDSAMAuthProcInfo = $000007E0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewAuthIOCompletionUPP(userRoutine: AuthIOCompletionProcPtr): AuthIOCompletionUPP; { old name was NewAuthIOCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNotificationUPP(userRoutine: NotificationProcPtr): NotificationUPP; { old name was NewNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDirIOCompletionUPP(userRoutine: DirIOCompletionProcPtr): DirIOCompletionUPP; { old name was NewDirIOCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachDirEnumSpecUPP(userRoutine: ForEachDirEnumSpecProcPtr): ForEachDirEnumSpecUPP; { old name was NewForEachDirEnumSpecProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachRecordUPP(userRoutine: ForEachRecordProcPtr): ForEachRecordUPP; { old name was NewForEachRecordProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachLookupRecordIDUPP(userRoutine: ForEachLookupRecordIDProcPtr): ForEachLookupRecordIDUPP; { old name was NewForEachLookupRecordIDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachAttrTypeLookupUPP(userRoutine: ForEachAttrTypeLookupProcPtr): ForEachAttrTypeLookupUPP; { old name was NewForEachAttrTypeLookupProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachAttrValueUPP(userRoutine: ForEachAttrValueProcPtr): ForEachAttrValueUPP; { old name was NewForEachAttrValueProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachAttrTypeUPP(userRoutine: ForEachAttrTypeProcPtr): ForEachAttrTypeUPP; { old name was NewForEachAttrTypeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachRecordIDUPP(userRoutine: ForEachRecordIDProcPtr): ForEachRecordIDUPP; { old name was NewForEachRecordIDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachDirectoryUPP(userRoutine: ForEachDirectoryProcPtr): ForEachDirectoryUPP; { old name was NewForEachDirectoryProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachADAPDirectoryUPP(userRoutine: ForEachADAPDirectoryProcPtr): ForEachADAPDirectoryUPP; { old name was NewForEachADAPDirectoryProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachDNodeAccessControlUPP(userRoutine: ForEachDNodeAccessControlProcPtr): ForEachDNodeAccessControlUPP; { old name was NewForEachDNodeAccessControlProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachRecordAccessControlUPP(userRoutine: ForEachRecordAccessControlProcPtr): ForEachRecordAccessControlUPP; { old name was NewForEachRecordAccessControlProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachAttributeAccessControlUPP(userRoutine: ForEachAttributeAccessControlProcPtr): ForEachAttributeAccessControlUPP; { old name was NewForEachAttributeAccessControlProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDSAMDirUPP(userRoutine: DSAMDirProcPtr): DSAMDirUPP; { old name was NewDSAMDirProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDSAMDirParseUPP(userRoutine: DSAMDirParseProcPtr): DSAMDirParseUPP; { old name was NewDSAMDirParseProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDSAMAuthUPP(userRoutine: DSAMAuthProcPtr): DSAMAuthUPP; { old name was NewDSAMAuthProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeAuthIOCompletionUPP(userUPP: AuthIOCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeNotificationUPP(userUPP: NotificationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeDirIOCompletionUPP(userUPP: DirIOCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeForEachDirEnumSpecUPP(userUPP: ForEachDirEnumSpecUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeForEachRecordUPP(userUPP: ForEachRecordUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeForEachLookupRecordIDUPP(userUPP: ForEachLookupRecordIDUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeForEachAttrTypeLookupUPP(userUPP: ForEachAttrTypeLookupUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeForEachAttrValueUPP(userUPP: ForEachAttrValueUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeForEachAttrTypeUPP(userUPP: ForEachAttrTypeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeForEachRecordIDUPP(userUPP: ForEachRecordIDUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeForEachDirectoryUPP(userUPP: ForEachDirectoryUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeForEachADAPDirectoryUPP(userUPP: ForEachADAPDirectoryUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeForEachDNodeAccessControlUPP(userUPP: ForEachDNodeAccessControlUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeForEachRecordAccessControlUPP(userUPP: ForEachRecordAccessControlUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeForEachAttributeAccessControlUPP(userUPP: ForEachAttributeAccessControlUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeDSAMDirUPP(userUPP: DSAMDirUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeDSAMDirParseUPP(userUPP: DSAMDirParseUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeDSAMAuthUPP(userUPP: DSAMAuthUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeAuthIOCompletionUPP(paramBlock: AuthParamBlockPtr; userRoutine: AuthIOCompletionUPP); { old name was CallAuthIOCompletionProc }

FUNCTION InvokeNotificationUPP(clientData: LONGINT; callValue: AuthLocalIdentityOp; actionValue: AuthLocalIdentityLockAction; identity: LocalIdentity; userRoutine: NotificationUPP): BOOLEAN; { old name was CallNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeDirIOCompletionUPP(paramBlock: DirParamBlockPtr; userRoutine: DirIOCompletionUPP); { old name was CallDirIOCompletionProc }

FUNCTION InvokeForEachDirEnumSpecUPP(clientData: LONGINT; {CONST}VAR enumSpec: DirEnumSpec; userRoutine: ForEachDirEnumSpecUPP): BOOLEAN; { old name was CallForEachDirEnumSpecProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeForEachRecordUPP(clientData: LONGINT; {CONST}VAR enumSpec: DirEnumSpec; pRLI: PackedRLIPtr; userRoutine: ForEachRecordUPP): BOOLEAN; { old name was CallForEachRecordProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeForEachLookupRecordIDUPP(clientData: LONGINT; {CONST}VAR recordID: RecordID; userRoutine: ForEachLookupRecordIDUPP): BOOLEAN; { old name was CallForEachLookupRecordIDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeForEachAttrTypeLookupUPP(clientData: LONGINT; {CONST}VAR attrType: AttributeType; myAttrAccMask: AccessMask; userRoutine: ForEachAttrTypeLookupUPP): BOOLEAN; { old name was CallForEachAttrTypeLookupProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeForEachAttrValueUPP(clientData: LONGINT; {CONST}VAR attribute: Attribute; userRoutine: ForEachAttrValueUPP): BOOLEAN; { old name was CallForEachAttrValueProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeForEachAttrTypeUPP(clientData: LONGINT; {CONST}VAR attrType: AttributeType; userRoutine: ForEachAttrTypeUPP): BOOLEAN; { old name was CallForEachAttrTypeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeForEachRecordIDUPP(clientData: LONGINT; {CONST}VAR recordID: RecordID; userRoutine: ForEachRecordIDUPP): BOOLEAN; { old name was CallForEachRecordIDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeForEachDirectoryUPP(clientData: LONGINT; {CONST}VAR dirName: DirectoryName; {CONST}VAR discriminator: DirDiscriminator; features: DirGestalt; userRoutine: ForEachDirectoryUPP): BOOLEAN; { old name was CallForEachDirectoryProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeForEachADAPDirectoryUPP(clientData: LONGINT; {CONST}VAR dirName: DirectoryName; {CONST}VAR discriminator: DirDiscriminator; features: DirGestalt; serverHint: AddrBlock; userRoutine: ForEachADAPDirectoryUPP): BOOLEAN; { old name was CallForEachADAPDirectoryProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeForEachDNodeAccessControlUPP(clientData: LONGINT; {CONST}VAR dsObj: DSSpec; activeDnodeAccMask: AccessMask; defaultRecordAccMask: AccessMask; defaultAttributeAccMask: AccessMask; userRoutine: ForEachDNodeAccessControlUPP): BOOLEAN; { old name was CallForEachDNodeAccessControlProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeForEachRecordAccessControlUPP(clientData: LONGINT; {CONST}VAR dsObj: DSSpec; activeDnodeAccMask: AccessMask; activeRecordAccMask: AccessMask; defaultAttributeAccMask: AccessMask; userRoutine: ForEachRecordAccessControlUPP): BOOLEAN; { old name was CallForEachRecordAccessControlProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeForEachAttributeAccessControlUPP(clientData: LONGINT; {CONST}VAR dsObj: DSSpec; activeDnodeAccMask: AccessMask; activeRecordAccMask: AccessMask; activeAttributeAccMask: AccessMask; userRoutine: ForEachAttributeAccessControlUPP): BOOLEAN; { old name was CallForEachAttributeAccessControlProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeDSAMDirUPP(dsamData: UNIV Ptr; paramBlock: DirParamBlockPtr; async: BOOLEAN; userRoutine: DSAMDirUPP): OSErr; { old name was CallDSAMDirProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeDSAMDirParseUPP(dsamData: UNIV Ptr; paramBlock: DirParamBlockPtr; async: BOOLEAN; userRoutine: DSAMDirParseUPP): OSErr; { old name was CallDSAMDirParseProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeDSAMAuthUPP(dsamData: UNIV Ptr; pb: AuthParamBlockPtr; async: BOOLEAN; userRoutine: DSAMAuthUPP): OSErr; { old name was CallDSAMAuthProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
FUNCTION AuthBindSpecificIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0200, $AA5E;
	{$ENDC}
FUNCTION AuthUnbindSpecificIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0201, $AA5E;
	{$ENDC}
FUNCTION AuthResolveCreationID(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0202, $AA5E;
	{$ENDC}
FUNCTION AuthGetSpecificIdentityInfo(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0203, $AA5E;
	{$ENDC}
FUNCTION AuthAddKey(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0207, $AA5E;
	{$ENDC}
FUNCTION AuthChangeKey(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0208, $AA5E;
	{$ENDC}
FUNCTION AuthDeleteKey(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0209, $AA5E;
	{$ENDC}
FUNCTION AuthPasswordToKey(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $020A, $AA5E;
	{$ENDC}
FUNCTION AuthGetCredentials(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $020B, $AA5E;
	{$ENDC}
FUNCTION AuthDecryptCredentials(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $020C, $AA5E;
	{$ENDC}
FUNCTION AuthMakeChallenge(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $020F, $AA5E;
	{$ENDC}
FUNCTION AuthMakeReply(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0210, $AA5E;
	{$ENDC}
FUNCTION AuthVerifyReply(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0211, $AA5E;
	{$ENDC}
FUNCTION AuthGetUTCTime(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $021A, $AA5E;
	{$ENDC}
FUNCTION AuthMakeProxy(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0212, $AA5E;
	{$ENDC}
FUNCTION AuthTradeProxyForCredentials(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0213, $AA5E;
	{$ENDC}
{ Local Identity API }
FUNCTION AuthGetLocalIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0204, $AA5E;
	{$ENDC}
FUNCTION AuthUnlockLocalIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0214, $AA5E;
	{$ENDC}
FUNCTION AuthLockLocalIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0215, $AA5E;
	{$ENDC}
FUNCTION AuthAddToLocalIdentityQueue(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0205, $AA5E;
	{$ENDC}
FUNCTION AuthRemoveFromLocalIdentityQueue(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0206, $AA5E;
	{$ENDC}
FUNCTION AuthSetupLocalIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0216, $AA5E;
	{$ENDC}
FUNCTION AuthChangeLocalIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0217, $AA5E;
	{$ENDC}
FUNCTION AuthRemoveLocalIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0218, $AA5E;
	{$ENDC}
FUNCTION DirAddRecord(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0109, $AA5E;
	{$ENDC}
FUNCTION DirDeleteRecord(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $010A, $AA5E;
	{$ENDC}
FUNCTION DirEnumerateGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0111, $AA5E;
	{$ENDC}
FUNCTION DirEnumerateParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0101, $AA5E;
	{$ENDC}
FUNCTION DirFindRecordGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0140, $AA5E;
	{$ENDC}
FUNCTION DirFindRecordParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0141, $AA5E;
	{$ENDC}
FUNCTION DirLookupGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0117, $AA5E;
	{$ENDC}
FUNCTION DirLookupParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0102, $AA5E;
	{$ENDC}
FUNCTION DirAddAttributeValue(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $010B, $AA5E;
	{$ENDC}
FUNCTION DirDeleteAttributeValue(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $010C, $AA5E;
	{$ENDC}
FUNCTION DirDeleteAttributeType(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0130, $AA5E;
	{$ENDC}
FUNCTION DirChangeAttributeValue(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $010D, $AA5E;
	{$ENDC}
FUNCTION DirVerifyAttributeValue(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $010E, $AA5E;
	{$ENDC}
FUNCTION DirFindValue(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0126, $AA5E;
	{$ENDC}
FUNCTION DirEnumerateAttributeTypesGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0112, $AA5E;
	{$ENDC}
FUNCTION DirEnumerateAttributeTypesParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0103, $AA5E;
	{$ENDC}
FUNCTION DirAddPseudonym(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $010F, $AA5E;
	{$ENDC}
FUNCTION DirDeletePseudonym(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0110, $AA5E;
	{$ENDC}
FUNCTION DirAddAlias(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $011C, $AA5E;
	{$ENDC}
FUNCTION DirEnumeratePseudonymGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0113, $AA5E;
	{$ENDC}
FUNCTION DirEnumeratePseudonymParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0104, $AA5E;
	{$ENDC}
FUNCTION DirGetNameAndType(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0114, $AA5E;
	{$ENDC}
FUNCTION DirSetNameAndType(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0115, $AA5E;
	{$ENDC}
FUNCTION DirGetRecordMetaInfo(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0116, $AA5E;
	{$ENDC}
FUNCTION DirGetDNodeMetaInfo(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0118, $AA5E;
	{$ENDC}
FUNCTION DirGetDirectoryInfo(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0119, $AA5E;
	{$ENDC}
FUNCTION DirGetDNodeAccessControlGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $012A, $AA5E;
	{$ENDC}
FUNCTION DirGetDNodeAccessControlParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $012F, $AA5E;
	{$ENDC}
FUNCTION DirGetRecordAccessControlGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $012C, $AA5E;
	{$ENDC}
FUNCTION DirGetRecordAccessControlParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0134, $AA5E;
	{$ENDC}
FUNCTION DirGetAttributeAccessControlGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $012E, $AA5E;
	{$ENDC}
FUNCTION DirGetAttributeAccessControlParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0138, $AA5E;
	{$ENDC}
FUNCTION DirEnumerateDirectoriesGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $011A, $AA5E;
	{$ENDC}
FUNCTION DirEnumerateDirectoriesParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0106, $AA5E;
	{$ENDC}
FUNCTION DirMapPathNameToDNodeNumber(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0122, $AA5E;
	{$ENDC}
FUNCTION DirMapDNodeNumberToPathName(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0123, $AA5E;
	{$ENDC}

FUNCTION DirGetLocalNetworkSpec(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0124, $AA5E;
	{$ENDC}
FUNCTION DirGetDNodeInfo(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0125, $AA5E;
	{$ENDC}

{  Trap Dispatchers for Personal Catalog and CSAM Extensions }
FUNCTION DirCreatePersonalDirectory(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $011F, $AA5E;
	{$ENDC}
FUNCTION DirOpenPersonalDirectory(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $011E, $AA5E;
	{$ENDC}
FUNCTION DirClosePersonalDirectory(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $0131, $AA5E;
	{$ENDC}
FUNCTION DirMakePersonalDirectoryRLI(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $0132, $AA5E;
	{$ENDC}
FUNCTION DirAddDSAM(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $011D, $AA5E;
	{$ENDC}
FUNCTION DirInstantiateDSAM(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $0127, $AA5E;
	{$ENDC}

FUNCTION DirRemoveDSAM(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $0120, $AA5E;
	{$ENDC}
FUNCTION DirAddDSAMDirectory(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0133, $AA5E;
	{$ENDC}
FUNCTION DirGetExtendedDirectoriesInfo(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0136, $AA5E;
	{$ENDC}
FUNCTION DirGetDirectoryIcon(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0121, $AA5E;
	{$ENDC}

FUNCTION DirAddADAPDirectory(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0137, $AA5E;
	{$ENDC}
FUNCTION DirRemoveDirectory(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0135, $AA5E;
	{$ENDC}
FUNCTION DirNetSearchADAPDirectoriesGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0108, $AA5E;
	{$ENDC}
FUNCTION DirNetSearchADAPDirectoriesParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0105, $AA5E;
	{$ENDC}
FUNCTION DirFindADAPDirectoryByNetSearch(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0107, $AA5E;
	{$ENDC}
FUNCTION DirGetOCESetupRefNum(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0128, $AA5E;
	{$ENDC}
FUNCTION DirAbort(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $1F00, $3F3C, $011B, $AA5E;
	{$ENDC}
FUNCTION OCESetupAddDirectoryInfo(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0219, $AA5E;
	{$ENDC}
FUNCTION OCESetupChangeDirectoryInfo(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $021B, $AA5E;
	{$ENDC}
FUNCTION OCESetupRemoveDirectoryInfo(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $020D, $AA5E;
	{$ENDC}
FUNCTION OCESetupGetDirectoryInfo(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $020E, $AA5E;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OCEAuthDirIncludes}

{$ENDC} {__OCEAUTHDIR__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
