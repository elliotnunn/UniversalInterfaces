{
 	File:		CMPRComponent.p
 
 	Contains:	ColorSync ProfileResponder Components Interface 
 
 	Version:	Technology:	ColorSync 2.1
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1993, 1995, 1997 by Apple Computer, Inc. All rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CMPRComponent;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMPRCOMPONENT__}
{$SETC __CMPRCOMPONENT__ := 1}

{$I+}
{$SETC CMPRComponentIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	CMPRInterfaceVersion		= 0;

{ Component function selectors }
	kCMPRGetProfile				= 0;
	kCMPRSetProfile				= 1;
	kCMPRSetProfileDescription	= 2;
	kCMPRGetIndexedProfile		= 3;
	kCMPRDeleteDeviceProfile	= 4;


FUNCTION CMGetProfile(pr: ComponentInstance; aProfile: CMProfileHandle; VAR returnedProfile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0000, $7000, $A82A;
	{$ENDC}
FUNCTION CMSetProfile(pr: ComponentInstance; newProfile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION CMSetProfileDescription(pr: ComponentInstance; DeviceData: LONGINT; hProfile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION CMGetIndexedProfile(pr: ComponentInstance; search: CMProfileSearchRecordHandle; VAR returnProfile: CMProfileHandle; VAR index: LONGINT): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION CMDeleteDeviceProfile(pr: ComponentInstance; deleteMe: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMPRComponentIncludes}

{$ENDC} {__CMPRCOMPONENT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
