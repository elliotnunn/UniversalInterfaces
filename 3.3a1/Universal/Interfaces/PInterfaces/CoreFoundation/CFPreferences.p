{
 	File:		CFPreferences.p
 
 	Contains:	CoreFoundation preferences
 
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
 UNIT CFPreferences;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFPREFERENCES__}
{$SETC __CFPREFERENCES__ := 1}

{$I+}
{$SETC CFPreferencesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
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


{ Searches the various sources of application defaults to find the value for the given key.  
   key must not be NULL.  If a value is found, it returns it; otherwise returns NULL.  Caller 
   must release the returned value }
FUNCTION CFPreferencesCopyAppValue(key: CFStringRef; appName: CFStringRef): CFTypeRef; C;
{ Sets the given value for the given key in the "normal" place for application preferences.  
   key must not be NULL.  If value is NULL, key is removed instead. }
PROCEDURE CFPreferencesSetAppValue(key: CFStringRef; value: CFTypeRef; appName: CFStringRef); C;
{ Writes all changes in all sources of application defaults.  Returns success or failure. }
FUNCTION CFPreferencesAppSynchronize(appName: CFStringRef): BOOLEAN; C;

{ The primitive get mechanism; all arguments must be non-NULL (use the constants above for common values).  
   Only the exact location specified by app-user-host is searched.  The returned CFType must be released by 
   the caller when it is finished with it. }
FUNCTION CFPreferencesCopyValue(key: CFStringRef; appName: CFStringRef; user: CFStringRef; host: CFStringRef): CFTypeRef; C;
{ The primitive set function; all arguments except value must be non-NULL.  If value is NULL, the given key is removed }
PROCEDURE CFPreferencesSetValue(key: CFStringRef; value: CFTypeRef; appName: CFStringRef; user: CFStringRef; host: CFStringRef); C;
FUNCTION CFPreferencesSynchronize(appName: CFStringRef; user: CFStringRef; host: CFStringRef): BOOLEAN; C;
{ Constructs and returns the list of the name of all applications which have preferences in the scope of the given user and host.
    The returned value must be released by the caller; neither argument may be NULL. }
FUNCTION CFPreferencesCopyApplicationList(userName: CFStringRef; hostName: CFStringRef): CFArrayRef; C;
{ Constructs and returns the list of all keys set in the given location.  
   The returned value must be released by the caller; all arguments must be non-NULL }
FUNCTION CFPreferencesCopyKeyList(appName: CFStringRef; userName: CFStringRef; hostName: CFStringRef): CFArrayRef; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFPreferencesIncludes}

{$ENDC} {__CFPREFERENCES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
