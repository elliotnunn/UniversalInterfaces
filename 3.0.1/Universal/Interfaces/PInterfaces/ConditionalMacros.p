{
 	File:		ConditionalMacros.p
 
 	Contains:	Set up for compiler independent conditionals
 
 	Version:	Technology:	Universal Interface Files 3.0.1
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1993-1997 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ConditionalMacros;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$SETC __CONDITIONALMACROS__ := 1}

{$I+}
{$SETC ConditionalMacrosIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{***************************************************************************************************
	UNIVERSAL_INTERFACES_VERSION
	
		0x0301 => version 3.0.1
		0x0300 => version 3.0
		0x0210 => version 2.1
		This conditional did not exist prior to version 2.1
***************************************************************************************************}
{$SETC UNIVERSAL_INTERFACES_VERSION := $0301}

{***************************************************************************************************

	TARGET_CPU_≈	
	These conditionals specify which microprocessor instruction set is being
	generated.  At most one of these is true, the rest are false.

		TARGET_CPU_PPC			- Compiler is generating PowerPC instructions
		TARGET_CPU_68K			- Compiler is generating 680x0 instructions
		TARGET_CPU_X86			- Compiler is generating x86 instructions
		TARGET_CPU_MIPS			- Compiler is generating MIPS instructions
		TARGET_CPU_SPARC		- Compiler is generating Sparc instructions
		TARGET_CPU_ALPHA		- Compiler is generating Dec Alpha instructions


	TARGET_OS_≈	
	These conditionals specify in which Operating System the generated code will
	run. At most one of the these is true, the rest are false.

		TARGET_OS_MAC			- Generate code will run under Mac OS
		TARGET_OS_WIN32			- Generate code will run under 32-bit Windows
		TARGET_OS_UNIX			- Generate code will run under some unix 


	TARGET_RT_≈	
	These conditionals specify in which runtime the generated code will
	run. This is needed when the OS and CPU support more than one runtime
	(e.g. MacOS on 68K supports CFM68K and Classic 68k).

		TARGET_RT_LITTLE_ENDIAN	- Generated code uses little endian format for integers
		TARGET_RT_BIG_ENDIAN	- Generated code uses big endian format for integers 	
		TARGET_RT_MAC_CFM		- TARGET_OS_MAC is true and CFM68K or PowerPC CFM being used	
		TARGET_RT_MAC_68881		- TARGET_OS_MAC is true and 68881 floating point instructions used	


	PRAGMA_≈
	These conditionals specify whether the compiler supports particular #pragma's
	
		PRAGMA_IMPORT 			- Compiler supports: #pragma import on/off/reset
		PRAGMA_ONCE  			- Compiler supports: #pragma once
		PRAGMA_STRUCT_ALIGN  	- Compiler supports: #pragma options align=mac68k/power/reset
		PRAGMA_STRUCT_PACK		- Compiler supports: #pragma pack(n)
		PRAGMA_STRUCT_PACKPUSH	- Compiler supports: #pragma pack(push, n)/pack(pop)
		PRAGMA_ENUM_PACK 		- Compiler supports: #pragma options(!pack_enums)
		PRAGMA_ENUM_ALWAYSINT 	- Compiler supports: #pragma enumsalwaysint on/off/reset
		PRAGMA_ENUM_OPTIONS		- Compiler supports: #pragma options enum=int/small/reset

	FOUR_CHAR_CODE
	This conditional does the proper byte swapping to assue that a four character code (e.g. 'TEXT')
	is compiled down to the correct value on all compilers.

		FOUR_CHAR_CODE('abcd')	- Convert a four-char-code to the correct 32-bit value

	TYPE_≈
	These conditionals specify whether the compiler supports particular types.

		TYPE_LONGLONG			- Compiler supports "long long" 64-bit integers
		TYPE_BOOL				- Compiler supports "bool"
		TYPE_EXTENDED			- Compiler supports "extended" 80/96 bit floating point

***************************************************************************************************}

{$IFC NOT UNDEFINED MWERKS}
	{
		CodeWarrior Pascal compiler from Metrowerks, Inc.
	}
	{$IFC MAC68K}
		{$SETC TARGET_CPU_PPC  			:= FALSE}
		{$SETC TARGET_CPU_68K  			:= TRUE}
		{$SETC TARGET_CPU_X86  			:= FALSE}
		{$SETC TARGET_CPU_MIPS 			:= FALSE}
		{$SETC TARGET_CPU_SPARC 		:= FALSE}
		{$SETC TARGET_RT_MAC_CFM		:= FALSE}
		{$SETC TARGET_RT_MAC_68881		:= OPTION(mc68881)}
		{$SETC TARGET_OS_MAC			:= TRUE}
		{$SETC TARGET_OS_WIN32			:= FALSE}
		{$SETC TARGET_OS_UNIX			:= FALSE}
		{$SETC TARGET_RT_LITTLE_ENDIAN	:= FALSE}
		{$SETC TARGET_RT_BIG_ENDIAN		:= TRUE}
	{$ELSEC}
		{$IFC POWERPC}
			{$SETC TARGET_CPU_PPC  			:= TRUE}
			{$SETC TARGET_CPU_68K  			:= FALSE}
			{$SETC TARGET_CPU_X86  			:= FALSE}
			{$SETC TARGET_CPU_MIPS 			:= FALSE}
			{$SETC TARGET_CPU_SPARC 		:= FALSE}
			{$SETC TARGET_RT_MAC_CFM		:= TRUE}
			{$SETC TARGET_RT_MAC_68881		:= FALSE}
			{$SETC TARGET_OS_MAC			:= TRUE}
			{$SETC TARGET_OS_WIN32			:= FALSE}
			{$SETC TARGET_OS_UNIX			:= FALSE}
			{$SETC TARGET_RT_LITTLE_ENDIAN	:= FALSE}
			{$SETC TARGET_RT_BIG_ENDIAN		:= TRUE}
		{$ELSEC}
			{$IFC INTEL}
				{$SETC TARGET_CPU_PPC  			:= FALSE}
				{$SETC TARGET_CPU_68K  			:= FALSE}
				{$SETC TARGET_CPU_X86  			:= TRUE}
				{$SETC TARGET_CPU_MIPS 			:= FALSE}
				{$SETC TARGET_CPU_SPARC 		:= FALSE}
				{$SETC TARGET_RT_MAC_CFM		:= FALSE}
				{$SETC TARGET_RT_MAC_68881		:= FALSE}
				{$SETC TARGET_OS_MAC			:= FALSE}
				{$SETC TARGET_OS_WIN32			:= TRUE}
				{$SETC TARGET_OS_UNIX			:= FALSE}
				{$SETC TARGET_RT_LITTLE_ENDIAN	:= TRUE}
				{$SETC TARGET_RT_BIG_ENDIAN		:= FALSE}
			{$ELSEC}
				Error unknown compiler targer
			{$ENDC}
		{$ENDC}
	{$ENDC}	
	{$SETC TYPE_EXTENDED				:= TRUE}
	{$SETC TYPE_LONGLONG				:= FALSE}
	{$SETC TYPE_BOOL					:= FALSE}
{$ELSEC} 


{$IFC NOT UNDEFINED THINK}
	{
		THINK Pascal compiler from Symantec, Inc.	 << WARNING: Unsupported Compiler >>
	}
	{$SETC TARGET_CPU_68K  				:= 1}
	{$SETC TARGET_CPU_PPC  				:= 0}
	{$SETC TARGET_CPU_X86  				:= 0}
	{$SETC TARGET_CPU_MIPS 				:= 0}
	{$SETC TARGET_CPU_SPARC 			:= 0}
	{$SETC TARGET_RT_MAC_CFM			:= 0}
	{$SETC TARGET_RT_MAC_68881			:= OPTION(mc68881)}
	{$SETC TARGET_OS_MAC				:= 1}
	{$SETC TARGET_OS_WIN32				:= 0}
	{$SETC TARGET_OS_UNIX				:= 0}
	{$SETC TARGET_RT_LITTLE_ENDIAN		:= 0}
	{$SETC TARGET_RT_BIG_ENDIAN			:= 1}
	{$SETC TYPE_EXTENDED				:= 1}
	{$SETC TYPE_LONGLONG				:= 0}
	{$SETC TYPE_BOOL					:= 0}
{$ELSEC}


	{
		MPW Pascal compiler from Apple Computer, Inc.	 << WARNING: Unsupported Compiler >>
	}
	{$SETC TARGET_CPU_68K  				:= 1}
	{$SETC TARGET_CPU_PPC  				:= 0}
	{$SETC TARGET_CPU_X86  				:= 0}
	{$SETC TARGET_CPU_MIPS 				:= 0}
	{$SETC TARGET_CPU_SPARC 			:= 0}
	{$SETC TARGET_RT_MAC_CFM			:= 0}
	{$SETC TARGET_RT_MAC_68881			:= OPTION(mc68881)}
	{$SETC TARGET_OS_MAC				:= 1}
	{$SETC TARGET_OS_WIN32				:= 0}
	{$SETC TARGET_OS_UNIX				:= 0}
	{$SETC TARGET_RT_LITTLE_ENDIAN		:= 0}
	{$SETC TARGET_RT_BIG_ENDIAN			:= 1}
	{$SETC TYPE_EXTENDED				:= 1}
	{$SETC TYPE_LONGLONG				:= 0}
	{$SETC TYPE_BOOL					:= 0}
{$ENDC}
{$ENDC}





{***************************************************************************************************
	Backward compatibility for clients expecting 2.x version on ConditionalMacros.h

	GENERATINGPOWERPC		- Compiler is generating PowerPC instructions
	GENERATING68K			- Compiler is generating 68k family instructions
	GENERATING68881			- Compiler is generating mc68881 floating point instructions
	GENERATINGCFM			- Code being generated assumes CFM calling conventions
	CFMSYSTEMCALLS			- No A-traps.  Systems calls are made using CFM and UPP's
	PRAGMA_ALIGN_SUPPORTED	- Compiler supports: #pragma options align=mac68k/power/reset
	PRAGMA_IMPORT_SUPPORTED	- Compiler supports: #pragma import on/off/reset

***************************************************************************************************}
{$SETC GENERATINGPOWERPC := TARGET_CPU_PPC }
{$SETC GENERATING68K := TARGET_CPU_68K }
{$SETC GENERATING68881 := TARGET_RT_MAC_68881 }
{$SETC GENERATINGCFM := TARGET_RT_MAC_CFM }
{$SETC CFMSYSTEMCALLS := TARGET_RT_MAC_CFM }
{
	NOTE: The FOR_≈ conditionals were developed to produce integerated
		  interface files for System 7 and Copland.  Now that Copland
		  is canceled, all FOR_ conditionals have been removed from
		  the interface files.  But, just in case you someone got an 
		  interface file that uses them, the following sets the FOR_≈
		  conditionals to a consistent, usable state.
}
{$SETC FOR_OPAQUE_SYSTEM_DATA_STRUCTURES := 0 }
{$IFC UNDEFINED FOR_PTR_BASED_AE }
{$SETC FOR_PTR_BASED_AE := 0 }
{$ENDC}

{$SETC FOR_SYSTEM7_ONLY := 1 }
{$SETC FOR_SYSTEM7_AND_SYSTEM8_DEPRECATED := 1 }
{$SETC FOR_SYSTEM7_AND_SYSTEM8_COOPERATIVE := 1 }
{$SETC FOR_SYSTEM7_AND_SYSTEM8_PREEMPTIVE := 1 }
{$SETC FOR_SYSTEM8_COOPERATIVE := 0 }
{$SETC FOR_SYSTEM8_PREEMPTIVE := 0 }



{***************************************************************************************************

	OLDROUTINENAMES			- "Old" names for Macintosh system calls are allowed in source code.
							  (e.g. DisposPtr instead of DisposePtr). The names of system routine
							  are now more sensitive to change because CFM binds by name.  In the 
							  past, system routine names were compiled out to just an A-Trap.  
							  Macros have been added that each map an old name to its new name.  
							  This allows old routine names to be used in existing source files,
							  but the macros only work if OLDROUTINENAMES is true.  This support
							  will be removed in the near future.  Thus, all source code should 
							  be changed to use the new names! You can set OLDROUTINENAMES to false
							  to see if your code has any old names left in it.
	
	OLDROUTINELOCATIONS     - "Old" location of Macintosh system calls are used.  For example, c2pstr 
							  has been moved from Strings to TextUtils.  It is conditionalized in
							  Strings with OLDROUTINELOCATIONS and in TextUtils with !OLDROUTINELOCATIONS.
							  This allows developers to upgrade to newer interface files without 
							  having to change the includes in their source code.  But, it allows
							  the slow migration of system calls to more understandable file locations.  
							  OLDROUTINELOCATIONS currently defaults to true, but eventually will 
							  default to false.

***************************************************************************************************}
{$IFC UNDEFINED OLDROUTINENAMES }
{$SETC OLDROUTINENAMES := 0 }
{$ENDC}

{$IFC UNDEFINED OLDROUTINELOCATIONS }
{$SETC OLDROUTINELOCATIONS := 0 }
{$ENDC}







{$SETC UsingIncludes := ConditionalMacrosIncludes}

{$ENDC} {__CONDITIONALMACROS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}