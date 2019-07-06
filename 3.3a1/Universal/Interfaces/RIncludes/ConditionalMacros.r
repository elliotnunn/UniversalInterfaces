/*
 	File:		ConditionalMacros.r
 
 	Contains:	Set up for compiler independent conditionals
 
 	Version:	Technology:	Universal Interface Files 3.3
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1993-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/

#ifndef __CONDITIONALMACROS_R__
#define __CONDITIONALMACROS_R__

/****************************************************************************************************
	UNIVERSAL_INTERFACES_VERSION
	
		0x0330 => version 3.3
		0x0320 => version 3.2
		0x0310 => version 3.1
		0x0301 => version 3.0.1
		0x0300 => version 3.0
		0x0210 => version 2.1
		This conditional did not exist prior to version 2.1
****************************************************************************************************/
#define UNIVERSAL_INTERFACES_VERSION 0x0323

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
		TARGET_RT_MAC_CFM		- TARGET_OS_MAC is true and CFM68K or PowerPC CFM (TVectors) are used
		TARGET_RT_MAC_MACHO     - TARGET_OS_MAC is true and Mach-O style runtime
		TARGET_RT_MAC_68881		- TARGET_OS_MAC is true and 68881 floating point instructions used	


	TARGET__API_≈_≈	
	These conditionals are used to differentiate between sets of API's on the same
	processor under the same OS.  The first section after _API_ is the OS.  The
	second section is the API set.  Unlike TARGET_OS_ and TARGET_CPU_, these
	conditionals are not mutally exclusive. This file will attempt to auto-configure
	all TARGET_API_≈_≈ values, but will often need a TARGET_API_≈_≈ value predefined
	in order to disambiguate.
	
		TARGET_API_MAC_OS8      - Code is being compiled to run on System 7 through Mac OS 8.x
		TARGET_API_MAC_CARBON   - Code is being compiled to run on Mac OS 8 and Mac OS X via CarbonLib
		TARGET_API_MAC_OSX      - Code is being compiled to run on Mac OS X


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


	FUNCTION_≈
	These conditionals specify whether the compiler supports particular language extensions
	to function prototypes and definitions.

		FUNCTION_PASCAL			- Compiler supports "pascal void Foo()"
		FUNCTION_DECLSPEC		- Compiler supports "__declspec(xxx) void Foo()"
		FUNCTION_WIN32CC		- Compiler supports "void __cdecl Foo()" and "void __stdcall Foo()"

****************************************************************************************************/



#define PRAGMA_ONCE	0

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

		#define TARGET_CPU_MIPS				0
		#define TARGET_CPU_SPARC			0
		#define TARGET_CPU_X86				1
		#define TARGET_CPU_PPC				0

	
	#elif Environ_OS_Unix
		/*
			Rez resource compiler for unix from QuickTime 3.0, Apple Computer, Inc.	
		*/
		#define TARGET_OS_MAC				1
		#define TARGET_OS_WIN32				0
		#define TARGET_OS_UNIX				0
		#define TARGET_RT_LITTLE_ENDIAN		0
		#define TARGET_RT_BIG_ENDIAN		1
		#define forCarbon					1

		#define TARGET_CPU_MIPS				Environ_CPU_MIPS
		#define TARGET_CPU_SPARC			Environ_CPU_SPARC
		#define TARGET_CPU_X86				Environ_CPU_X86
		#define TARGET_CPU_PPC				Environ_CPU_PPC

	
	#else
		/*
			Rez resource compiler for MacOS from QuickTime 3.0, Apple Computer, Inc.	
		*/
		#define TARGET_OS_MAC				1
		#define TARGET_OS_WIN32				0
		#define TARGET_OS_UNIX				0
		#define TARGET_RT_LITTLE_ENDIAN		0
		#define TARGET_RT_BIG_ENDIAN		1
		#define forCarbon					0

		#define TARGET_CPU_MIPS				0
		#define TARGET_CPU_SPARC			0
		#define TARGET_CPU_X86				0
		#define TARGET_CPU_PPC				1
	#endif

	
#else
	/*
		Rez resource compiler for MacOS, Apple Computer, Inc.	
	*/
	#define TARGET_OS_MAC				1
	#define TARGET_OS_WIN32				0
	#define TARGET_OS_UNIX				0
	#define forCarbon					0
	#define TARGET_RT_LITTLE_ENDIAN		0
	#define TARGET_RT_BIG_ENDIAN		1
#endif

	
#if !defined(TARGET_REZ_MAC_68K)
    #define TARGET_REZ_MAC_68K      0
#endif
#if !defined(TARGET_REZ_MAC_PPC)
    #define TARGET_REZ_MAC_PPC      0
#endif



/****************************************************************************************************
	
	Set up TARGET_API_≈_≈ values

****************************************************************************************************/
/* grandfather in use of TARGET_CARBON */
/* grandfather in use of TARGET_CARBON */
#if TARGET_OS_MAC
#if !defined(TARGET_API_MAC_OS8) && !defined(TARGET_API_MAC_OSX) && !defined(TARGET_API_MAC_CARBON)
#ifdef TARGET_CARBON
#if TARGET_CARBON
#define TARGET_API_MAC_OS8 0
#define TARGET_API_MAC_CARBON 1
#define TARGET_API_MAC_OSX 0
#endif  /* TARGET_CARBON */

#endif  /* defined(TARGET_CARBON) */

#endif  /* !defined(TARGET_API_MAC_OS8) && !defined(TARGET_API_MAC_OSX) && !defined(TARGET_API_MAC_CARBON) */

/* No TARGET_API_MAC_* predefind on command line */
#if !defined(TARGET_API_MAC_OS8) && !defined(TARGET_API_MAC_OSX) && !defined(TARGET_API_MAC_CARBON)
#define TARGET_API_MAC_OS8 1
#define TARGET_API_MAC_CARBON 0
#define TARGET_API_MAC_OSX 0
#endif  /* !defined(TARGET_API_MAC_OS8) && !defined(TARGET_API_MAC_OSX) && !defined(TARGET_API_MAC_CARBON) */

#endif  /* TARGET_OS_MAC */

/* Support source code still using TARGET_CARBON */
#ifndef TARGET_CARBON
#if TARGET_API_MAC_CARBON && !TARGET_API_MAC_OS8
#define TARGET_CARBON 1
#else
#define TARGET_CARBON 0
#endif  /* TARGET_API_MAC_CARBON && !TARGET_API_MAC_OS8 */

#endif  /* !defined(TARGET_CARBON) */

/* Set forCarbon to 0 if it's not already defined */
#ifndef forCarbon
#define forCarbon 0
#endif  /* !defined(forCarbon) */



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
	
****************************************************************************************************/
#ifndef OLDROUTINENAMES
#define OLDROUTINENAMES 0
#endif  /* !defined(OLDROUTINENAMES) */



/****************************************************************************************************

	TARGET_CARBON					- default: false. Switches all of the above as described.  Overrides all others
									- NOTE: If you set TARGET_CARBON to 1, then the other switches will be setup by
											ConditionalMacros, and should not be set manually.

	If you wish to do development for pre-Carbon Systems, you can set the following:

	OPAQUE_TOOLBOX_STRUCTS			- default: false. True for Carbon builds, hides struct fields.
	OPAQUE_UPP_TYPES				- default: false. True for Carbon builds, UPP types are unique and opaque.
	ACCESSOR_CALLS_ARE_FUNCTIONS	- default: false. True for Carbon builds, enables accessor functions.
	CALL_NOT_IN_CARBON	 			- default: true.  False for Carbon builds, hides calls not supported in Carbon.
	
	Specifically, if you are building a non-Carbon application (one that links against InterfaceLib)
	but you wish to use some of the accessor functions, you can set ACCESSOR_CALLS_ARE_FUNCTIONS to 1
	and link with PreCarbon.o, which implements just the accessor functions. This will help you preserve
	source compatibility between your Carbon and non-Carbon application targets.
	
	MIXEDMODE_CALLS_ARE_FUNCTIONS	- deprecated.

****************************************************************************************************/
#if TARGET_API_MAC_CARBON && !TARGET_API_MAC_OS8
#ifndef OPAQUE_TOOLBOX_STRUCTS
#define OPAQUE_TOOLBOX_STRUCTS 1
#endif  /* !defined(OPAQUE_TOOLBOX_STRUCTS) */

#ifndef OPAQUE_UPP_TYPES
#define OPAQUE_UPP_TYPES 1
#endif  /* !defined(OPAQUE_UPP_TYPES) */

#ifndef ACCESSOR_CALLS_ARE_FUNCTIONS
#define ACCESSOR_CALLS_ARE_FUNCTIONS 1
#endif  /* !defined(ACCESSOR_CALLS_ARE_FUNCTIONS) */

#ifndef CALL_NOT_IN_CARBON
#define CALL_NOT_IN_CARBON 0
#endif  /* !defined(CALL_NOT_IN_CARBON) */

#ifndef MIXEDMODE_CALLS_ARE_FUNCTIONS
#define MIXEDMODE_CALLS_ARE_FUNCTIONS 1
#endif  /* !defined(MIXEDMODE_CALLS_ARE_FUNCTIONS) */

#else
#ifndef OPAQUE_TOOLBOX_STRUCTS
#define OPAQUE_TOOLBOX_STRUCTS 0
#endif  /* !defined(OPAQUE_TOOLBOX_STRUCTS) */

#ifndef OPAQUE_UPP_TYPES
#define OPAQUE_UPP_TYPES 0
#endif  /* !defined(OPAQUE_UPP_TYPES) */

#ifndef ACCESSOR_CALLS_ARE_FUNCTIONS
#define ACCESSOR_CALLS_ARE_FUNCTIONS 0
#endif  /* !defined(ACCESSOR_CALLS_ARE_FUNCTIONS) */

/*
	 * It's possible to have ACCESSOR_CALLS_ARE_FUNCTIONS set to true and OPAQUE_TOOLBOX_STRUCTS
	 * set to false, but not the other way around, so make sure the defines are not set this way.
	 */
#ifndef CALL_NOT_IN_CARBON
#define CALL_NOT_IN_CARBON 1
#endif  /* !defined(CALL_NOT_IN_CARBON) */

#ifndef MIXEDMODE_CALLS_ARE_FUNCTIONS
#define MIXEDMODE_CALLS_ARE_FUNCTIONS 0
#endif  /* !defined(MIXEDMODE_CALLS_ARE_FUNCTIONS) */

#endif  /* TARGET_API_MAC_CARBON && !TARGET_API_MAC_OS8 */



#endif /* __CONDITIONALMACROS_R__ */

