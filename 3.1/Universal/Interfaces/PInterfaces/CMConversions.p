{
 	File:		CMConversions.p
 
 	Contains:	ColorSync Conversion Component API
 
 	Version:	Technology:	ColorSync 2.0
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1993-1998 by Apple Computer, Inc. All rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CMConversions;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMCONVERSIONS__}
{$SETC __CMCONVERSIONS__ := 1}

{$I+}
{$SETC CMConversionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
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
	CMConversionInterfaceVersion = 1;

{ Component function selectors }
	kCMXYZToLab					= 0;
	kCMLabToXYZ					= 1;
	kCMXYZToLuv					= 2;
	kCMLuvToXYZ					= 3;
	kCMXYZToYxy					= 4;
	kCMYxyToXYZ					= 5;
	kCMRGBToHLS					= 6;
	kCMHLSToRGB					= 7;
	kCMRGBToHSV					= 8;
	kCMHSVToRGB					= 9;
	kCMRGBToGRAY				= 10;
	kCMXYZToFixedXYZ			= 11;
	kCMFixedXYZToXYZ			= 12;

FUNCTION CMXYZToLab(ci: ComponentInstance; {CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0000, $7000, $A82A;
	{$ENDC}
FUNCTION CMLabToXYZ(ci: ComponentInstance; {CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION CMXYZToLuv(ci: ComponentInstance; {CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION CMLuvToXYZ(ci: ComponentInstance; {CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION CMXYZToYxy(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION CMYxyToXYZ(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION CMRGBToHLS(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION CMHLSToRGB(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION CMRGBToHSV(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION CMHSVToRGB(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION CMRGBToGray(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION CMXYZToFixedXYZ(ci: ComponentInstance; {CONST}VAR src: CMXYZColor; VAR dst: CMFixedXYZColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION CMFixedXYZToXYZ(ci: ComponentInstance; {CONST}VAR src: CMFixedXYZColor; VAR dst: CMXYZColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000C, $7000, $A82A;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMConversionsIncludes}

{$ENDC} {__CMCONVERSIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
