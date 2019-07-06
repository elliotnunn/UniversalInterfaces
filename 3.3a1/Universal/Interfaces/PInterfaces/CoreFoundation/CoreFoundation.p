{
 	File:		CoreFoundation.p
 
 	Contains:	CoreFoundation master header
 
 	Version:	Technology:	Mac OS X
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CoreFoundation;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __COREFOUNDATION__}
{$SETC __COREFOUNDATION__ := 1}

{$I+}
{$SETC CoreFoundationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
{$ENDC}
{$IFC UNDEFINED __CFBAG__}
{$I CFBag.p}
{$ENDC}
{$IFC UNDEFINED __CFBUNDLE__}
{$I CFBundle.p}
{$ENDC}
{$IFC UNDEFINED __CFCHARACTERSET__}
{$I CFCharacterSet.p}
{$ENDC}
{$IFC UNDEFINED __CFDATA__}
{$I CFData.p}
{$ENDC}
{$IFC UNDEFINED __CFDATE__}
{$I CFDate.p}
{$ENDC}
{$IFC UNDEFINED __CFDICTIONARY__}
{$I CFDictionary.p}
{$ENDC}
{$IFC UNDEFINED __CFNUMBER__}
{$I CFNumber.p}
{$ENDC}
{$IFC UNDEFINED __CFPLUGIN__}
{$I CFPlugIn.p}
{$ENDC}
{$IFC UNDEFINED __CFPREFERENCES__}
{$I CFPreferences.p}
{$ENDC}
{$IFC UNDEFINED __CFPROPERTYLIST__}
{$I CFPropertyList.p}
{$ENDC}
{$IFC UNDEFINED __CFSET__}
{$I CFSet.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRINGENCODINGEXT__}
{$I CFStringEncodingExt.p}
{$ENDC}
{$IFC UNDEFINED __CFTIMEZONE__}
{$I CFTimeZone.p}
{$ENDC}
{$IFC UNDEFINED __CFURL__}
{$I CFURL.p}
{$ENDC}
{$IFC UNDEFINED __CFURLACCESS__}
{$I CFURLAccess.p}
{$ENDC}
{$SETC UsingIncludes := CoreFoundationIncludes}

{$ENDC} {__COREFOUNDATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
