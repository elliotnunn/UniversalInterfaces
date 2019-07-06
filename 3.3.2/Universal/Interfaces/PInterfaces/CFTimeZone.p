{
     File:       CFTimeZone.p
 
     Contains:   CoreFoundation time zone
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1999-2000 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CFTimeZone;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFTIMEZONE__}
{$SETC __CFTIMEZONE__ := 1}

{$I+}
{$SETC CFTimeZoneIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
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
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
    CFTimeZoneRef is defined in CFDate.h
}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFTimeZoneIncludes}

{$ENDC} {__CFTIMEZONE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
