/*
 	File:		ConditionalMacros.r
 
 	Contains:	Set up for compiler independent conditionals
 
 	Version:	Technology:	Universal Interface Files 3.2
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1993-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/

#ifndef __CONDITIONALMACROS_R__
#define __CONDITIONALMACROS_R__

/****************************************************************************************************
	UNIVERSAL_INTERFACES_VERSION
	
		0x0320 => version 3.2
		0x0310 => version 3.1
		0x0301 => version 3.0.1
		0x0300 => version 3.0
		0x0210 => version 2.1
		This conditional did not exist prior to version 2.1
****************************************************************************************************/
#define UNIVERSAL_INTERFACES_VERSION 0x0320

/****************************************************************************************************

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

****************************************************************************************************/



#if defined(Environ_OS_Win32) || defined(Environ_OS_Unix) || defined(Environ_OS_Mac)

	#if Environ_OS_Win32
		/*
			Rez.exe resource compiler for Win32 from QuickTime 3.0, Apple Computer, Inc.	
		*/
		#define TARGET_OS_MAC				0
		#define TARGET_OS_WIN32				1
		#define TARGET_OS_UNIX				0
		#define TARGET_RT_LITTLE_ENDIAN		1
		#define TARGET_RT_BIG_ENDIAN		0

	
	#elif Environ_OS_Unix
		/*
			Rez resource compiler for unix from QuickTime 3.0, Apple Computer, Inc.	
		*/
		#define TARGET_OS_MAC				0
		#define TARGET_OS_WIN32				0
		#define TARGET_OS_UNIX				1
		#define TARGET_RT_LITTLE_ENDIAN		0
		#define TARGET_RT_BIG_ENDIAN		1

	
	#else
		/*
			Rez resource compiler for MacOS from QuickTime 3.0, Apple Computer, Inc.	
		*/
		#define TARGET_OS_MAC				1
		#define TARGET_OS_WIN32				0
		#define TARGET_OS_UNIX				0
		#define TARGET_RT_LITTLE_ENDIAN		0
		#define TARGET_RT_BIG_ENDIAN		1
	#endif

	
#else
	/*
		Rez resource compiler for MacOS, Apple Computer, Inc.	
	*/
	#define TARGET_OS_MAC				1
	#define TARGET_OS_WIN32				0
	#define TARGET_OS_UNIX				0
	#define TARGET_RT_LITTLE_ENDIAN		0
	#define TARGET_RT_BIG_ENDIAN		1
#endif




/****************************************************************************************************

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

****************************************************************************************************/
#ifndef OLDROUTINENAMES
#define OLDROUTINENAMES 0
#endif
#ifndef OLDROUTINELOCATIONS
#define OLDROUTINELOCATIONS 0
#endif







#endif /* __CONDITIONALMACROS_R__ */

