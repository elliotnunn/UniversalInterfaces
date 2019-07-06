{
     File:       Keychain.p
 
     Contains:   Keychain Interfaces.
 
     Version:    Technology: Keychain 2.0
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1997-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Keychain;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __KEYCHAIN__}
{$SETC __KEYCHAIN__ := 1}

{$I+}
{$SETC KeychainIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __PROCESSES__}
{$I Processes.p}
{$ENDC}
{$IFC UNDEFINED __ALIASES__}
{$I Aliases.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __DATETIMEUTILS__}
{$I DateTimeUtils.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
{$ENDC}
{$IFC UNDEFINED __CFDATE__}
{$I CFDate.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Data structures and types }

TYPE
	KCRef = ^LONGINT; { an opaque 32-bit type }
	KCItemRef = ^LONGINT; { an opaque 32-bit type }
	KCSearchRef = ^LONGINT; { an opaque 32-bit type }
	SecOIDRef							= CFDataRef;

CONST
	kIdleKCEvent				= 0;							{  null event  }
	kLockKCEvent				= 1;							{  a keychain was locked  }
	kUnlockKCEvent				= 2;							{  a keychain was unlocked  }
	kAddKCEvent					= 3;							{  an item was added to a keychain  }
	kDeleteKCEvent				= 4;							{  an item was deleted from a keychain  }
	kUpdateKCEvent				= 5;							{  an item was updated  }
	kChangeIdentityKCEvent		= 6;							{  the keychain identity was changed  }
	kFindKCEvent				= 7;							{  an item was found  }
	kSystemKCEvent				= 8;							{  the keychain client can process events  }
	kDefaultChangedKCEvent		= 9;							{  the default keychain was changed  }
	kDataAccessKCEvent			= 10;							{  a process has accessed a keychain item's data  }


TYPE
	KCEvent								= UInt16;

CONST
	kIdleKCEventMask			= $01;
	kLockKCEventMask			= $02;
	kUnlockKCEventMask			= $04;
	kAddKCEventMask				= $08;
	kDeleteKCEventMask			= $10;
	kUpdateKCEventMask			= $20;
	kChangeIdentityKCEventMask	= $40;
	kFindKCEventMask			= $80;
	kSystemEventKCEventMask		= $0100;
	kDefaultChangedKCEventMask	= $0200;
	kDataAccessKCEventMask		= $0400;
	kEveryKCEventMask			= $FFFF;						{  all of the above }


TYPE
	KCEventMask							= UInt16;
	AFPServerSignature					= PACKED ARRAY [0..15] OF UInt8;
	KCPublicKeyHash						= PACKED ARRAY [0..19] OF UInt8;
	KCAttrType							= OSType;
	KCCallbackInfoPtr = ^KCCallbackInfo;
	KCCallbackInfo = RECORD
		version:				UInt32;
		item:					KCItemRef;
		processID:				ProcessSerialNumber;
		event:					EventRecord;
		keychain:				KCRef;
	END;


CONST
	kUnlockStateKCStatus		= 1;
	kRdPermKCStatus				= 2;
	kWrPermKCStatus				= 4;


TYPE
	KCStatus							= UInt32;

CONST
	kCertificateKCItemClass		= 'cert';						{  Certificate  }
	kAppleSharePasswordKCItemClass = 'ashp';					{  Appleshare password  }
	kInternetPasswordKCItemClass = 'inet';						{  Internet password  }
	kGenericPasswordKCItemClass	= 'genp';						{  Generic password  }


TYPE
	KCItemClass							= FourCharCode;

CONST
																{  Common attributes  }
	kClassKCItemAttr			= 'clas';						{  Item class (KCItemClass)  }
	kCreationDateKCItemAttr		= 'cdat';						{  Date the item was created (UInt32)  }
	kModDateKCItemAttr			= 'mdat';						{  Last time the item was updated (UInt32)  }
	kDescriptionKCItemAttr		= 'desc';						{  User-visible description string (string)  }
	kCommentKCItemAttr			= 'icmt';						{  User's comment about the item (string)  }
	kCreatorKCItemAttr			= 'crtr';						{  Item's creator (OSType)  }
	kTypeKCItemAttr				= 'type';						{  Item's type (OSType)  }
	kScriptCodeKCItemAttr		= 'scrp';						{  Script code for all strings (ScriptCode)  }
	kLabelKCItemAttr			= 'labl';						{  Item label (string)  }
	kInvisibleKCItemAttr		= 'invi';						{  Invisible (boolean)  }
	kNegativeKCItemAttr			= 'nega';						{  Negative (boolean)  }
	kCustomIconKCItemAttr		= 'cusi';						{  Custom icon (boolean)  }
																{  Unique Generic password attributes  }
	kAccountKCItemAttr			= 'acct';						{  User account (Str63) - also applies to Appleshare and Generic  }
	kServiceKCItemAttr			= 'svce';						{  Service (Str63)  }
	kGenericKCItemAttr			= 'gena';						{  User-defined attribute (untyped bytes)  }
																{  Unique Internet password attributes  }
	kSecurityDomainKCItemAttr	= 'sdmn';						{  Security domain (Str63)  }
	kServerKCItemAttr			= 'srvr';						{  Server's domain name or IP address (string)  }
	kAuthTypeKCItemAttr			= 'atyp';						{  Authentication Type (KCAuthType)  }
	kPortKCItemAttr				= 'port';						{  Port (UInt16)  }
	kPathKCItemAttr				= 'path';						{  Path (Str255)  }
																{  Unique Appleshare password attributes  }
	kVolumeKCItemAttr			= 'vlme';						{  Volume (Str63)  }
	kAddressKCItemAttr			= 'addr';						{  Server address (IP or domain name) or zone name (string)  }
	kSignatureKCItemAttr		= 'ssig';						{  Server signature block (AFPServerSignature)  }
																{  Unique AppleShare and Internet attributes  }
	kProtocolKCItemAttr			= 'ptcl';						{  Protocol (KCProtocolType)  }
																{  Certificate attributes  }
	kSubjectKCItemAttr			= 'subj';						{  Subject distinguished name (DER-encoded data)  }
	kCommonNameKCItemAttr		= 'cn  ';						{  Common Name (UTF8-encoded string)  }
	kIssuerKCItemAttr			= 'issu';						{  Issuer distinguished name (DER-encoded data)  }
	kSerialNumberKCItemAttr		= 'snbr';						{  Certificate serial number (DER-encoded data)  }
	kEMailKCItemAttr			= 'mail';						{  E-mail address (ASCII-encoded string)  }
	kPublicKeyHashKCItemAttr	= 'hpky';						{  Hash of public key (KCPublicKeyHash), 20 bytes max.  }
	kIssuerURLKCItemAttr		= 'iurl';						{  URL of the certificate issuer (ASCII-encoded string)  }
																{  Shared by keys and certificates  }
	kEncryptKCItemAttr			= 'encr';						{  Encrypt (Boolean)  }
	kDecryptKCItemAttr			= 'decr';						{  Decrypt (Boolean)  }
	kSignKCItemAttr				= 'sign';						{  Sign (Boolean)  }
	kVerifyKCItemAttr			= 'veri';						{  Verify (Boolean)  }
	kWrapKCItemAttr				= 'wrap';						{  Wrap (Boolean)  }
	kUnwrapKCItemAttr			= 'unwr';						{  Unwrap (Boolean)  }
	kStartDateKCItemAttr		= 'sdat';						{  Start Date (UInt32)  }
	kEndDateKCItemAttr			= 'edat';						{  End Date (UInt32)  }


TYPE
	KCItemAttr							= FourCharCode;
	KCAttributePtr = ^KCAttribute;
	KCAttribute = RECORD
		tag:					KCAttrType;								{  4-byte attribute tag  }
		length:					UInt32;									{  Length of attribute data  }
		data:					Ptr;									{  Pointer to attribute data  }
	END;

	KCAttributeListPtr = ^KCAttributeList;
	KCAttributeList = RECORD
		count:					UInt32;									{  How many attributes in the array  }
		attr:					KCAttributePtr;							{  Pointer to first attribute in array  }
	END;


CONST
	kKCAuthTypeNTLM				= 'ntlm';
	kKCAuthTypeMSN				= 'msna';
	kKCAuthTypeDPA				= 'dpaa';
	kKCAuthTypeRPA				= 'rpaa';
	kKCAuthTypeHTTPDigest		= 'httd';
	kKCAuthTypeDefault			= 'dflt';


TYPE
	KCAuthType							= FourCharCode;

CONST
	kKCProtocolTypeFTP			= 'ftp ';
	kKCProtocolTypeFTPAccount	= 'ftpa';
	kKCProtocolTypeHTTP			= 'http';
	kKCProtocolTypeIRC			= 'irc ';
	kKCProtocolTypeNNTP			= 'nntp';
	kKCProtocolTypePOP3			= 'pop3';
	kKCProtocolTypeSMTP			= 'smtp';
	kKCProtocolTypeSOCKS		= 'sox ';
	kKCProtocolTypeIMAP			= 'imap';
	kKCProtocolTypeLDAP			= 'ldap';
	kKCProtocolTypeAppleTalk	= 'atlk';
	kKCProtocolTypeAFP			= 'afp ';
	kKCProtocolTypeTelnet		= 'teln';


TYPE
	KCProtocolType						= FourCharCode;

CONST
	kSecOptionReserved			= $000000FF;					{  First byte reserved for SecOptions flags  }
	kCertUsageShift				= 8;							{  start at bit 8  }
	kCertUsageSigningAdd		= $0100;
	kCertUsageSigningAskAndAdd	= $0200;
	kCertUsageVerifyAdd			= $0400;
	kCertUsageVerifyAskAndAdd	= $0800;
	kCertUsageEncryptAdd		= $1000;
	kCertUsageEncryptAskAndAdd	= $2000;
	kCertUsageDecryptAdd		= $4000;
	kCertUsageDecryptAskAndAdd	= $8000;
	kCertUsageKeyExchAdd		= $00010000;
	kCertUsageKeyExchAskAndAdd	= $00020000;
	kCertUsageRootAdd			= $00040000;
	kCertUsageRootAskAndAdd		= $00080000;
	kCertUsageSSLAdd			= $00100000;
	kCertUsageSSLAskAndAdd		= $00200000;
	kCertUsageAllAdd			= $7FFFFF00;


TYPE
	KCCertAddOptions					= UInt32;

CONST
	kPolicyKCStopOn				= 0;
	kNoneKCStopOn				= 1;
	kFirstPassKCStopOn			= 2;
	kFirstFailKCStopOn			= 3;


TYPE
	KCVerifyStopOn						= UInt16;

CONST
	kCertSearchShift			= 0;							{  start at bit 0  }
	kCertSearchSigningIgnored	= 0;
	kCertSearchSigningAllowed	= $01;
	kCertSearchSigningDisallowed = $02;
	kCertSearchSigningMask		= $03;
	kCertSearchVerifyIgnored	= 0;
	kCertSearchVerifyAllowed	= $04;
	kCertSearchVerifyDisallowed	= $08;
	kCertSearchVerifyMask		= $0C;
	kCertSearchEncryptIgnored	= 0;
	kCertSearchEncryptAllowed	= $10;
	kCertSearchEncryptDisallowed = $20;
	kCertSearchEncryptMask		= $30;
	kCertSearchDecryptIgnored	= 0;
	kCertSearchDecryptAllowed	= $40;
	kCertSearchDecryptDisallowed = $80;
	kCertSearchDecryptMask		= $C0;
	kCertSearchWrapIgnored		= 0;
	kCertSearchWrapAllowed		= $0100;
	kCertSearchWrapDisallowed	= $0200;
	kCertSearchWrapMask			= $0300;
	kCertSearchUnwrapIgnored	= 0;
	kCertSearchUnwrapAllowed	= $0400;
	kCertSearchUnwrapDisallowed	= $0800;
	kCertSearchUnwrapMask		= $0C00;
	kCertSearchPrivKeyRequired	= $1000;
	kCertSearchAny				= 0;


TYPE
	KCCertSearchOptions					= UInt32;
{ Other constants }


{
    Keychain is not in CarbonLib 1.0.2.  But, it is possible to still use 
    keychain on OS 8/9 in a CarbonLib based application, by setting  
    CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON to 1 on the command line or in a prefix
    file, weaklinking with KeychainLib, and testing for its existance 
    at runtime.
}
{$IFC UNDEFINED CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON }
{$SETC CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON := CALL_NOT_IN_CARBON }
{$ENDC}  {CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON}



{ Opening and getting information about the Keychain Manager }
FUNCTION KCGetKeychainManagerVersion(VAR returnVers: UInt32): OSStatus;
{$IFC TARGET_RT_MAC_CFM }
{
        KeychainManagerAvailable() is a macro/inline available only in C/C++.  
        To get the same functionality from pascal or assembly, you need
        to test if KCGetKeychainManagerVersion function is not NULL.  For instance:
        
            gKeychainManagerAvailable = FALSE;
            IF @KCGetKeychainManagerVersion <> kUnresolvedCFragSymbolAddress THEN
                gKeychainManagerAvailable = TRUE;
            END
    
    }
{$ELSEC}
  {$IFC TARGET_RT_MAC_MACHO }
  {$ELSEC}
  {$IFC CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON }
FUNCTION KeychainManagerAvailable: BOOLEAN;
  {$ENDC}  {CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON}
  {$ENDC}
{$ENDC}

{ Creating references to keychains }
{$IFC CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON }
FUNCTION KCMakeKCRefFromFSSpec(VAR keychainFSSpec: FSSpec; VAR keychain: KCRef): OSStatus;
FUNCTION KCMakeKCRefFromAlias(keychainAlias: AliasHandle; VAR keychain: KCRef): OSStatus;
FUNCTION KCMakeAliasFromKCRef(keychain: KCRef; VAR keychainAlias: AliasHandle): OSStatus;
FUNCTION KCReleaseKeychain(VAR keychain: KCRef): OSStatus;
{ Locking and unlocking a keychain }
FUNCTION KCUnlock(keychain: KCRef; password: StringPtr): OSStatus;
FUNCTION KCLock(keychain: KCRef): OSStatus;
{ Specifying the default keychain }
FUNCTION KCGetDefaultKeychain(VAR keychain: KCRef): OSStatus;
FUNCTION KCSetDefaultKeychain(keychain: KCRef): OSStatus;
{ Creating a new keychain }
FUNCTION KCCreateKeychain(password: StringPtr; VAR keychain: KCRef): OSStatus;
{ Getting information about a keychain }
FUNCTION KCGetStatus(keychain: KCRef; VAR keychainStatus: UInt32): OSStatus;
FUNCTION KCGetKeychain(item: KCItemRef; VAR keychain: KCRef): OSStatus;
FUNCTION KCGetKeychainName(keychain: KCRef; keychainName: StringPtr): OSStatus;
FUNCTION KCChangeSettings(keychain: KCRef): OSStatus;
{ Enumerating available keychains }
FUNCTION KCCountKeychains: UInt16;
FUNCTION KCGetIndKeychain(index: UInt16; VAR keychain: KCRef): OSStatus;
{$ENDC}  {CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	KCCallbackProcPtr = FUNCTION(keychainEvent: KCEvent; VAR info: KCCallbackInfo; userContext: UNIV Ptr): OSStatus;
{$ELSEC}
	KCCallbackProcPtr = ProcPtr;
{$ENDC}

	KCCallbackUPP = UniversalProcPtr;

CONST
	uppKCCallbackProcInfo = $00000FB0;
{$IFC CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON }

FUNCTION NewKCCallbackUPP(userRoutine: KCCallbackProcPtr): KCCallbackUPP; { old name was NewKCCallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeKCCallbackUPP(userUPP: KCCallbackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeKCCallbackUPP(keychainEvent: KCEvent; VAR info: KCCallbackInfo; userContext: UNIV Ptr; userRoutine: KCCallbackUPP): OSStatus; { old name was CallKCCallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON}

{ Keychain Manager callbacks }
{$IFC CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON }
FUNCTION KCAddCallback(callbackProc: KCCallbackUPP; eventMask: KCEventMask; userContext: UNIV Ptr): OSStatus;
FUNCTION KCRemoveCallback(callbackProc: KCCallbackUPP): OSStatus;
{ Managing the Human Interface }
FUNCTION KCSetInteractionAllowed(state: BOOLEAN): OSStatus;
FUNCTION KCIsInteractionAllowed: BOOLEAN;
{ Storing and retrieving AppleShare passwords }
FUNCTION KCAddAppleSharePassword(VAR serverSignature: AFPServerSignature; serverAddress: StringPtr; serverName: StringPtr; volumeName: StringPtr; accountName: StringPtr; passwordLength: UInt32; passwordData: UNIV Ptr; VAR item: KCItemRef): OSStatus;
FUNCTION KCFindAppleSharePassword(VAR serverSignature: AFPServerSignature; serverAddress: StringPtr; serverName: StringPtr; volumeName: StringPtr; accountName: StringPtr; maxLength: UInt32; passwordData: UNIV Ptr; VAR actualLength: UInt32; VAR item: KCItemRef): OSStatus;
{ Storing and retrieving Internet passwords }
FUNCTION KCAddInternetPassword(serverName: StringPtr; securityDomain: StringPtr; accountName: StringPtr; port: UInt16; protocol: OSType; authType: OSType; passwordLength: UInt32; passwordData: UNIV Ptr; VAR item: KCItemRef): OSStatus;
FUNCTION KCAddInternetPasswordWithPath(serverName: StringPtr; securityDomain: StringPtr; accountName: StringPtr; path: StringPtr; port: UInt16; protocol: OSType; authType: OSType; passwordLength: UInt32; passwordData: UNIV Ptr; VAR item: KCItemRef): OSStatus;
FUNCTION KCFindInternetPassword(serverName: StringPtr; securityDomain: StringPtr; accountName: StringPtr; port: UInt16; protocol: OSType; authType: OSType; maxLength: UInt32; passwordData: UNIV Ptr; VAR actualLength: UInt32; VAR item: KCItemRef): OSStatus;
FUNCTION KCFindInternetPasswordWithPath(serverName: StringPtr; securityDomain: StringPtr; accountName: StringPtr; path: StringPtr; port: UInt16; protocol: OSType; authType: OSType; maxLength: UInt32; passwordData: UNIV Ptr; VAR actualLength: UInt32; VAR item: KCItemRef): OSStatus;
{ Storing and retrieving other types of passwords }
FUNCTION KCAddGenericPassword(serviceName: StringPtr; accountName: StringPtr; passwordLength: UInt32; passwordData: UNIV Ptr; VAR item: KCItemRef): OSStatus;
FUNCTION KCFindGenericPassword(serviceName: StringPtr; accountName: StringPtr; maxLength: UInt32; passwordData: UNIV Ptr; VAR actualLength: UInt32; VAR item: KCItemRef): OSStatus;
{ Creating and editing a keychain item }
FUNCTION KCNewItem(itemClass: KCItemClass; itemCreator: OSType; length: UInt32; data: UNIV Ptr; VAR item: KCItemRef): OSStatus;
FUNCTION KCSetAttribute(item: KCItemRef; VAR attr: KCAttribute): OSStatus;
FUNCTION KCGetAttribute(item: KCItemRef; VAR attr: KCAttribute; VAR actualLength: UInt32): OSStatus;
FUNCTION KCSetData(item: KCItemRef; length: UInt32; data: UNIV Ptr): OSStatus;
FUNCTION KCGetData(item: KCItemRef; maxLength: UInt32; data: UNIV Ptr; VAR actualLength: UInt32): OSStatus;
{ Managing keychain items }
FUNCTION KCAddItem(item: KCItemRef): OSStatus;
FUNCTION KCDeleteItem(item: KCItemRef): OSStatus;
FUNCTION KCUpdateItem(item: KCItemRef): OSStatus;
FUNCTION KCReleaseItem(VAR item: KCItemRef): OSStatus;
FUNCTION KCCopyItem(item: KCItemRef; destKeychain: KCRef; VAR copy: KCItemRef): OSStatus;
{ Searching and enumerating keychain items }
FUNCTION KCFindFirstItem(keychain: KCRef; {CONST}VAR attrList: KCAttributeList; VAR search: KCSearchRef; VAR item: KCItemRef): OSStatus;
FUNCTION KCFindNextItem(search: KCSearchRef; VAR item: KCItemRef): OSStatus;
FUNCTION KCReleaseSearch(VAR search: KCSearchRef): OSStatus;
{ Working with certificates }
FUNCTION KCFindX509Certificates(keychain: KCRef; name: CFStringRef; emailAddress: CFStringRef; options: KCCertSearchOptions; VAR certificateItems: CFMutableArrayRef): OSStatus;
FUNCTION KCChooseCertificate(items: CFArrayRef; VAR certificate: KCItemRef; policyOIDs: CFArrayRef; stopOn: KCVerifyStopOn): OSStatus;

{$ENDC}  {CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := KeychainIncludes}

{$ENDC} {__KEYCHAIN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
