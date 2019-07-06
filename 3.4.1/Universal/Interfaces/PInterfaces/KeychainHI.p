{
     File:       KeychainHI.p
 
     Contains:   Keychain API's with Human Interfaces
 
     Version:    Technology: Keychain 3.0
                 Release:    Universal Interfaces 3.4.1
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT KeychainHI;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __KEYCHAINHI__}
{$SETC __KEYCHAINHI__ := 1}

{$I+}
{$SETC KeychainHIIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __KEYCHAINCORE__}
{$I KeychainCore.p}
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

{ Locking and unlocking a keychain }
{
 *  KCUnlock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION KCUnlock(keychain: KCRef; password: StringPtr): OSStatus;

{ Managing keychain items }
{
 *  KCAddItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION KCAddItem(item: KCItemRef): OSStatus;

{ Creating a new keychain }
{
 *  KCCreateKeychain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION KCCreateKeychain(password: StringPtr; keychain: KCRefPtr): OSStatus;

{ Changing a keychain's settings }
{
 *  KCChangeSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 and later
 }
FUNCTION KCChangeSettings(keychain: KCRef): OSStatus;

{ Working with certificates }
{$IFC CALL_NOT_IN_CARBON }
{
 *  KCFindX509Certificates()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION KCFindX509Certificates(keychain: KCRef; name: CFStringRef; emailAddress: CFStringRef; options: KCCertSearchOptions; certificateItems: CFMutableArrayRefPtr): OSStatus;

{
 *  KCChooseCertificate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeychainLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION KCChooseCertificate(items: CFArrayRef; VAR certificate: KCItemRef; policyOIDs: CFArrayRef; stopOn: KCVerifyStopOn): OSStatus;


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := KeychainHIIncludes}

{$ENDC} {__KEYCHAINHI__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
