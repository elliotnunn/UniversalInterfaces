/*
     File:       Keychain.h
 
     Contains:   Keychain Interfaces.
 
     Version:    Technology: Keychain 2.0
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1997-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __KEYCHAIN__
#define __KEYCHAIN__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __PROCESSES__
#include <Processes.h>
#endif

#ifndef __ALIASES__
#include <Aliases.h>
#endif

#ifndef __CODEFRAGMENTS__
#include <CodeFragments.h>
#endif

#ifndef __MACERRORS__
#include <MacErrors.h>
#endif

#ifndef __DATETIMEUTILS__
#include <DateTimeUtils.h>
#endif

#ifndef __CFSTRING__
#include <CFString.h>
#endif

#ifndef __CFARRAY__
#include <CFArray.h>
#endif

#ifndef __CFDATE__
#include <CFDate.h>
#endif




#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
    #pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
    #pragma pack(2)
#endif

/* Data structures and types */
typedef struct OpaqueKCRef*             KCRef;
typedef struct OpaqueKCItemRef*         KCItemRef;
typedef struct OpaqueKCSearchRef*       KCSearchRef;
typedef CFDataRef                       SecOIDRef;
enum {
    kIdleKCEvent                = 0,                            /* null event */
    kLockKCEvent                = 1,                            /* a keychain was locked */
    kUnlockKCEvent              = 2,                            /* a keychain was unlocked */
    kAddKCEvent                 = 3,                            /* an item was added to a keychain */
    kDeleteKCEvent              = 4,                            /* an item was deleted from a keychain */
    kUpdateKCEvent              = 5,                            /* an item was updated */
    kChangeIdentityKCEvent      = 6,                            /* the keychain identity was changed */
    kFindKCEvent                = 7,                            /* an item was found */
    kSystemKCEvent              = 8,                            /* the keychain client can process events */
    kDefaultChangedKCEvent      = 9,                            /* the default keychain was changed */
    kDataAccessKCEvent          = 10                            /* a process has accessed a keychain item's data */
};

typedef UInt16                          KCEvent;
enum {
    kIdleKCEventMask            = 1 << kIdleKCEvent,
    kLockKCEventMask            = 1 << kLockKCEvent,
    kUnlockKCEventMask          = 1 << kUnlockKCEvent,
    kAddKCEventMask             = 1 << kAddKCEvent,
    kDeleteKCEventMask          = 1 << kDeleteKCEvent,
    kUpdateKCEventMask          = 1 << kUpdateKCEvent,
    kChangeIdentityKCEventMask  = 1 << kChangeIdentityKCEvent,
    kFindKCEventMask            = 1 << kFindKCEvent,
    kSystemEventKCEventMask     = 1 << kSystemKCEvent,
    kDefaultChangedKCEventMask  = 1 << kDefaultChangedKCEvent,
    kDataAccessKCEventMask      = 1 << kDataAccessKCEvent,
    kEveryKCEventMask           = 0xFFFF                        /* all of the above*/
};

typedef UInt16                          KCEventMask;
typedef UInt8                           AFPServerSignature[16];
typedef UInt8                           KCPublicKeyHash[20];
typedef OSType                          KCAttrType;

struct KCCallbackInfo {
    UInt32                          version;
    KCItemRef                       item;
    ProcessSerialNumber             processID;
    EventRecord                     event;
    KCRef                           keychain;
};
typedef struct KCCallbackInfo           KCCallbackInfo;
enum {
    kUnlockStateKCStatus        = 1,
    kRdPermKCStatus             = 2,
    kWrPermKCStatus             = 4
};


typedef UInt32                          KCStatus;
enum {
    kCertificateKCItemClass     = FOUR_CHAR_CODE('cert'),       /* Certificate */
    kAppleSharePasswordKCItemClass = FOUR_CHAR_CODE('ashp'),    /* Appleshare password */
    kInternetPasswordKCItemClass = FOUR_CHAR_CODE('inet'),      /* Internet password */
    kGenericPasswordKCItemClass = FOUR_CHAR_CODE('genp')        /* Generic password */
};

typedef FourCharCode                    KCItemClass;
enum {
                                                                /* Common attributes */
    kClassKCItemAttr            = FOUR_CHAR_CODE('clas'),       /* Item class (KCItemClass) */
    kCreationDateKCItemAttr     = FOUR_CHAR_CODE('cdat'),       /* Date the item was created (UInt32) */
    kModDateKCItemAttr          = FOUR_CHAR_CODE('mdat'),       /* Last time the item was updated (UInt32) */
    kDescriptionKCItemAttr      = FOUR_CHAR_CODE('desc'),       /* User-visible description string (string) */
    kCommentKCItemAttr          = FOUR_CHAR_CODE('icmt'),       /* User's comment about the item (string) */
    kCreatorKCItemAttr          = FOUR_CHAR_CODE('crtr'),       /* Item's creator (OSType) */
    kTypeKCItemAttr             = FOUR_CHAR_CODE('type'),       /* Item's type (OSType) */
    kScriptCodeKCItemAttr       = FOUR_CHAR_CODE('scrp'),       /* Script code for all strings (ScriptCode) */
    kLabelKCItemAttr            = FOUR_CHAR_CODE('labl'),       /* Item label (string) */
    kInvisibleKCItemAttr        = FOUR_CHAR_CODE('invi'),       /* Invisible (boolean) */
    kNegativeKCItemAttr         = FOUR_CHAR_CODE('nega'),       /* Negative (boolean) */
    kCustomIconKCItemAttr       = FOUR_CHAR_CODE('cusi'),       /* Custom icon (boolean) */
                                                                /* Unique Generic password attributes */
    kAccountKCItemAttr          = FOUR_CHAR_CODE('acct'),       /* User account (Str63) - also applies to Appleshare and Generic */
    kServiceKCItemAttr          = FOUR_CHAR_CODE('svce'),       /* Service (Str63) */
    kGenericKCItemAttr          = FOUR_CHAR_CODE('gena'),       /* User-defined attribute (untyped bytes) */
                                                                /* Unique Internet password attributes */
    kSecurityDomainKCItemAttr   = FOUR_CHAR_CODE('sdmn'),       /* Security domain (Str63) */
    kServerKCItemAttr           = FOUR_CHAR_CODE('srvr'),       /* Server's domain name or IP address (string) */
    kAuthTypeKCItemAttr         = FOUR_CHAR_CODE('atyp'),       /* Authentication Type (KCAuthType) */
    kPortKCItemAttr             = FOUR_CHAR_CODE('port'),       /* Port (UInt16) */
    kPathKCItemAttr             = FOUR_CHAR_CODE('path'),       /* Path (Str255) */
                                                                /* Unique Appleshare password attributes */
    kVolumeKCItemAttr           = FOUR_CHAR_CODE('vlme'),       /* Volume (Str63) */
    kAddressKCItemAttr          = FOUR_CHAR_CODE('addr'),       /* Server address (IP or domain name) or zone name (string) */
    kSignatureKCItemAttr        = FOUR_CHAR_CODE('ssig'),       /* Server signature block (AFPServerSignature) */
                                                                /* Unique AppleShare and Internet attributes */
    kProtocolKCItemAttr         = FOUR_CHAR_CODE('ptcl'),       /* Protocol (KCProtocolType) */
                                                                /* Certificate attributes */
    kSubjectKCItemAttr          = FOUR_CHAR_CODE('subj'),       /* Subject distinguished name (DER-encoded data) */
    kCommonNameKCItemAttr       = FOUR_CHAR_CODE('cn  '),       /* Common Name (UTF8-encoded string) */
    kIssuerKCItemAttr           = FOUR_CHAR_CODE('issu'),       /* Issuer distinguished name (DER-encoded data) */
    kSerialNumberKCItemAttr     = FOUR_CHAR_CODE('snbr'),       /* Certificate serial number (DER-encoded data) */
    kEMailKCItemAttr            = FOUR_CHAR_CODE('mail'),       /* E-mail address (ASCII-encoded string) */
    kPublicKeyHashKCItemAttr    = FOUR_CHAR_CODE('hpky'),       /* Hash of public key (KCPublicKeyHash), 20 bytes max. */
    kIssuerURLKCItemAttr        = FOUR_CHAR_CODE('iurl'),       /* URL of the certificate issuer (ASCII-encoded string) */
                                                                /* Shared by keys and certificates */
    kEncryptKCItemAttr          = FOUR_CHAR_CODE('encr'),       /* Encrypt (Boolean) */
    kDecryptKCItemAttr          = FOUR_CHAR_CODE('decr'),       /* Decrypt (Boolean) */
    kSignKCItemAttr             = FOUR_CHAR_CODE('sign'),       /* Sign (Boolean) */
    kVerifyKCItemAttr           = FOUR_CHAR_CODE('veri'),       /* Verify (Boolean) */
    kWrapKCItemAttr             = FOUR_CHAR_CODE('wrap'),       /* Wrap (Boolean) */
    kUnwrapKCItemAttr           = FOUR_CHAR_CODE('unwr'),       /* Unwrap (Boolean) */
    kStartDateKCItemAttr        = FOUR_CHAR_CODE('sdat'),       /* Start Date (UInt32) */
    kEndDateKCItemAttr          = FOUR_CHAR_CODE('edat')        /* End Date (UInt32) */
};

typedef FourCharCode                    KCItemAttr;

struct KCAttribute {
    KCAttrType                      tag;                        /* 4-byte attribute tag */
    UInt32                          length;                     /* Length of attribute data */
    void *                          data;                       /* Pointer to attribute data */
};
typedef struct KCAttribute              KCAttribute;
typedef KCAttribute *                   KCAttributePtr;

struct KCAttributeList {
    UInt32                          count;                      /* How many attributes in the array */
    KCAttribute *                   attr;                       /* Pointer to first attribute in array */
};
typedef struct KCAttributeList          KCAttributeList;
enum {
    kKCAuthTypeNTLM             = FOUR_CHAR_CODE('ntlm'),
    kKCAuthTypeMSN              = FOUR_CHAR_CODE('msna'),
    kKCAuthTypeDPA              = FOUR_CHAR_CODE('dpaa'),
    kKCAuthTypeRPA              = FOUR_CHAR_CODE('rpaa'),
    kKCAuthTypeHTTPDigest       = FOUR_CHAR_CODE('httd'),
    kKCAuthTypeDefault          = FOUR_CHAR_CODE('dflt')
};


typedef FourCharCode                    KCAuthType;
enum {
    kKCProtocolTypeFTP          = FOUR_CHAR_CODE('ftp '),
    kKCProtocolTypeFTPAccount   = FOUR_CHAR_CODE('ftpa'),
    kKCProtocolTypeHTTP         = FOUR_CHAR_CODE('http'),
    kKCProtocolTypeIRC          = FOUR_CHAR_CODE('irc '),
    kKCProtocolTypeNNTP         = FOUR_CHAR_CODE('nntp'),
    kKCProtocolTypePOP3         = FOUR_CHAR_CODE('pop3'),
    kKCProtocolTypeSMTP         = FOUR_CHAR_CODE('smtp'),
    kKCProtocolTypeSOCKS        = FOUR_CHAR_CODE('sox '),
    kKCProtocolTypeIMAP         = FOUR_CHAR_CODE('imap'),
    kKCProtocolTypeLDAP         = FOUR_CHAR_CODE('ldap'),
    kKCProtocolTypeAppleTalk    = FOUR_CHAR_CODE('atlk'),
    kKCProtocolTypeAFP          = FOUR_CHAR_CODE('afp '),
    kKCProtocolTypeTelnet       = FOUR_CHAR_CODE('teln')
};

typedef FourCharCode                    KCProtocolType;
enum {
    kSecOptionReserved          = 0x000000FF,                   /* First byte reserved for SecOptions flags */
    kCertUsageShift             = 8,                            /* start at bit 8 */
    kCertUsageSigningAdd        = 1 << (kCertUsageShift + 0),
    kCertUsageSigningAskAndAdd  = 1 << (kCertUsageShift + 1),
    kCertUsageVerifyAdd         = 1 << (kCertUsageShift + 2),
    kCertUsageVerifyAskAndAdd   = 1 << (kCertUsageShift + 3),
    kCertUsageEncryptAdd        = 1 << (kCertUsageShift + 4),
    kCertUsageEncryptAskAndAdd  = 1 << (kCertUsageShift + 5),
    kCertUsageDecryptAdd        = 1 << (kCertUsageShift + 6),
    kCertUsageDecryptAskAndAdd  = 1 << (kCertUsageShift + 7),
    kCertUsageKeyExchAdd        = 1 << (kCertUsageShift + 8),
    kCertUsageKeyExchAskAndAdd  = 1 << (kCertUsageShift + 9),
    kCertUsageRootAdd           = 1 << (kCertUsageShift + 10),
    kCertUsageRootAskAndAdd     = 1 << (kCertUsageShift + 11),
    kCertUsageSSLAdd            = 1 << (kCertUsageShift + 12),
    kCertUsageSSLAskAndAdd      = 1 << (kCertUsageShift + 13),
    kCertUsageAllAdd            = 0x7FFFFF00
};

typedef UInt32                          KCCertAddOptions;
enum {
    kPolicyKCStopOn             = 0,
    kNoneKCStopOn               = 1,
    kFirstPassKCStopOn          = 2,
    kFirstFailKCStopOn          = 3
};

typedef UInt16                          KCVerifyStopOn;
enum {
    kCertSearchShift            = 0,                            /* start at bit 0 */
    kCertSearchSigningIgnored   = 0,
    kCertSearchSigningAllowed   = 1 << (kCertSearchShift + 0),
    kCertSearchSigningDisallowed = 1 << (kCertSearchShift + 1),
    kCertSearchSigningMask      = ((kCertSearchSigningAllowed) | (kCertSearchSigningDisallowed)),
    kCertSearchVerifyIgnored    = 0,
    kCertSearchVerifyAllowed    = 1 << (kCertSearchShift + 2),
    kCertSearchVerifyDisallowed = 1 << (kCertSearchShift + 3),
    kCertSearchVerifyMask       = ((kCertSearchVerifyAllowed) | (kCertSearchVerifyDisallowed)),
    kCertSearchEncryptIgnored   = 0,
    kCertSearchEncryptAllowed   = 1 << (kCertSearchShift + 4),
    kCertSearchEncryptDisallowed = 1 << (kCertSearchShift + 5),
    kCertSearchEncryptMask      = ((kCertSearchEncryptAllowed) | (kCertSearchEncryptDisallowed)),
    kCertSearchDecryptIgnored   = 0,
    kCertSearchDecryptAllowed   = 1 << (kCertSearchShift + 6),
    kCertSearchDecryptDisallowed = 1 << (kCertSearchShift + 7),
    kCertSearchDecryptMask      = ((kCertSearchDecryptAllowed) | (kCertSearchDecryptDisallowed)),
    kCertSearchWrapIgnored      = 0,
    kCertSearchWrapAllowed      = 1 << (kCertSearchShift + 8),
    kCertSearchWrapDisallowed   = 1 << (kCertSearchShift + 9),
    kCertSearchWrapMask         = ((kCertSearchWrapAllowed) | (kCertSearchWrapDisallowed)),
    kCertSearchUnwrapIgnored    = 0,
    kCertSearchUnwrapAllowed    = 1 << (kCertSearchShift + 10),
    kCertSearchUnwrapDisallowed = 1 << (kCertSearchShift + 11),
    kCertSearchUnwrapMask       = ((kCertSearchUnwrapAllowed) | (kCertSearchUnwrapDisallowed)),
    kCertSearchPrivKeyRequired  = 1 << (kCertSearchShift + 12),
    kCertSearchAny              = 0
};

typedef UInt32                          KCCertSearchOptions;
/* Other constants */
#ifdef __cplusplus
const UInt16    kAnyPort        = 0;
const OSType    kAnyProtocol    = ((OSType) 0L);
const OSType    kAnyAuthType    = ((OSType) 0L);
#else
#define kAnyPort        0
#define kAnyProtocol    ((OSType) 0L)
#define kAnyAuthType    ((OSType) 0L)
#endif


/*
    Keychain is not in CarbonLib 1.0.2.  But, it is possible to still use 
    keychain on OS 8/9 in a CarbonLib based application, by setting  
    CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON to 1 on the command line or in a prefix
    file, weaklinking with KeychainLib, and testing for its existance 
    at runtime.
*/
#ifndef CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON
#define CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON CALL_NOT_IN_CARBON
#endif  /* CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON */



/* Opening and getting information about the Keychain Manager */
EXTERN_API( OSStatus )
KCGetKeychainManagerVersion     (UInt32 *               returnVers);

#if TARGET_RT_MAC_CFM
#ifdef __cplusplus
    inline pascal Boolean KeychainManagerAvailable() { return ((KCGetKeychainManagerVersion != (void*)kUnresolvedCFragSymbolAddress) && (KCGetKeychainManagerVersion(nil) != cfragNoSymbolErr)); }
#else
    #define KeychainManagerAvailable()  ((KCGetKeychainManagerVersion != (void*)kUnresolvedCFragSymbolAddress) && (KCGetKeychainManagerVersion(nil) != cfragNoSymbolErr))
#endif
#elif TARGET_RT_MAC_MACHO
/* Keychain is always available on OS X */
#ifdef __cplusplus
    inline pascal Boolean KeychainManagerAvailable() { return true; }
#else
    #define KeychainManagerAvailable()  (true)
#endif
#else
#if CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON
EXTERN_API( Boolean )
KeychainManagerAvailable        (void);

#endif  /* CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON */

#endif  /*  */

/* Creating references to keychains */
#if CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON
EXTERN_API( OSStatus )
KCMakeKCRefFromFSSpec           (FSSpec *               keychainFSSpec,
                                 KCRef *                keychain);

EXTERN_API( OSStatus )
KCMakeKCRefFromAlias            (AliasHandle            keychainAlias,
                                 KCRef *                keychain);

EXTERN_API( OSStatus )
KCMakeAliasFromKCRef            (KCRef                  keychain,
                                 AliasHandle *          keychainAlias);

EXTERN_API( OSStatus )
KCReleaseKeychain               (KCRef *                keychain);

/* Locking and unlocking a keychain */
EXTERN_API( OSStatus )
KCUnlock                        (KCRef                  keychain,
                                 StringPtr              password);

EXTERN_API( OSStatus )
KCLock                          (KCRef                  keychain);

/* Specifying the default keychain */
EXTERN_API( OSStatus )
KCGetDefaultKeychain            (KCRef *                keychain);

EXTERN_API( OSStatus )
KCSetDefaultKeychain            (KCRef                  keychain);

/* Creating a new keychain */
EXTERN_API( OSStatus )
KCCreateKeychain                (StringPtr              password,
                                 KCRef *                keychain);

/* Getting information about a keychain */
EXTERN_API( OSStatus )
KCGetStatus                     (KCRef                  keychain,
                                 UInt32 *               keychainStatus);

EXTERN_API( OSStatus )
KCGetKeychain                   (KCItemRef              item,
                                 KCRef *                keychain);

EXTERN_API( OSStatus )
KCGetKeychainName               (KCRef                  keychain,
                                 StringPtr              keychainName);

EXTERN_API( OSStatus )
KCChangeSettings                (KCRef                  keychain);

/* Enumerating available keychains */
EXTERN_API( UInt16 )
KCCountKeychains                (void);

EXTERN_API( OSStatus )
KCGetIndKeychain                (UInt16                 index,
                                 KCRef *                keychain);

#endif  /* CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON */

typedef CALLBACK_API( OSStatus , KCCallbackProcPtr )(KCEvent keychainEvent, KCCallbackInfo *info, void *userContext);
typedef STACK_UPP_TYPE(KCCallbackProcPtr)                       KCCallbackUPP;
#if OPAQUE_UPP_TYPES
#if CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON
    EXTERN_API(KCCallbackUPP)
    NewKCCallbackUPP               (KCCallbackProcPtr       userRoutine);

    EXTERN_API(void)
    DisposeKCCallbackUPP           (KCCallbackUPP           userUPP);

    EXTERN_API(OSStatus)
    InvokeKCCallbackUPP            (KCEvent                 keychainEvent,
                                    KCCallbackInfo *        info,
                                    void *                  userContext,
                                    KCCallbackUPP           userUPP);

#endif  /* CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON */

#else
    enum { uppKCCallbackProcInfo = 0x00000FB0 };                    /* pascal 4_bytes Func(2_bytes, 4_bytes, 4_bytes) */
    #define NewKCCallbackUPP(userRoutine)                           (KCCallbackUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppKCCallbackProcInfo, GetCurrentArchitecture())
    #define DisposeKCCallbackUPP(userUPP)                           DisposeRoutineDescriptor(userUPP)
    #define InvokeKCCallbackUPP(keychainEvent, info, userContext, userUPP)  (OSStatus)CALL_THREE_PARAMETER_UPP((userUPP), uppKCCallbackProcInfo, (keychainEvent), (info), (userContext))
#endif
/* support for pre-Carbon UPP routines: NewXXXProc and CallXXXProc */
#define NewKCCallbackProc(userRoutine)                          NewKCCallbackUPP(userRoutine)
#define CallKCCallbackProc(userRoutine, keychainEvent, info, userContext) InvokeKCCallbackUPP(keychainEvent, info, userContext, userRoutine)
/* Keychain Manager callbacks */
#if CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON
EXTERN_API( OSStatus )
KCAddCallback                   (KCCallbackUPP          callbackProc,
                                 KCEventMask            eventMask,
                                 void *                 userContext);

EXTERN_API( OSStatus )
KCRemoveCallback                (KCCallbackUPP          callbackProc);

/* Managing the Human Interface */
EXTERN_API( OSStatus )
KCSetInteractionAllowed         (Boolean                state);

EXTERN_API( Boolean )
KCIsInteractionAllowed          (void);

/* Storing and retrieving AppleShare passwords */
EXTERN_API( OSStatus )
KCAddAppleSharePassword         (AFPServerSignature *   serverSignature,
                                 StringPtr              serverAddress,
                                 StringPtr              serverName,
                                 StringPtr              volumeName,
                                 StringPtr              accountName,
                                 UInt32                 passwordLength,
                                 const void *           passwordData,
                                 KCItemRef *            item);

EXTERN_API( OSStatus )
KCFindAppleSharePassword        (AFPServerSignature *   serverSignature,
                                 StringPtr              serverAddress,
                                 StringPtr              serverName,
                                 StringPtr              volumeName,
                                 StringPtr              accountName,
                                 UInt32                 maxLength,
                                 void *                 passwordData,
                                 UInt32 *               actualLength,
                                 KCItemRef *            item);

/* Storing and retrieving Internet passwords */
EXTERN_API( OSStatus )
KCAddInternetPassword           (StringPtr              serverName,
                                 StringPtr              securityDomain,
                                 StringPtr              accountName,
                                 UInt16                 port,
                                 OSType                 protocol,
                                 OSType                 authType,
                                 UInt32                 passwordLength,
                                 const void *           passwordData,
                                 KCItemRef *            item);

EXTERN_API( OSStatus )
KCAddInternetPasswordWithPath   (StringPtr              serverName,
                                 StringPtr              securityDomain,
                                 StringPtr              accountName,
                                 StringPtr              path,
                                 UInt16                 port,
                                 OSType                 protocol,
                                 OSType                 authType,
                                 UInt32                 passwordLength,
                                 const void *           passwordData,
                                 KCItemRef *            item);

EXTERN_API( OSStatus )
KCFindInternetPassword          (StringPtr              serverName,
                                 StringPtr              securityDomain,
                                 StringPtr              accountName,
                                 UInt16                 port,
                                 OSType                 protocol,
                                 OSType                 authType,
                                 UInt32                 maxLength,
                                 void *                 passwordData,
                                 UInt32 *               actualLength,
                                 KCItemRef *            item);

EXTERN_API( OSStatus )
KCFindInternetPasswordWithPath  (StringPtr              serverName,
                                 StringPtr              securityDomain,
                                 StringPtr              accountName,
                                 StringPtr              path,
                                 UInt16                 port,
                                 OSType                 protocol,
                                 OSType                 authType,
                                 UInt32                 maxLength,
                                 void *                 passwordData,
                                 UInt32 *               actualLength,
                                 KCItemRef *            item);

/* Storing and retrieving other types of passwords */
EXTERN_API( OSStatus )
KCAddGenericPassword            (StringPtr              serviceName,
                                 StringPtr              accountName,
                                 UInt32                 passwordLength,
                                 const void *           passwordData,
                                 KCItemRef *            item);

EXTERN_API( OSStatus )
KCFindGenericPassword           (StringPtr              serviceName,
                                 StringPtr              accountName,
                                 UInt32                 maxLength,
                                 void *                 passwordData,
                                 UInt32 *               actualLength,
                                 KCItemRef *            item);

/* Creating and editing a keychain item */
EXTERN_API( OSStatus )
KCNewItem                       (KCItemClass            itemClass,
                                 OSType                 itemCreator,
                                 UInt32                 length,
                                 const void *           data,
                                 KCItemRef *            item);

EXTERN_API( OSStatus )
KCSetAttribute                  (KCItemRef              item,
                                 KCAttribute *          attr);

EXTERN_API( OSStatus )
KCGetAttribute                  (KCItemRef              item,
                                 KCAttribute *          attr,
                                 UInt32 *               actualLength);

EXTERN_API( OSStatus )
KCSetData                       (KCItemRef              item,
                                 UInt32                 length,
                                 const void *           data);

EXTERN_API( OSStatus )
KCGetData                       (KCItemRef              item,
                                 UInt32                 maxLength,
                                 void *                 data,
                                 UInt32 *               actualLength);

/* Managing keychain items */
EXTERN_API( OSStatus )
KCAddItem                       (KCItemRef              item);

EXTERN_API( OSStatus )
KCDeleteItem                    (KCItemRef              item);

EXTERN_API( OSStatus )
KCUpdateItem                    (KCItemRef              item);

EXTERN_API( OSStatus )
KCReleaseItem                   (KCItemRef *            item);

EXTERN_API( OSStatus )
KCCopyItem                      (KCItemRef              item,
                                 KCRef                  destKeychain,
                                 KCItemRef *            copy);

/* Searching and enumerating keychain items */
EXTERN_API( OSStatus )
KCFindFirstItem                 (KCRef                  keychain,
                                 const KCAttributeList * attrList,
                                 KCSearchRef *          search,
                                 KCItemRef *            item);

EXTERN_API( OSStatus )
KCFindNextItem                  (KCSearchRef            search,
                                 KCItemRef *            item);

EXTERN_API( OSStatus )
KCReleaseSearch                 (KCSearchRef *          search);

/* Working with certificates */
EXTERN_API( OSStatus )
KCFindX509Certificates          (KCRef                  keychain,
                                 CFStringRef            name,
                                 CFStringRef            emailAddress,
                                 KCCertSearchOptions    options,
                                 CFMutableArrayRef *    certificateItems);

EXTERN_API( OSStatus )
KCChooseCertificate             (CFArrayRef             items,
                                 KCItemRef *            certificate,
                                 CFArrayRef             policyOIDs,
                                 KCVerifyStopOn         stopOn);


#endif  /* CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON */

/* Routines that use "C" strings */
#if CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON
EXTERN_API_C( OSStatus )
kcunlock                        (KCRef                  keychain,
                                 const char *           password);

EXTERN_API_C( OSStatus )
kccreatekeychain                (const char *           password,
                                 KCRef *                keychain);

EXTERN_API_C( OSStatus )
kcgetkeychainname               (KCRef                  keychain,
                                 char *                 keychainName);

EXTERN_API_C( OSStatus )
kcaddapplesharepassword         (AFPServerSignature *   serverSignature,
                                 const char *           serverAddress,
                                 const char *           serverName,
                                 const char *           volumeName,
                                 const char *           accountName,
                                 UInt32                 passwordLength,
                                 const void *           passwordData,
                                 KCItemRef *            item);

EXTERN_API_C( OSStatus )
kcfindapplesharepassword        (AFPServerSignature *   serverSignature,
                                 const char *           serverAddress,
                                 const char *           serverName,
                                 const char *           volumeName,
                                 const char *           accountName,
                                 UInt32                 maxLength,
                                 void *                 passwordData,
                                 UInt32 *               actualLength,
                                 KCItemRef *            item);

EXTERN_API_C( OSStatus )
kcaddinternetpassword           (const char *           serverName,
                                 const char *           securityDomain,
                                 const char *           accountName,
                                 UInt16                 port,
                                 OSType                 protocol,
                                 OSType                 authType,
                                 UInt32                 passwordLength,
                                 const void *           passwordData,
                                 KCItemRef *            item);

EXTERN_API_C( OSStatus )
kcaddinternetpasswordwithpath   (const char *           serverName,
                                 const char *           securityDomain,
                                 const char *           accountName,
                                 const char *           path,
                                 UInt16                 port,
                                 OSType                 protocol,
                                 OSType                 authType,
                                 UInt32                 passwordLength,
                                 const void *           passwordData,
                                 KCItemRef *            item);

EXTERN_API_C( OSStatus )
kcfindinternetpassword          (const char *           serverName,
                                 const char *           securityDomain,
                                 const char *           accountName,
                                 UInt16                 port,
                                 OSType                 protocol,
                                 OSType                 authType,
                                 UInt32                 maxLength,
                                 void *                 passwordData,
                                 UInt32 *               actualLength,
                                 KCItemRef *            item);

EXTERN_API_C( OSStatus )
kcfindinternetpasswordwithpath  (const char *           serverName,
                                 const char *           securityDomain,
                                 const char *           accountName,
                                 const char *           path,
                                 UInt16                 port,
                                 OSType                 protocol,
                                 OSType                 authType,
                                 UInt32                 maxLength,
                                 void *                 passwordData,
                                 UInt32 *               actualLength,
                                 KCItemRef *            item);

EXTERN_API_C( OSStatus )
kcaddgenericpassword            (const char *           serviceName,
                                 const char *           accountName,
                                 UInt32                 passwordLength,
                                 const void *           passwordData,
                                 KCItemRef *            item);

EXTERN_API_C( OSStatus )
kcfindgenericpassword           (const char *           serviceName,
                                 const char *           accountName,
                                 UInt32                 maxLength,
                                 void *                 passwordData,
                                 UInt32 *               actualLength,
                                 KCItemRef *            item);

#endif  /* CALL_IN_KEYCHAIN_BUT_NOT_IN_CARBON */


#if PRAGMA_STRUCT_ALIGN
    #pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
    #pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __KEYCHAIN__ */

