{
 	File:		FixMath.p
 
 	Contains:	Fixed Math Interfaces.
 
 	Version:	Technology:	Mac OS 8
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1985-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT FixMath;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FIXMATH__}
{$SETC __FIXMATH__ := 1}

{$I+}
{$SETC FixMathIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}



CONST
	fixed1						= $00010000;
	fract1						= $40000000;
	positiveInfinity			= $7FFFFFFF;
	negativeInfinity			= $80000000;

{
	FixRatio, FixMul, and FixRound were previously in ToolUtils.h
}
FUNCTION FixRatio(numer: INTEGER; denom: INTEGER): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A869;
	{$ENDC}
FUNCTION FixMul(a: Fixed; b: Fixed): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A868;
	{$ENDC}
FUNCTION FixRound(x: Fixed): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A86C;
	{$ENDC}
FUNCTION Fix2Frac(x: Fixed): Fract;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A841;
	{$ENDC}
FUNCTION Fix2Long(x: Fixed): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A840;
	{$ENDC}
FUNCTION Long2Fix(x: LONGINT): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A83F;
	{$ENDC}
FUNCTION Frac2Fix(x: Fract): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A842;
	{$ENDC}
FUNCTION FracMul(x: Fract; y: Fract): Fract;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A84A;
	{$ENDC}
FUNCTION FixDiv(x: Fixed; y: Fixed): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A84D;
	{$ENDC}
FUNCTION FracDiv(x: Fract; y: Fract): Fract;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A84B;
	{$ENDC}
FUNCTION FracSqrt(x: Fract): Fract;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A849;
	{$ENDC}
FUNCTION FracSin(x: Fixed): Fract;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A848;
	{$ENDC}
FUNCTION FracCos(x: Fixed): Fract;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A847;
	{$ENDC}
FUNCTION FixATan2(x: LONGINT; y: LONGINT): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A818;
	{$ENDC}
{
	Frac2X, Fix2X, X2Fix, and X2Frac translate to and from
	the floating point type "extended" (that's what the X is for).
	On the original Mac this was 80-bits and the functions could be
	accessed via A-Traps.  When the 68881 co-processor was added,
	it used 96-bit floating point types, so the A-Traps could not 
	be used.  When PowerPC was added, it used 64-bit floating point
	types, so yet another prototype was added.
}
{$IFC TARGET_CPU_68K }
{$IFC TARGET_RT_MAC_68881 }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION Frac2X(x: Fract): extended;
FUNCTION Fix2X(x: Fixed): extended;
FUNCTION X2Fix(x: extended): Fixed;
FUNCTION X2Frac(x: extended): Fract;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ELSEC}
{$IFC CALL_NOT_IN_CARBON }
FUNCTION Frac2X(x: Fract): extended;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A845;
	{$ENDC}
FUNCTION Fix2X(x: Fixed): extended;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A843;
	{$ENDC}
FUNCTION X2Fix(x: extended): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A844;
	{$ENDC}
FUNCTION X2Frac(x: extended): Fract;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A846;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_RT_MAC_68881}
{$ELSEC}
FUNCTION Frac2X(x: Fract): Double;
FUNCTION Fix2X(x: Fixed): Double;
FUNCTION X2Fix(x: Double): Fixed;
FUNCTION X2Frac(x: Double): Fract;
{$ENDC}  {TARGET_CPU_68K}

{  QuickTime 3.0 makes these Wide routines available on other platforms }
{$IFC TARGET_CPU_PPC OR NOT TARGET_OS_MAC }
FUNCTION WideCompare({CONST}VAR target: wide; {CONST}VAR source: wide): INTEGER; C;
FUNCTION WideAdd(VAR target: wide; {CONST}VAR source: wide): widePtr; C;
FUNCTION WideSubtract(VAR target: wide; {CONST}VAR source: wide): widePtr; C;
FUNCTION WideNegate(VAR target: wide): widePtr; C;
FUNCTION WideShift(VAR target: wide; shift: LONGINT): widePtr; C;
FUNCTION WideSquareRoot({CONST}VAR source: wide): UInt32; C;
FUNCTION WideMultiply(multiplicand: LONGINT; multiplier: LONGINT; VAR target: wide): widePtr; C;
{ returns the quotient }
FUNCTION WideDivide({CONST}VAR dividend: wide; divisor: LONGINT; VAR remainder: LONGINT): LONGINT; C;
{ quotient replaces dividend }
FUNCTION WideWideDivide(VAR dividend: wide; divisor: LONGINT; VAR remainder: LONGINT): widePtr; C;
FUNCTION WideBitShift(VAR src: wide; shift: LONGINT): widePtr; C;
{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FixMathIncludes}

{$ENDC} {__FIXMATH__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
