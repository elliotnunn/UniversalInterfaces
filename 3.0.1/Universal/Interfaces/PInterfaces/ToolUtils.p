{
 	File:		ToolUtils.p
 
 	Contains:	Toolbox Utilities Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1990-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ToolUtils;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TOOLUTILS__}
{$SETC __TOOLUTILS__ := 1}

{$I+}
{$SETC ToolUtilsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}

{$IFC OLDROUTINELOCATIONS }
{$IFC UNDEFINED __FIXMATH__}
{$I FixMath.p}
{$ENDC}
{$IFC UNDEFINED __ICONS__}
{$I Icons.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __TEXTUTILS__}
{$I TextUtils.p}
{$ENDC}
{$ENDC}  {OLDROUTINELOCATIONS}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
————————————————————————————————————————————————————————————————————————————————————
	Note: 
	
	The following routines that used to be in this header file, have moved to
	more appropriate headers.  If OLDROUTINELOCATIONS is 0, then you will have
	to include the headers below to use the following functions.
	
		FixMath.h:		FixMul
						FixRatio
						FixRound
		
		Icons.h: 	 	GetIcon
						PlotIcon
						
		Quickdraw.h:	AngleFromSlope
						DeltaPoint
						GetCursor
						GetIndPattern
						GetPattern
						GetPicture
						PackBits
						ScreenRes
						ShieldCursor
						SlopeFromAngle
						UnpackBits
						
		TextUtils.h:	Munger
						GetIndString
						GetString
						NewString
						SetString
————————————————————————————————————————————————————————————————————————————————————
}


FUNCTION BitTst(bytePtr: UNIV Ptr; bitNum: LONGINT): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A85D;
	{$ENDC}
PROCEDURE BitSet(bytePtr: UNIV Ptr; bitNum: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A85E;
	{$ENDC}
PROCEDURE BitClr(bytePtr: UNIV Ptr; bitNum: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A85F;
	{$ENDC}
FUNCTION BitAnd(value1: LONGINT; value2: LONGINT): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A858;
	{$ENDC}
FUNCTION BitOr(value1: LONGINT; value2: LONGINT): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A85B;
	{$ENDC}
FUNCTION BitXor(value1: LONGINT; value2: LONGINT): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A859;
	{$ENDC}
FUNCTION BitNot(value: LONGINT): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A85A;
	{$ENDC}
FUNCTION BitShift(value: LONGINT; count: INTEGER): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A85C;
	{$ENDC}
{$IFC TARGET_CPU_68K }

TYPE
	Int64BitPtr = ^Int64Bit;
	Int64Bit = RECORD
		hiLong:					SInt32;
		loLong:					UInt32;
	END;

PROCEDURE LongMul(a: LONGINT; b: LONGINT; VAR result: Int64Bit);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A867;
	{$ENDC}
{$ENDC}  {TARGET_CPU_68K}

FUNCTION HiWord(x: LONGINT): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A86A;
	{$ENDC}
FUNCTION LoWord(x: LONGINT): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A86B;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ToolUtilsIncludes}

{$ENDC} {__TOOLUTILS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
