{
 	File:		OCE.p
 
 	Contains:	Apple Open Collaboration Environment (AOCE) Interfaces.
 
 	Version:	Technology:	AOCE Toolbox 1.02
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1994-1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OCE;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OCE__}
{$SETC __OCE__ := 1}

{$I+}
{$SETC OCEIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __ALIASES__}
{$I Aliases.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ All utility routines defined here are callable at interrupt level. }

TYPE
	OCERecordTypeIndex					= UInt16;
	OCEAttributeTypeIndex				= UInt16;
{ For anyone who absolutely needs a define of the body of the standard record or
attribute type, use these below.  CAUTION!  All the types below are assumed to be
in character set 'smRoman'.  If you try to compare these to some RString or
AttributeType variable, you must take the character set code into account.  Future
standard types may be defined using character sets other than 'smRoman'. }

{ All these standard definitions begin with the Apple symbol (not shown here).

NOTE:  To access these, you must call OCEGetIndRecordType or OCEGetIndAttributeType
with the proper index.  These routines return pointers to the standard type.
This was done so that code fragments (INITs, CDEVs, CSAMs, etc). which cannot
use global data can also use these. }
{ Indices for the standard definitions for certain record types (OCERecordTypeIndex): }

CONST
	kUserRecTypeNum				= 1;							{  "User"  }
	kGroupRecTypeNum			= 2;							{  "Group"  }
	kMnMRecTypeNum				= 3;							{  "AppleMail™ M&M"  }
	kMnMForwarderRecTypeNum		= 4;							{  "AppleMail™ Fwdr"  }
	kNetworkSpecRecTypeNum		= 5;							{  "NetworkSpec"  }
	kADAPServerRecTypeNum		= 6;							{  "ADAP Server"  }
	kADAPDNodeRecTypeNum		= 7;							{  "ADAP DNode"  }
	kADAPDNodeRepRecTypeNum		= 8;							{  "ADAP DNode Rep"  }
	kServerSetupRecTypeNum		= 9;							{  "Server Setup"  }
	kDirectoryRecTypeNum		= 10;							{  "Directory"  }
	kDNodeRecTypeNum			= 11;							{  "DNode"  }
	kSetupRecTypeNum			= 12;							{  "Setup"  }
	kMSAMRecTypeNum				= 13;							{  "MSAM"  }
	kDSAMRecTypeNum				= 14;							{  "DSAM"  }
	kAttributeValueRecTypeNum	= 15;							{  "Attribute Value"  }
	kBusinessCardRecTypeNum		= 16;							{  "Business Card"  }
	kMailServiceRecTypeNum		= 17;							{  "Mail Service"  }
	kCombinedRecTypeNum			= 18;							{  "Combined"  }
	kOtherServiceRecTypeNum		= 19;							{  "Other Service"  }
	kAFPServiceRecTypeNum		= 20;							{  "Other Service afps"  }
	kFirstOCERecTypeNum			= 1;							{  first standard OCE record type  }
	kLastOCERecTypeNum			= 20;							{  last standard OCE record type  }
	kNumOCERecTypes				= 20;

{ Indices for the standard definitions for certain attribute types (OCEAttributeTypeIndex): }
	kMemberAttrTypeNum			= 1001;							{  "Member"  }
	kAdminsAttrTypeNum			= 1002;							{  "Administrators"  }
	kMailSlotsAttrTypeNum		= 1003;							{  "mailslots"  }
	kPrefMailAttrTypeNum		= 1004;							{  "pref mailslot"  }
	kAddressAttrTypeNum			= 1005;							{  "Address"  }
	kPictureAttrTypeNum			= 1006;							{  "Picture"  }
	kAuthKeyAttrTypeNum			= 1007;							{  "auth key"  }
	kTelephoneAttrTypeNum		= 1008;							{  "Telephone"  }
	kNBPNameAttrTypeNum			= 1009;							{  "NBP Name"  }
	kQMappingAttrTypeNum		= 1010;							{  "ForwarderQMap"  }
	kDialupSlotAttrTypeNum		= 1011;							{  "DialupSlotInfo"  }
	kHomeNetAttrTypeNum			= 1012;							{  "Home Internet"  }
	kCoResAttrTypeNum			= 1013;							{  "Co-resident M&M"  }
	kFwdrLocalAttrTypeNum		= 1014;							{  "FwdrLocalRecord"  }
	kConnectAttrTypeNum			= 1015;							{  "Connected To"  }
	kForeignAttrTypeNum			= 1016;							{  "Foreign RLIs"  }
	kOwnersAttrTypeNum			= 1017;							{  "Owners"  }
	kReadListAttrTypeNum		= 1018;							{  "ReadList"  }
	kWriteListAttrTypeNum		= 1019;							{  "WriteList"  }
	kDescriptorAttrTypeNum		= 1020;							{  "Descriptor"  }
	kCertificateAttrTypeNum		= 1021;							{  "Certificate"  }
	kMsgQsAttrTypeNum			= 1022;							{  "MessageQs"  }
	kPrefMsgQAttrTypeNum		= 1023;							{  "PrefMessageQ"  }
	kMasterPFAttrTypeNum		= 1024;							{  "MasterPF"  }
	kMasterNetSpecAttrTypeNum	= 1025;							{  "MasterNetSpec"  }
	kServersOfAttrTypeNum		= 1026;							{  "Servers Of"  }
	kParentCIDAttrTypeNum		= 1027;							{  "Parent CID"  }
	kNetworkSpecAttrTypeNum		= 1028;							{  "NetworkSpec"  }
	kLocationAttrTypeNum		= 1029;							{  "Location"  }
	kTimeSvrTypeAttrTypeNum		= 1030;							{  "TimeServer Type"  }
	kUpdateTimerAttrTypeNum		= 1031;							{  "Update Timer"  }
	kShadowsOfAttrTypeNum		= 1032;							{  "Shadows Of"  }
	kShadowServerAttrTypeNum	= 1033;							{  "Shadow Server"  }
	kTBSetupAttrTypeNum			= 1034;							{  "TB Setup"  }
	kMailSetupAttrTypeNum		= 1035;							{  "Mail Setup"  }
	kSlotIDAttrTypeNum			= 1036;							{  "SlotID"  }
	kGatewayFileIDAttrTypeNum	= 1037;							{  "Gateway FileID"  }
	kMailServiceAttrTypeNum		= 1038;							{  "Mail Service"  }
	kStdSlotInfoAttrTypeNum		= 1039;							{  "Std Slot Info"  }
	kAssoDirectoryAttrTypeNum	= 1040;							{  "Asso. Directory"  }
	kDirectoryAttrTypeNum		= 1041;							{  "Directory"  }
	kDirectoriesAttrTypeNum		= 1042;							{  "Directories"  }
	kSFlagsAttrTypeNum			= 1043;							{  "SFlags"  }
	kLocalNameAttrTypeNum		= 1044;							{  "Local Name"  }
	kLocalKeyAttrTypeNum		= 1045;							{  "Local Key"  }
	kDirUserRIDAttrTypeNum		= 1046;							{  "Dir User RID"  }
	kDirUserKeyAttrTypeNum		= 1047;							{  "Dir User Key"  }
	kDirNativeNameAttrTypeNum	= 1048;							{  "Dir Native Name"  }
	kCommentAttrTypeNum			= 1049;							{  "Comment"  }
	kRealNameAttrTypeNum		= 1050;							{  "Real Name"  }
	kPrivateDataAttrTypeNum		= 1051;							{  "Private Data"  }
	kDirTypeAttrTypeNum			= 1052;							{  "Directory Type"  }
	kDSAMFileAliasAttrTypeNum	= 1053;							{  "DSAM File Alias"  }
	kCanAddressToAttrTypeNum	= 1054;							{  "Can Address To"  }
	kDiscriminatorAttrTypeNum	= 1055;							{  "Discriminator"  }
	kAliasAttrTypeNum			= 1056;							{  "Alias"  }
	kParentMSAMAttrTypeNum		= 1057;							{  "Parent MSAM"  }
	kParentDSAMAttrTypeNum		= 1058;							{  "Parent DSAM"  }
	kSlotAttrTypeNum			= 1059;							{  "Slot"  }
	kAssoMailServiceAttrTypeNum	= 1060;							{  "Asso. Mail Service"  }
	kFakeAttrTypeNum			= 1061;							{  "Fake"  }
	kInheritSysAdminAttrTypeNum	= 1062;							{  "Inherit SysAdministrators"  }
	kPreferredPDAttrTypeNum		= 1063;							{  "Preferred PD"  }
	kLastLoginAttrTypeNum		= 1064;							{  "Last Login"  }
	kMailerAOMStateAttrTypeNum	= 1065;							{  "Mailer AOM State"  }
	kMailerSendOptionsAttrTypeNum = 1066;						{  "Mailer Send Options"  }
	kJoinedAttrTypeNum			= 1067;							{  "Joined"  }
	kUnconfiguredAttrTypeNum	= 1068;							{  "Unconfigured"  }
	kVersionAttrTypeNum			= 1069;							{  "Version"  }
	kLocationNamesAttrTypeNum	= 1070;							{  "Location Names"  }
	kActiveAttrTypeNum			= 1071;							{  "Active"  }
	kDeleteRequestedAttrTypeNum	= 1072;							{  "Delete Requested"  }
	kGatewayTypeAttrTypeNum		= 1073;							{  "Gateway Type"  }
	kFirstOCEAttrTypeNum		= 1001;							{  first standard OCE attr type  }
	kLastOCEAttrTypeNum			= 1073;							{  last standard OCE attr type  }
	kNumOCEAttrTypes			= 73;


{ Miscellaneous enums: }
	kRString32Size				= 32;							{  max size of the body field in RString32  }
	kRString64Size				= 64;							{  max size of the body field in RString64  }
	kNetworkSpecMaxBytes		= 32;							{  max size of the body field in NetworkSpec  }
	kPathNameMaxBytes			= 1024;							{  max size of the data field in PackedPathName  }
	kDirectoryNameMaxBytes		= 32;							{  max size of the body field in DirectoryName  }
	kAttributeTypeMaxBytes		= 32;							{  max size of the body field in AttributeType  }
	kAttrValueMaxBytes			= 65536;						{  max size of any attribute value  }
	kRStringMaxBytes			= 256;							{  max size (in bytes) of the body field of a recordName or recordType  }
	kRStringMaxChars			= 128;							{  max size (in chars) of the body field of a recordName or recordType  }

	kNULLDNodeNumber			= 0;							{  Special value meaning none specified  }
	kRootDNodeNumber			= 2;							{  DNodeNum corresponding to the root of the tree  }


{ This enum is used to select the kind of RString in calls such as OCERelRString,
OCEEqualRString, and OCEValidRString.

eGenericSensitive and eGenericInsensitive are enumerators that can be used if you
use RStrings for things other than what you see in this file.  If you want them to
be compared in a case- and diacritical-sensitive manner (c ≠ C ≠ ç), use
eGenericSensitive.  If you want them to be compared in a case- and diacritical-
insensitive manner (c = C = ç), use eGenericInensitive.
WARNING:  do not use eGenericSensitive and eGenericInsensitive with catalog
names, entity names, pathname parts, entity types, network specs, or attribute
types!  Don't assume that you know how they should be compared!!! }
	kOCEDirName					= 0;
	kOCERecordOrDNodeName		= 1;
	kOCERecordType				= 2;
	kOCENetworkSpec				= 3;
	kOCEAttrType				= 4;
	kOCEGenericSensitive		= 5;
	kOCEGenericInsensitive		= 6;


TYPE
	RStringKind							= UInt16;
{ Values for the signature field in Discriminator }

CONST
	kDirAllKinds				= 0;
	kDirADAPKind				= 'adap';
	kDirPersonalDirectoryKind	= 'pdir';
	kDirDSAMKind				= 'dsam';



TYPE
	OCEDirectoryKind					= UInt32;
{ Values returned by GetDSSpecInfo() }

CONST
	kOCEInvalidDSSpec			= $3F3F3F3F;					{  '????' could not be determined  }
	kOCEDirsRootDSSpec			= 'root';						{  root of all catalogs ("Catalogs" icon)  }
	kOCEDirectoryDSSpec			= 'dire';						{  catalog  }
	kOCEDNodeDSSpec				= 'dnod';						{  d-node  }
	kOCERecordDSSpec			= 'reco';						{  record  }
	kOCEentnDSSpec				= 'entn';						{  extensionType is 'entn'  }
	kOCENOTentnDSSpec			= 'not ';						{  extensionType is not 'entn'  }


{ Values for AttributeTag }
	typeRString					= 'rstr';
	typePackedDSSpec			= 'dspc';
	typeBinary					= 'bnry';


{ Bit flag corresponding to the canContainRecords bit.  Use it like this:
	if (foo & kCanContainRecords)
		then this dNode can contain records!
kForeignNode is used to indicate nodes in the name hierarchy that correspond to
foreign catalogs (meaning ADAP sees no clusters or DNodes beneath it, but
mail routers might be able to route to clusters beneath it. }
	kCanContainRecordsBit		= 0;
	kForeignNodeBit				= 1;

{ DirNodeKind }
	kCanContainRecords			= $00000001;
	kForeignNode				= $00000002;


TYPE
	DirNodeKind							= UInt32;


{*** Toolbox Control ***}
{ We will have a version number and attributes for toolboxes off the aa5e trap
and the S&F server trap.

This includes the OCE toolbox and S&F Server.  [Note: the S&F server will
change to ONLY service ServerGateway calls —it will then be necessary to run
it co–resident with an OCE toolbox].

The high order word will represent the S&F Server version number.  The low
order word will represent the OCE toolbox version number.  These will be zero
until the component is up and running.  It is not possible to know these
a–priori. Note: there will not be a seperate version numbers for each component
in the OCE toolbox or S&F server.

The above is consistent with the standard System 7.0 usage of Gestalt.

The oce tb attribute gestaltOCETBPresent implies the existence of OCE on a
machine.

The OCE TB attribute gestaltOCETBAvailable implies the availablity of OCE calls.

The attribute gestaltOCESFServerAvailable implies the availablity of OCE calls
available through the S&F server. This are essentially the server gateway calls.

Any (future) remaining OCE attributes may not be established correctly until
the attribute gestaltOCETBAvailable is set.

}

{	Constants used for Transitions. }

CONST
	ATTransIPMStart				= 'ipms';
	ATTransIPMShutdown			= 'ipmd';
	ATTransDirStart				= 'dirs';
	ATTransDirShutdown			= 'dird';
	ATTransAuthStart			= 'auts';
	ATTransAuthShutdown			= 'autd';
	ATTransSFStart				= 's&fs';
	ATTransSFShutdown			= 's&fd';



{ Some definitions for time-related parameters: }
{ Interpreted as UTC seconds since 1/1/1904 }

TYPE
	UTCTime								= UInt32;
{ seconds EAST of Greenwich }
	UTCOffset							= LONGINT;
{ This is the same as the ScriptManager script. }
	CharacterSet						= INTEGER;
{*** RString ***}

{ struct RString is a maximum-sized structure.  Allocate one of these and it will
hold any valid RString. }
	RStringPtr = ^RString;
	RString = RECORD
		charSet:				CharacterSet;
		dataLength:				UInt16;
		body:					PACKED ARRAY [0..255] OF Byte;			{  place for characters  }
	END;

{ struct ProtoRString is a minimum-sized structure.  Use this for a variable-length RString. }
	ProtoRStringPtr = ^ProtoRString;
	ProtoRString = RECORD
		charSet:				CharacterSet;
		dataLength:				UInt16;
	END;

	RStringHandle						= ^RStringPtr;
	RString64Ptr = ^RString64;
	RString64 = RECORD
		charSet:				CharacterSet;
		dataLength:				UInt16;
		body:					PACKED ARRAY [0..63] OF Byte;
	END;

	RString32Ptr = ^RString32;
	RString32 = RECORD
		charSet:				CharacterSet;
		dataLength:				UInt16;
		body:					PACKED ARRAY [0..31] OF Byte;
	END;

{ Standard definitions for the entity type field and attribute type
have been moved to the end of the file. }

{ Copies str1 to str2.  str2Length is the size of str2, excluding header.
A memFull error will be returned if that is not as large as str1->dataLength. }
FUNCTION OCECopyRString({CONST}VAR str1: RString; VAR str2: RString; str2Length: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0308, $AA5C;
	{$ENDC}

{	Make an RString from a C string.  If the c string is bigger than rStrLength,
only rStrLength bytes will be copied. (rStrLength does not include the header size) }
PROCEDURE OCECToRString(cStr: ConstCStringPtr; charSet: CharacterSet; VAR rStr: RString; rStrLength: UInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0339, $AA5C;
	{$ENDC}

{	Make an RString from a Pascal string.  If the Pascal string is bigger than rStrLength,
only rStrLength bytes will be copied. (rStrLength does not include the header size) }
PROCEDURE OCEPToRString(pStr: Str255; charSet: CharacterSet; VAR rStr: RString; rStrLength: UInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $033A, $AA5C;
	{$ENDC}

{	Make a Pascal string from an RString.  It's up to you to check the char set of
the RString, or if the length of the RString is greater than 255 (the Pascal string's
length will simply be the lower byte of the RString's length).  The StringPtr that is
returned will point directly into the RString (no memory will be allocated). }
FUNCTION OCERToPString(rStr: RStringPtr): StringPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $033B, $AA5C;
	{$ENDC}
{	Check the relative equality of two RStrings.  Determines if str1 is greater than,
equal to, or less than str2.  Result types for OCERelRString are defined in <OSUtils.h>
(same as for RelString). }
FUNCTION OCERelRString(str1: UNIV Ptr; str2: UNIV Ptr; kind: RStringKind): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $032D, $AA5C;
	{$ENDC}

{	Check for equality of two RStrings. Returns true if equal. }
FUNCTION OCEEqualRString(str1: UNIV Ptr; str2: UNIV Ptr; kind: RStringKind): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0316, $AA5C;
	{$ENDC}

{	Check the validity of an RString.  Returns true if the RString is valid }
FUNCTION OCEValidRString(str: UNIV Ptr; kind: RStringKind): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0338, $AA5C;
	{$ENDC}

{*** CreationID ***}

TYPE
	CreationIDPtr = ^CreationID;
	CreationID = RECORD
		source:					UInt32;									{  Fields definitions and usage are not defined  }
		seq:					UInt32;
	END;

	AttributeCreationID					= CreationID;
	AttributeCreationIDPtr 				= ^AttributeCreationID;

{ Returns a pointer to a null CreationID . }
FUNCTION OCENullCID: CreationIDPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0344, $AA5C;
	{$ENDC}

{ Returns a pointer to a special CreationID used within the PathFinder. }
FUNCTION OCEPathFinderCID: CreationIDPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $033C, $AA5C;
	{$ENDC}

{ Sets the CreationID to a null value. }
PROCEDURE OCESetCreationIDtoNull(VAR cid: CreationID);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $032E, $AA5C;
	{$ENDC}

{ Copies the value of cid1 to cid2. }
PROCEDURE OCECopyCreationID({CONST}VAR cid1: CreationID; VAR cid2: CreationID);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0300, $AA5C;
	{$ENDC}

{ Check the equality of two CreationIDs. }
FUNCTION OCEEqualCreationID({CONST}VAR cid1: CreationID; {CONST}VAR cid2: CreationID): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $030C, $AA5C;
	{$ENDC}

{*** NetworkSpec ***}
{ For the record, a NetworkSpec is an RString with a smaller maximum size.
I don't just typedef it to an RString, because I want the definition of the NetworkSpec
struct to contain the max length.  But it should be possible to typecast any
NetworkSpec to an RString and use all the RString utilities on it. }

TYPE
	NetworkSpecPtr = ^NetworkSpec;
	NetworkSpec = RECORD
		charSet:				CharacterSet;
		dataLength:				UInt16;
		body:					PACKED ARRAY [0..31] OF Byte;			{  always fixed at the max size  }
	END;


{*** PackedPathName ***}
{ struct PackedPathName is a maximum-sized structure.  Allocate one of
these and it will hold any valid packed pathname. }
	PackedPathNamePtr = ^PackedPathName;
	PackedPathName = RECORD
		dataLength:				UInt16;									{  dataLength excludes the space for the dataLength field  }
		data:					PACKED ARRAY [0..1021] OF Byte;
	END;

{ struct ProtoPackedPathName is a minimum-sized structure.  Use this
for a variable-length packed PathName. }
	ProtoPackedPathNamePtr = ^ProtoPackedPathName;
	ProtoPackedPathName = RECORD
		dataLength:				UInt16;									{  dataLength excludes the space for the dataLength field  }
																		{  Followed by data  }
	END;

{
Copy the contents of path1 to path2.  path2Length is the size of path2, and must
be large enough to hold a copy of path1.  A memFull error will be returned if that
is not the case.
}
FUNCTION OCECopyPackedPathName({CONST}VAR path1: PackedPathName; VAR path2: PackedPathName; path2Length: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0304, $AA5C;
	{$ENDC}

{
Returns true if packed path pointer is nil, or is of zero length, or is of
length 2 and nParts of zero.
}
FUNCTION OCEIsNullPackedPathName({CONST}VAR path: PackedPathName): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $031D, $AA5C;
	{$ENDC}

{
OCEUnpackPathName breaks apart the path into its component RStrings, writing string
pointers into the array 'parts', which the client asserts can hold as many as
'nParts' elements. The number of parts actually found is returned.  Strings are
placed in the array in order from lowest to highest.  The first pathName element
beneath the root appears last.  NOTE THAT THE UNPACKED STRUCT CONTAINS POINTERS INTO
THE PACKED STRUCT - DON'T DELETE OR REUSE THE PACKED STRUCT UNTIL YOU ARE FINISHED
WITH THE UNPACKED STRUCT AS WELL
}
FUNCTION OCEUnpackPathName({CONST}VAR path: PackedPathName; VAR parts: RStringPtr; nParts: UInt16): UInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0330, $AA5C;
	{$ENDC}
{
OCEPackedPathNameSize computes the number of bytes of memory needed to hold a
PackedPathName manufactured from the array of parts.  This length
includes the length of the length field of PackedPathName, so it
is safe to do a NewPtr (OCEPackedPathNameSize(...)).
}
FUNCTION OCEPackedPathNameSize({CONST}VAR parts: RStringPtr; nParts: UInt16): UInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0328, $AA5C;
	{$ENDC}
{ OCEDNodeNameCount returns the number of RStrings contained within the path. }
FUNCTION OCEDNodeNameCount({CONST}VAR path: PackedPathName): UInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $032C, $AA5C;
	{$ENDC}

{
OCEPackPathName packs the parts into the storage provided as 'path'.  path must be
large enough to hold the packed pathname.  A memFull error will be returned if
pathLength is too small.  parts[0] should contain the deepest pathName element,
and parts[nParts - 1] should contain the name of the first pathName element beneath
the root. 
}
FUNCTION OCEPackPathName(VAR parts: RStringPtr; nParts: UInt16; VAR path: PackedPathName; pathLength: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0323, $AA5C;
	{$ENDC}
{
Check the equality of two packed paths.
}
FUNCTION OCEEqualPackedPathName({CONST}VAR path1: PackedPathName; {CONST}VAR path2: PackedPathName): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0311, $AA5C;
	{$ENDC}

{
OCEValidPackedPathName checks that the packed PathName is internally consistent.
Returns true if it's ok.
}
FUNCTION OCEValidPackedPathName({CONST}VAR path: PackedPathName): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0334, $AA5C;
	{$ENDC}

{*** DirDiscriminator ***}

TYPE
	DirDiscriminatorPtr = ^DirDiscriminator;
	DirDiscriminator = RECORD
		signature:				OCEDirectoryKind;
		misc:					UInt32;
	END;

{ Copies the value of disc1 to disc2. }
PROCEDURE OCECopyDirDiscriminator({CONST}VAR disc1: DirDiscriminator; VAR disc2: DirDiscriminator);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0301, $AA5C;
	{$ENDC}

{ Check the equality of two DirDiscriminators. }
FUNCTION OCEEqualDirDiscriminator({CONST}VAR disc1: DirDiscriminator; {CONST}VAR disc2: DirDiscriminator): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $030D, $AA5C;
	{$ENDC}
{
This structure is called RLI because it really contains all the info you
need to locate a record within the entire name space.  It contains four fields.
The first two are the name of the catalog and a catalog discriminator.  These
two fields are used to indicate to which catalog a given record belongs.  The
discriminator is used to distinguish between two different catalogs that have
the same name.

The other two fields in the RLI structure are used to indicate a particular
catalog node within the catalog specified by the directoryName and
discriminator fields.  These fields are exactly analagous to the dirID and
pathname used in HFS.  It is possible to specify a dNode just by dNodeNumber
(pathname is nil), or just by pathname (dNodeNumber is set to kNULLDNodeNumber),
or by a combination of the two.  The latter is called a 'partial pathname', and
while it is valid in the Catalog Manager API, it is not supported by ADAP
catalogs in Release 1.

Note that the path parameter does not include the catalog name, but holds
the names of all the nodes on the path to the desired catalog node, starting
with the catalog node and working its way up the tree.
}

{*** RLI ***}


TYPE
	DirectoryNamePtr = ^DirectoryName;
	DirectoryName = RECORD
		charSet:				CharacterSet;
		dataLength:				UInt16;
		body:					PACKED ARRAY [0..31] OF Byte;			{  space for catalog name  }
	END;

{ Catalog node number }
	DNodeNum							= UInt32;
	RLIPtr = ^RLI;
	RLI = RECORD
		directoryName:			DirectoryNamePtr;						{  pointer to the name of the catalog root  }
		discriminator:			DirDiscriminator;						{  used to discriminate between dup catalog names  }
		dNodeNumber:			DNodeNum;								{  number of the node  }
		path:					PackedPathNamePtr;						{  old-style RLI  }
	END;

{
Create a new RLI from the catalog name, discriminator, DNode number, and
PackedPathName.  You must allocate the storage for the RLI and pass in a pointer
to it.
}
PROCEDURE OCENewRLI(VAR newRLI: RLI; {CONST}VAR dirName: DirectoryName; VAR discriminator: DirDiscriminator; dNodeNumber: DNodeNum; {CONST}VAR path: PackedPathName);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $031F, $AA5C;
	{$ENDC}

{
Duplicate the contents of rli1 to rli2.  No errors are returned. This
simply copies the pointers to the catalog name and path, wiping out any pointer
that you might have had in there.
}
PROCEDURE OCEDuplicateRLI({CONST}VAR rli1: RLI; VAR rli2: RLI);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $030B, $AA5C;
	{$ENDC}

{
Copy the contents of rli1 to rli2.  rli2 must already contain
pointers to structures large enough to hold copies of the corresponding
fields from rli1.  A memFull error will be returned if that is not the case.
So if you allocate a brand new empty destination, you must at least set up
its length fields.
}
FUNCTION OCECopyRLI({CONST}VAR rli1: RLI; VAR rli2: RLI): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0307, $AA5C;
	{$ENDC}

{
Check the equality of two RLIs.  This will take into account differences
in the case and diacriticals of the directoryName and the PathName.
NOTE THAT THIS WILL FAIL IF rli1 CONTAINS A DNODENUMBER AND A NIL PATHNAME,
AND rli2 CONTAINS kNULLDNodeNumber AND A NON-NIL PATHNAME.  IN OTHER WORDS,
THE TWO rlis MUST BE OF THE SAME FORM TO CHECK FOR EQUALITY.
The one exception is that if the pathname is nil, a dNodeNumber of zero and
kRootDNodeNumber will be treated as equal.
}
FUNCTION OCEEqualRLI({CONST}VAR rli1: RLI; {CONST}VAR rli2: RLI): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0315, $AA5C;
	{$ENDC}

{
Check the validity of an RLI.  This checks that the catalog name length
is within bounds, and the packed pathname (if specified) is valid.
}
FUNCTION OCEValidRLI({CONST}VAR theRLI: RLI): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0337, $AA5C;
	{$ENDC}
{*** PackedRLI ***}
{
struct PackedRLI is a maximum-sized structure.  Allocate one of
these and it will hold any valid packed pathname.
}

CONST
	kRLIMaxBytes				= 1296;


TYPE
	PackedRLIPtr = ^PackedRLI;
	PackedRLI = RECORD
		dataLength:				UInt16;									{  dataLength excludes the space for the dataLength field  }
		data:					PACKED ARRAY [0..1295] OF Byte;
	END;

{
struct ProtoPackedRLI is a minimum-sized structure.  Use this
for a variable-length packed RLI.
}
	ProtoPackedRLIPtr = ^ProtoPackedRLI;
	ProtoPackedRLI = RECORD
		dataLength:				UInt16;									{  dataLength excludes the space for the dataLength field  }
																		{  Followed by data  }
	END;

{
Copy the contents of prli1 to prli2.  prli2Length is the size of prli2, and must
be large enough to hold a copy of prli1.  A memFull error will be returned if that
is not the case.
}
FUNCTION OCECopyPackedRLI({CONST}VAR prli1: PackedRLI; VAR prli2: PackedRLI; prli2Length: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0305, $AA5C;
	{$ENDC}

{
OCEUnpackRLI breaks apart the prli into its components, writing pointers into
the rli structure.  NOTE THAT THE UNPACKED STRUCT CONTAINS POINTERS INTO THE
PACKED STRUCT - DON'T DELETE OR REUSE THE PACKED STRUCT UNTIL YOU ARE FINISHED
WITH THE UNPACKED STRUCT AS WELL
}
PROCEDURE OCEUnpackRLI({CONST}VAR prli: PackedRLI; VAR theRLI: RLI);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0331, $AA5C;
	{$ENDC}

{
OCEPackedRLISize computes the number of bytes of memory needed to hold a
PackedRLI manufactured from an RLI.  This length
includes the length of the length field of PackedRLI, so it
is safe to do a NewPtr (OCEPackedRLISize(...)).
}
FUNCTION OCEPackedRLISize({CONST}VAR theRLI: RLI): UInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $032A, $AA5C;
	{$ENDC}

{
OCEPackRLI packs the RLI into the storage provided as 'prli'.  prli must be
large enough to hold the packed RLI.  A memFull error will be returned if
prliLength is too small.
}
FUNCTION OCEPackRLI({CONST}VAR theRLI: RLI; VAR prli: PackedRLI; prliLength: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0324, $AA5C;
	{$ENDC}

{
OCEPackedRLIPartsSize computes the number of bytes of memory needed to hold a
PackedRLI manufactured from the parts of an RLI.  This length
includes the length of the length field of PackedRLI, so it
is safe to do a NewPtr (OCEPackedRLIPartsSize(...)).
}
FUNCTION OCEPackedRLIPartsSize({CONST}VAR dirName: DirectoryName; VAR parts: RStringPtr; nParts: UInt16): UInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0329, $AA5C;
	{$ENDC}
{
OCEPackRLIParts packs the parts of an RLI into the storage provided as 'prli'.
prli must be large enough to hold the packed RLI.  A memFull error will be returned
if prliLength is too small.
}
FUNCTION OCEPackRLIParts({CONST}VAR dirName: DirectoryName; {CONST}VAR discriminator: DirDiscriminator; dNodeNumber: DNodeNum; VAR parts: RStringPtr; nParts: UInt16; VAR prli: PackedRLI; prliLength: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0325, $AA5C;
	{$ENDC}
{
Check the equality of two packed prlis.
}
FUNCTION OCEEqualPackedRLI({CONST}VAR prli1: PackedRLI; {CONST}VAR prli2: PackedRLI): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0313, $AA5C;
	{$ENDC}

{
Check the validity of a packed RLI.  This checks that the catalog name length
is within bounds, and the packed pathname (if specified) is valid.
}
FUNCTION OCEValidPackedRLI({CONST}VAR prli: PackedRLI): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0336, $AA5C;
	{$ENDC}
{
If this packed RLI describes a Personal Catalog, this call will return a pointer
to an alias record that can be used to find the actual file.  Otherwise, it returns nil.
}
FUNCTION OCEExtractAlias({CONST}VAR prli: PackedRLI): AliasPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0318, $AA5C;
	{$ENDC}
{
This call returns a pointer to a packed RLI that represents the "Catalogs" icon, or
the root of all catalogs.  It is used in the CollabPack.
}
FUNCTION OCEGetDirectoryRootPackedRLI: PackedRLIPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0346, $AA5C;
	{$ENDC}
{*** LocalRecordID ***}

TYPE
	LocalRecordIDPtr = ^LocalRecordID;
	LocalRecordID = RECORD
		cid:					CreationID;
		recordName:				RStringPtr;
		recordType:				RStringPtr;
	END;

{ Create a LocalRecordID from a name, type, and CreationID }
PROCEDURE OCENewLocalRecordID({CONST}VAR recordName: RString; {CONST}VAR recordType: RString; {CONST}VAR cid: CreationID; VAR lRID: LocalRecordID);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $031E, $AA5C;
	{$ENDC}
{
Copy LocalRecordID lRID1 to LocalRecordID lRID2.  lRID2 must already contain
pointers to RString structures large enough to hold copies of the corresponding
fields from lRID1.  A memFull error will be returned if that is not the case.
So if you allocate a brand new empty destination, you must at least set up
its length field.
}
FUNCTION OCECopyLocalRecordID({CONST}VAR lRID1: LocalRecordID; VAR lRID2: LocalRecordID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0302, $AA5C;
	{$ENDC}

{
Check the equality of two local RIDs.
}
FUNCTION OCEEqualLocalRecordID({CONST}VAR lRID1: LocalRecordID; {CONST}VAR lRID2: LocalRecordID): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $030F, $AA5C;
	{$ENDC}
{*** ShortRecordID ***}

TYPE
	ShortRecordIDPtr = ^ShortRecordID;
	ShortRecordID = RECORD
		rli:					PackedRLIPtr;
		cid:					CreationID;
	END;

{ Create a ShortRecordID from an RLI struct and a CreationID }
PROCEDURE OCENewShortRecordID({CONST}VAR theRLI: PackedRLI; {CONST}VAR cid: CreationID; sRID: ShortRecordIDPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0321, $AA5C;
	{$ENDC}

{
Copy ShortRecordID sRID1 to ShortRecordID sRID2.  sRID2 must already contain
pointers to structures large enough to hold copies of the corresponding
fields from sRID1.  A memFull error will be returned if that is not the case.
So if you allocate a brand new empty destination, you must at least set up
its length fields.
}
FUNCTION OCECopyShortRecordID({CONST}VAR sRID1: ShortRecordID; VAR sRID2: ShortRecordID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $030A, $AA5C;
	{$ENDC}

{
Check the equality of two short RIDs.
}
FUNCTION OCEEqualShortRecordID({CONST}VAR sRID1: ShortRecordID; {CONST}VAR sRID2: ShortRecordID): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0317, $AA5C;
	{$ENDC}
{*** RecordID ***}

TYPE
	RecordIDPtr = ^RecordID;
	RecordID = RECORD
		rli:					PackedRLIPtr;							{  pointer to a packed rli structure  }
		local:					LocalRecordID;
	END;

{	Create a RecordID from a packed RLI struct and a LocalRecordID.
This doesn't allocate any new space; the RecordID points to the same
packed RLI struct and the same name and type RStrings. }
PROCEDURE OCENewRecordID({CONST}VAR theRLI: PackedRLI; {CONST}VAR lRID: LocalRecordID; VAR rid: RecordID);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0320, $AA5C;
	{$ENDC}

{
Copy RecordID RID1 to RecordID RID2.  RID2 must already contain
pointers to structures large enough to hold copies of the corresponding
fields from lRID1.  A memFull error will be returned if that is not the case.
So if you allocate a brand new empty destination, you must at least set up
its length fields.
}
FUNCTION OCECopyRecordID({CONST}VAR rid1: RecordID; {CONST}VAR rid2: RecordID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0309, $AA5C;
	{$ENDC}

{	Check the equality of two RIDs. }
FUNCTION OCEEqualRecordID({CONST}VAR rid1: RecordID; {CONST}VAR rid2: RecordID): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0314, $AA5C;
	{$ENDC}

{*** PackedRecordID ***}
{
struct PackedRecordID is a maximum-sized structure.  Allocate one of
these and it will hold any valid packed RecordID.
}

CONST
	kPackedRecordIDMaxBytes		= 1824;


TYPE
	PackedRecordIDPtr = ^PackedRecordID;
	PackedRecordID = RECORD
		dataLength:				UInt16;									{  dataLength excludes the space for the dataLength field  }
		data:					PACKED ARRAY [0..1823] OF Byte;
	END;

{
struct ProtoPackedRecordID is a minimum-sized structure.  Use this
for a variable-length packed RecordID.
}
	ProtoPackedRecordIDPtr = ^ProtoPackedRecordID;
	ProtoPackedRecordID = RECORD
		dataLength:				UInt16;									{  dataLength excludes the space for the dataLength field  }
																		{  Followed by data  }
	END;

{
Copy PackedRecordID pRID1 to PackedRecordID pRID2.  pRID2 must already contain
pointers to structures large enough to hold copies of the corresponding
fields from pRID1.  A memFull error will be returned if that is not the case.
pRID2Length is the number of bytes that can be put into pRID2, not counting the
packed RecordID header.
}
FUNCTION OCECopyPackedRecordID({CONST}VAR pRID1: PackedRecordID; {CONST}VAR pRID2: PackedRecordID; pRID2Length: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0306, $AA5C;
	{$ENDC}

{
Create a RecordID from a PackedRecordID.
NOTE THAT THE UNPACKED STRUCT CONTAINS POINTERS INTO THE PACKED STRUCT - DON'T DELETE
OR REUSE THE PACKED STRUCT UNTIL YOU ARE FINISHED WITH THE UNPACKED STRUCT AS WELL
}
PROCEDURE OCEUnpackRecordID({CONST}VAR pRID: PackedRecordID; VAR rid: RecordID);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0332, $AA5C;
	{$ENDC}

{
Create a PackedRecordID from a RecordID.  pRID must be large enough to contain
the packed RecordID.  A memFull error will be returned if that is not the case.
packedRecordIDLength is the number of bytes that can be put into pRID, not
counting the header.
}
FUNCTION OCEPackRecordID({CONST}VAR rid: RecordID; VAR pRID: PackedRecordID; packedRecordIDLength: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0326, $AA5C;
	{$ENDC}

{
Compute the number of bytes of memory needed to hold a RecordID when packed. This
length includes the length of the length field of PackedRecordID, so it
is safe to do a NewPtr (OCEPackedRecordIDSize(...)).
}
FUNCTION OCEPackedRecordIDSize({CONST}VAR rid: RecordID): UInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $032B, $AA5C;
	{$ENDC}

{
Check the equality of two packed RIDs.
}
FUNCTION OCEEqualPackedRecordID({CONST}VAR pRID1: PackedRecordID; {CONST}VAR pRID2: PackedRecordID): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0312, $AA5C;
	{$ENDC}

{ OCEValidPackedRecordID checks the validity of a packed record ID. }
FUNCTION OCEValidPackedRecordID({CONST}VAR pRID: PackedRecordID): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0335, $AA5C;
	{$ENDC}

{*** DSSpec ***}

TYPE
	DSSpecPtr = ^DSSpec;
	DSSpec = RECORD
		entitySpecifier:		RecordIDPtr;
		extensionType:			OSType;
		extensionSize:			UInt16;
		extensionValue:			Ptr;
	END;

{
struct PackedDSSpec is NOT a maximum-sized structure.  Allocate one of
these and it will hold any valid packed RecordID, but not necessarily any additional
data.
}


CONST
	kPackedDSSpecMaxBytes		= 1832;


TYPE
	PackedDSSpecPtr = ^PackedDSSpec;
	PackedDSSpec = RECORD
		dataLength:				UInt16;									{  dataLength excludes the space for the dataLength field  }
		data:					PACKED ARRAY [0..1831] OF Byte;
	END;

	PackedDSSpecHandle					= ^PackedDSSpecPtr;
{
struct ProtoPackedDSSpec is a minimum-sized structure.  Use this
for a variable-length packed DSSpec.
}
	ProtoPackedDSSpecPtr = ^ProtoPackedDSSpec;
	ProtoPackedDSSpec = RECORD
		dataLength:				UInt16;									{  dataLength excludes the space for the dataLength field  }
																		{  Followed by data  }
	END;

{
Copy PackedDSSpec pdss1 to PackedDSSpec pdss2.  pdss2 must already contain
pointers to structures large enough to hold copies of the corresponding
fields from pdss1.  A memFull error will be returned if that is not the case.
pdss2Length is the number of bytes that can be put into pdss2, not counting the
packed DSSpec header.
}
FUNCTION OCECopyPackedDSSpec({CONST}VAR pdss1: PackedDSSpec; {CONST}VAR pdss2: PackedDSSpec; pdss2Length: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0303, $AA5C;
	{$ENDC}

{
Create a DSSpec from a PackedDSSpec.
NOTE THAT THE UNPACKED STRUCT CONTAINS POINTERS INTO THE PACKED STRUCT - DON'T DELETE
OR REUSE THE PACKED STRUCT UNTIL YOU ARE FINISHED WITH THE UNPACKED STRUCT AS WELL.
A pointer to the extension is returned in dss->extensionValue, and the length of that
extension is returned in dss->extensionSize.  If there is no extension, dss->extensionValue will
be set to nil.  This routine will unpack the RecordID (if any) into rid, unpack the rest
into dss, and set dss->entitySpecifier to rid.
}
PROCEDURE OCEUnpackDSSpec({CONST}VAR pdss: PackedDSSpec; VAR dss: DSSpec; VAR rid: RecordID);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $032F, $AA5C;
	{$ENDC}

{
Create a PackedDSSpec from a DSSpec.  pdss must be large enough to
contain the packed RecordID and any extension.  A memFull error will be returned if that
is not the case.  pdssLength is the number of bytes that can be put into pdss,
not counting the header.
}
FUNCTION OCEPackDSSpec({CONST}VAR dss: DSSpec; VAR pdss: PackedDSSpec; pdssLength: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0322, $AA5C;
	{$ENDC}

{
Compute the number of bytes of memory needed to hold a DSSpec when packed. This
length includes the length of the length field of PackedDSSpec, so it
is safe to do a NewPtr (OCEPackedDSSpecSize(...)).
}
FUNCTION OCEPackedDSSpecSize({CONST}VAR dss: DSSpec): UInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0327, $AA5C;
	{$ENDC}

{	Check the equality of two DSSpecs.  This compares all fields, even the
extension (unless extensionSize == 0).  The extensions are compared in a case-insensitive and
diacrit-insensitive manner. }
FUNCTION OCEEqualDSSpec({CONST}VAR pdss1: DSSpec; {CONST}VAR pdss2: DSSpec): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $030E, $AA5C;
	{$ENDC}

{	Check the equality of two PackedDSSpecs.  This compares all fields, even the
extension (unless extensionSize == 0).  The extensions are compared in a case-insensitive and
diacrit-insensitive manner. }
FUNCTION OCEEqualPackedDSSpec({CONST}VAR pdss1: PackedDSSpec; {CONST}VAR pdss2: PackedDSSpec): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0310, $AA5C;
	{$ENDC}

{
Check the validity of a PackedDSSpec.  If extensionType is
'entn', pdss must contain a valid entitySpecifier.  For all other extensionTypes, a nil
entitySpecifier is valid, but if non-nil, it will be checked for validity.  No check
is made on the extension.
}
FUNCTION OCEValidPackedDSSpec({CONST}VAR pdss: PackedDSSpec): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0333, $AA5C;
	{$ENDC}

{
Return info about a DSSpec.  This routine does not check validity.  If the
DSSpec has no extension, we determine whether it represents the root of all
catalogs, a single catalog, a DNode, or a Record.  Else it is invalid.
If the DSSpec has an extension, we simply return the extension type.
}
FUNCTION OCEGetDSSpecInfo({CONST}VAR spec: DSSpec): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0319, $AA5C;
	{$ENDC}

{ OCEGetExtensionType returns the extensionType imbedded in the PackedDSSpec. }
FUNCTION OCEGetExtensionType({CONST}VAR pdss: PackedDSSpec): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $031C, $AA5C;
	{$ENDC}
{
OCEStreamPackedDSSpec streams (flattens) a catalog object a little at a time by
calling the DSSpecStreamer routine that you provide.
}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	DSSpecStreamerProcPtr = FUNCTION(buffer: UNIV Ptr; count: UInt32; eof: BOOLEAN; userData: LONGINT): OSErr;
{$ELSEC}
	DSSpecStreamerProcPtr = ProcPtr;
{$ENDC}

	DSSpecStreamerUPP = UniversalProcPtr;

CONST
	uppDSSpecStreamerProcInfo = $000037E0;

FUNCTION NewDSSpecStreamerProc(userRoutine: DSSpecStreamerProcPtr): DSSpecStreamerUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallDSSpecStreamerProc(buffer: UNIV Ptr; count: UInt32; eof: BOOLEAN; userData: LONGINT; userRoutine: DSSpecStreamerUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	DSSpecStreamer						= DSSpecStreamerUPP;
FUNCTION OCEStreamPackedDSSpec({CONST}VAR dss: DSSpec; stream: DSSpecStreamer; userData: LONGINT; VAR actualCount: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $033D, $AA5C;
	{$ENDC}
{*** AttributeType ***}
{
For the record, an AttributeType is an RString with a smaller maximum size.
I don't just typedef it to an RString, because I want the definition of the AttributeType
struct to contain the max length, because I need to include it in the Attribute struct
below.  But it should be possible to typecast any AttributeType to an RString and use
all the RString utilities on it.
}

TYPE
	AttributeTypePtr = ^AttributeType;
	AttributeType = RECORD
		charSet:				CharacterSet;
		dataLength:				UInt16;
		body:					PACKED ARRAY [0..31] OF Byte;			{  always fixed at the max size  }
	END;

{ Miscellaneous defines:  (these cannot be made into enums) }

CONST
	kMinPackedRStringLength		= 4;

	kMinPackedRLISize			= 20;

{*** AttributeValue ***}
{ same class as is used in AppleEvents }

TYPE
	AttributeTag						= DescType;
	AttributeValuePtr = ^AttributeValue;
	AttributeValue = RECORD
		tag:					AttributeTag;
		dataLength:				UInt32;
		bytes:					Ptr;
	END;

{*** Attribute ***}
	AttributePtr = ^Attribute;
	Attribute = RECORD
		attributeType:			AttributeType;
		cid:					AttributeCreationID;
		value:					AttributeValue;
	END;

FUNCTION OCEGetIndRecordType(stringIndex: OCERecordTypeIndex): RStringPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $031B, $AA5C;
	{$ENDC}
FUNCTION OCEGetIndAttributeType(stringIndex: OCEAttributeTypeIndex): AttributeTypePtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $031A, $AA5C;
	{$ENDC}

CONST
	_oceTBDispatch				= $AA5E;

{***************************************************************************************
   PLEASE NOTE! ROUTINES HAVE MOVED TO THIS HEADER!
 
   OCESizePackedRecipient, OCEPackRecipient, OCEUnpackRecipient, OCEStreamRecipient,
   OCEGetRecipientType, and OCESetRecipientType have moved to the OCE header file.
   The OCEMessaging header includes the OCE header, so no changes to your code are
   required.

***************************************************************************************}

TYPE
	OCERecipient						= DSSpec;
	OCERecipientPtr 					= ^OCERecipient;

CONST
	kOCESizePackedRecipient		= 830;
	kOCEPackRecipient			= 831;
	kOCEUnpackRecipient			= 832;
	kOCEStreamRecipient			= 833;
	kOCEGetRecipientType		= 834;
	kOCESetRecipientType		= 835;

{
Compute the space that a OCERecipient would take if it were in packed
form.  [Note: does NOT even pad extensionSize, so you may get an odd #back out]
Safe to pass dereferenced handle(s).
}
FUNCTION OCESizePackedRecipient({CONST}VAR rcpt: OCERecipient): UInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $033E, $AA5C;
	{$ENDC}

{
Take an OCERecipient (scatter) and (gather) stream into the specified
buffer.  It is assumed that there is sufficient space in the buffer (that is
OCESizePackedRecipient).  Safe to pass dereferenced handle(s).
}
FUNCTION OCEPackRecipient({CONST}VAR rcpt: OCERecipient; buffer: UNIV Ptr): UInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $033F, $AA5C;
	{$ENDC}
{
Take a packed OCERecipient and cast a the OCERecipient frame over it. Returns
amBadDestId if it doesn't look like an OCERecipient. Safe to pass dereferenced
handle(s).
}
FUNCTION OCEUnpackRecipient(buffer: UNIV Ptr; VAR rcpt: OCERecipient; VAR entitySpecifier: RecordID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0340, $AA5C;
	{$ENDC}
{
Take an OCERecipient (scatter) and (gather) stream using the specified
function.  Safe to pass dereferenced handle(s).  If streamer function returns
OCEError OCEStreamRecipient stops execution and passes the error back to the caller
}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	OCERecipientStreamerProcPtr = FUNCTION(buffer: UNIV Ptr; count: UInt32; eof: BOOLEAN; userData: LONGINT): OSErr;
{$ELSEC}
	OCERecipientStreamerProcPtr = ProcPtr;
{$ENDC}

	OCERecipientStreamerUPP = UniversalProcPtr;

CONST
	uppOCERecipientStreamerProcInfo = $000037E0;

FUNCTION NewOCERecipientStreamerProc(userRoutine: OCERecipientStreamerProcPtr): OCERecipientStreamerUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallOCERecipientStreamerProc(buffer: UNIV Ptr; count: UInt32; eof: BOOLEAN; userData: LONGINT; userRoutine: OCERecipientStreamerUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	OCERecipientStreamer				= OCERecipientStreamerUPP;
FUNCTION OCEStreamRecipient({CONST}VAR rcpt: OCERecipient; stream: OCERecipientStreamer; userData: LONGINT; VAR actualCount: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0341, $AA5C;
	{$ENDC}
{ Get the OCERecipient's extensionType. Safe to pass dereferenced handle(s).}
FUNCTION OCEGetRecipientType({CONST}VAR cid: CreationID): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0342, $AA5C;
	{$ENDC}

{
Set the OCERecipient's extensionType in the specified cid.  (Note: we do NOT
check for a nil pointer).  If the extensionType is 'entn', the cid is assumed
to be "valid" and is not touched.  Note: to properly handle non 'entn''s this
routine must and will zero the high long (source) of the cid! Safe to pass
dereferenced handle(s).
}
PROCEDURE OCESetRecipientType(extensionType: OSType; VAR cid: CreationID);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0343, $AA5C;
	{$ENDC}
{***************************************************************************************
   PLEASE NOTE! ROUTINES HAVE MOVED TO THIS HEADER!
 
   OCEGetAccessControlDSSpec and its corresponding data type and constants have
   moved to the OCE header from OCEAuthDir. The OCEAuthDir header includes the OCE
   header, so no changes to your code are required.
   
***************************************************************************************}
{ access categories bit numbers }

CONST
	kThisRecordOwnerBit			= 0;
	kFriendsBit					= 1;
	kAuthenticatedInDNodeBit	= 2;
	kAuthenticatedInDirectoryBit = 3;
	kGuestBit					= 4;
	kMeBit						= 5;

{ Values of CategoryMask }
	kThisRecordOwnerMask		= 1;
	kFriendsMask				= 2;
	kAuthenticatedInDNodeMask	= 4;
	kAuthenticatedInDirectoryMask = 8;
	kGuestMask					= 16;
	kMeMask						= 32;


TYPE
	CategoryMask						= UInt32;
{
pass kThisRecordOwnerMask, kFriendsMask, kAuthenticatedInDNodeMask, kAuthenticatedInDirectoryMask,
kGuestMask, or kMeMask to this routine, and it will return a pointer to a
DSSpec that can be used in the Get or Set Access Controls calls.
}
FUNCTION OCEGetAccessControlDSSpec(categoryBitMask: CategoryMask): DSSpecPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0345, $AA5C;
	{$ENDC}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OCEIncludes}

{$ENDC} {__OCE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
