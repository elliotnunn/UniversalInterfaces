/*
     File:       KeychainHI.h
 
     Contains:   Keychain API's with Human Interfaces
 
     Version:    Technology: Keychain 3.0
                 Release:    Universal Interfaces 3.4.1
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __KEYCHAINHI__
#define __KEYCHAINHI__

#ifndef __KEYCHAINCORE__
#include <KeychainCore.h>
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

/* Locking and unlocking a keychain */
/*
 *  KCUnlock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 */
EXTERN_API( OSStatus )
KCUnlock(
  KCRef       keychain,       /* can be NULL */
  StringPtr   password);      /* can be NULL */


/* Managing keychain items */
/*
 *  KCAddItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 */
EXTERN_API( OSStatus )
KCAddItem(KCItemRef item);


/* Creating a new keychain */
/*
 *  KCCreateKeychain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 */
EXTERN_API( OSStatus )
KCCreateKeychain(
  StringPtr   password,       /* can be NULL */
  KCRef *     keychain);      /* can be NULL */


/* Changing a keychain's settings */
/*
 *  KCChangeSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 */
EXTERN_API( OSStatus )
KCChangeSettings(KCRef keychain);


/*
 *  kcunlock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 */
EXTERN_API_C( OSStatus )
kcunlock(
  KCRef         keychain,       /* can be NULL */
  const char *  password);      /* can be NULL */


/*
 *  kccreatekeychain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 */
EXTERN_API_C( OSStatus )
kccreatekeychain(
  const char *  password,       /* can be NULL */
  KCRef *       keychain);      /* can be NULL */


/* Working with certificates */
#if CALL_NOT_IN_CARBON
/*
 *  KCFindX509Certificates()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
KCFindX509Certificates(
  KCRef                 keychain,
  CFStringRef           name,
  CFStringRef           emailAddress,
  KCCertSearchOptions   options,
  CFMutableArrayRef *   certificateItems);      /* can be NULL */


/*
 *  KCChooseCertificate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
KCChooseCertificate(
  CFArrayRef       items,
  KCItemRef *      certificate,
  CFArrayRef       policyOIDs,
  KCVerifyStopOn   stopOn);



#endif  /* CALL_NOT_IN_CARBON */


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

#endif /* __KEYCHAINHI__ */

