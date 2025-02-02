/*
 	File:		Types.h
 
 	Contains:	Basic Macintosh data types.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1985-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
#ifndef __TYPES__
#define __TYPES__

#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif



#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
	#pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
	#pragma pack(2)
#endif

/********************************************************************************

	Special values in C
	
		NULL		The C standard for an impossible pointer value
		nil			A carry over from pascal, NULL is prefered for C
		
*********************************************************************************/
#ifndef NULL
	/* Symantec C compilers (but not C++) want NULL and nil to be (void*)0  */
	#if !defined(__cplusplus) && (defined(__SC__) || defined(THINK_C))
		#define NULL ((void *) 0)
	#else
		#define	NULL 0
	#endif
#endif

#ifndef nil
	#define nil NULL
#endif


/********************************************************************************

	Base integer types for all target OS's and CPU's
	
		UInt8			 8-bit unsigned integer	
		SInt8			 8-bit signed integer
		UInt16			16-bit unsigned integer	
		SInt16			16-bit signed integer			
		UInt32			32-bit unsigned integer	
		SInt32			32-bit signed integer	
		UInt64			64-bit unsigned integer	
		SInt64			64-bit signed integer	

*********************************************************************************/
typedef unsigned char 					UInt8;
typedef signed char 					SInt8;
typedef unsigned short 					UInt16;
typedef signed short 					SInt16;
typedef unsigned long 					UInt32;
typedef signed long 					SInt32;
struct wide {
	SInt32 							hi;
	UInt32 							lo;
};
typedef struct wide wide;

struct UnsignedWide {
	UInt32 							hi;
	UInt32 							lo;
};
typedef struct UnsignedWide UnsignedWide;


#if TYPE_LONGLONG
/*
	Note:	wide and UnsignedWide must always be structs for source code
			compatibility. On the other hand UInt64 and SInt64 can be
			either a struct or a long long, depending on the compiler.
			
			If you use UInt64 and SInt64 you should do all operations on 
			those data types through the functions/macros in Math64.h.  
			This will assure that your code compiles with compilers that
			support long long and those that don't.
*/
typedef   signed long long 				SInt64;
typedef unsigned long long  			UInt64;

#else

typedef wide 							SInt64;
typedef UnsignedWide 					UInt64;
#endif	/* TYPE_LONGLONG */

/********************************************************************************

	Base fixed point types 
	
		Fixed			16-bit signed integer plus 16-bit fraction
		UnsignedFixed	16-bit unsigned integer plus 16-bit fraction
		Fract			2-bit signed integer plus 30-bit fraction
		ShortFixed		8-bit signed integer plus 8-bit fraction
		
*********************************************************************************/
typedef long 							Fixed;
typedef Fixed *							FixedPtr;
typedef long 							Fract;
typedef Fract *							FractPtr;
typedef unsigned long 					UnsignedFixed;
typedef short 							ShortFixed;


/********************************************************************************

	Base floating point types 
	
		Float32			32 bit IEEE float:  1 sign bit, 8 exponent bits, 23 fraction bits
		Float64			64 bit IEEE float:  1 sign bit, 11 exponent bits, 52 fraction bits	
		Float80			80 bit MacOS float: 1 sign bit, 15 exponent bits, 1 integer bit, 63 fraction bits
		Float96			96 bit 68881 float: 1 sign bit, 15 exponent bits, 16 pad bits, 1 integer bit, 63 fraction bits
		
	Note: These are fixed size floating point types, useful when writing a floating
		  point value to disk.  If your compiler does not support a particular size 
		  float, a struct is used instead.
		  Use of of the NCEG types (e.g. double_t) or an ANSI C type (e.g. double) if
		  you want a floating point representation that is natural for any given
		  compiler, but might be a different size on different compilers.

*********************************************************************************/
typedef float				Float32;
#if defined(__MWERKS__) || defined(THINK_C)
	typedef short double	Float64;
#else
	typedef double			Float64;
#endif
#if TARGET_CPU_68K
	#if TARGET_RT_MAC_68881
		typedef long double	Float96;		
		struct Float80 {
			SInt16 	exp;
			UInt16 	man[4];
		};
		typedef struct Float80 Float80;
	#else
		typedef long double	Float80;		
		struct Float96 {
			SInt16 	exp[2];		/* the second 16-bits is always zero */
			UInt16 	man[4];
		};
		typedef struct Float96 Float96;
	#endif
#else
	struct Float80 {
		SInt16 	exp;
		UInt16 	man[4];
	};
	typedef struct Float80 Float80;
	
	struct Float96 {
		SInt16 	exp[2];		/* the second 16-bits is always zero */
		UInt16 	man[4];
	};
	typedef struct Float96 Float96;
#endif



/********************************************************************************

	MacOS Memory Manager types
	
		Ptr				Pointer to a non-relocatable block
		Handle			Pointer to a master pointer to a relocatable block
		Size			The number of bytes in a block (signed for historical reasons)
		
*********************************************************************************/
typedef char *							Ptr;
typedef Ptr *							Handle;
typedef long 							Size;

/********************************************************************************

	Higher level basic types
	
		OSErr					16-bit result error code
		OSStatus				32-bit result error code
		LogicalAddress			Address in the clients virtual address space
		ConstLogicalAddress		Address in the clients virtual address space that will only be read
		PhysicalAddress			Real address as used on the hardware bus
		BytePtr					Pointer to an array of bytes
		ByteCount				The size of an array of bytes
		ByteOffset				An offset into an array of bytes
		ItemCount				32-bit iteration count
		OptionBits				Standard 32-bit set of bit flags
		PBVersion				?
		Duration				32-bit millisecond timer for drivers
		AbsoluteTime			64-bit clock
		ScriptCode				The coarse features of a written language (e.g. Roman vs Cyrillic)
		LangCode				A particular language (e.g. English)
		RegionCode				A variation of a language (British vs American English)
		FourCharCode			A 32-bit value made by packing four 1 byte characters together
		OSType					A FourCharCode used in the OS and file system (e.g. creator)
		ResType					A FourCharCode used to tag resources (e.g. 'DLOG')
		
*********************************************************************************/
typedef SInt16 							OSErr;
typedef SInt32 							OSStatus;
typedef void *							LogicalAddress;
typedef const void *					ConstLogicalAddress;
typedef void *							PhysicalAddress;
typedef UInt8 *							BytePtr;
typedef UInt32 							ByteCount;
typedef UInt32 							ByteOffset;
typedef SInt32 							Duration;
typedef UnsignedWide 					AbsoluteTime;
typedef UInt32 							OptionBits;
typedef UInt32 							ItemCount;
typedef UInt32 							PBVersion;
typedef SInt16 							ScriptCode;
typedef SInt16 							LangCode;
typedef SInt16 							RegionCode;
typedef unsigned long 					FourCharCode;
typedef FourCharCode 					OSType;
typedef FourCharCode 					ResType;
typedef OSType *						OSTypePtr;
typedef ResType *						ResTypePtr;


/********************************************************************************

	Boolean types and values
	
		Boolean			A one byte value, holds "false" (0) or "true" (1)
		false			The Boolean value of zero (0)
		true			The Boolean value of one (1)
		
*********************************************************************************/
/*
	The identifiers "true" and "false" are becoming keywords in C++
	and work with the new built-in type "bool"
	"Boolean" will remain an unsigned char for compatibility with source
	code written before "bool" existed.
*/
#if !TYPE_BOOL

enum {
	false						= 0,
	true						= 1
};

#endif  /*  !TYPE_BOOL */

typedef unsigned char 					Boolean;


/********************************************************************************

	Function Pointer Types
	
		ProcPtr					Generic pointer to a function
		Register68kProcPtr		Pointer to a 68K function that expects parameters in registers
		UniversalProcPtr		Pointer to classic 68K code or a RoutineDescriptor
		
		ProcHandle				Pointer to a ProcPtr
		UniversalProcHandle		Pointer to a UniversalProcPtr
		
*********************************************************************************/
typedef CALLBACK_API_C( long , ProcPtr )();
typedef CALLBACK_API( void , Register68kProcPtr )();
#if TARGET_OS_MAC && TARGET_RT_MAC_CFM
/*	Note that the RoutineDescriptor structure is defined in the MixedMode.h header */
typedef struct RoutineDescriptor *UniversalProcPtr;
#else
typedef ProcPtr 						UniversalProcPtr;
#endif  /* TARGET_OS_MAC && TARGET_RT_MAC_CFM */

typedef ProcPtr *						ProcHandle;
typedef UniversalProcPtr *				UniversalProcHandle;


/********************************************************************************

	Common Constants
	
		noErr					OSErr: function performed properly - no error
		kNilOptions				OptionBits: all flags false
		kInvalidID				KernelID: NULL is for pointers as kInvalidID is for ID's
		kVariableLengthArray	array bounds: variable length array

	Note: kVariableLengthArray is used in array bounds to specify a variable length array.
		  It is ususally used in variable length structs when the last field is an array
		  of any size.  Before ANSI C, we used zero as the bounds of variable length 
		  array, but zero length array are illegal in ANSI C.  Example usage:
	
		struct FooList 
		{
			short 	listLength;
			Foo		elements[kVariableLengthArray];
		};
		
*********************************************************************************/

enum {
	noErr						= 0
};


enum {
	kNilOptions					= 0
};

#define kInvalidID	 0

enum {
	kVariableLengthArray		= 1
};



/********************************************************************************

	String Types
	
		UniChar					A single UniCode character (16-bits)

		StrNNN					Pascal string holding up to NNN bytes
		StringPtr				Pointer to a pascal string
		StringHandle			Pointer to a StringPtr
		ConstStrNNNParam		For function parameters only - means string is const
		
		CStringPtr				Pointer to a C string       (same as:  char*)
		ConstCStringPtr			Pointer to a const C string (same as:  const char*)
		
	Note: The length of a pascal string is stored in the first byte.
		  A pascal string does not have a termination byte and can be at most 255 bytes long.
		  The first character in a pascal string is offset one byte from the start of the string. 
		  
		  A C string is terminated with a byte of value zero.  
		  A C string has no length limitation.
		  The first character in a C string is the first byte of the string. 
		  
		
*********************************************************************************/
typedef UInt16 							UniChar;
typedef unsigned char 					Str255[256];
typedef unsigned char 					Str63[64];
typedef unsigned char 					Str32[33];
typedef unsigned char 					Str31[32];
typedef unsigned char 					Str27[28];
typedef unsigned char 					Str15[16];
/*
	The type Str32 is used in many AppleTalk based data structures.
	It holds up to 32 one byte chars.  The problem is that with the
	length byte it is 33 bytes long.  This can cause weird alignment
	problems in structures.  To fix this the type "Str32Field" has
	been created.  It should only be used to hold 32 chars, but
	it is 34 bytes long so that there are no alignment problems.
*/
typedef unsigned char 					Str32Field[34];
typedef unsigned char *					StringPtr;
typedef StringPtr *						StringHandle;
typedef const unsigned char *			ConstStr255Param;
typedef const unsigned char *			ConstStr63Param;
typedef const unsigned char *			ConstStr32Param;
typedef const unsigned char *			ConstStr31Param;
typedef const unsigned char *			ConstStr27Param;
typedef const unsigned char *			ConstStr15Param;
#ifdef __cplusplus
inline unsigned char StrLength(ConstStr255Param string) { return (*string); }
#else
#define StrLength(string) (*(unsigned char *)(string))
#endif  /*  defined(__cplusplus)  */

#if OLDROUTINENAMES
#define Length(string) StrLength(string)
#endif  /* OLDROUTINENAMES */

/********************************************************************************

	Quickdraw Types
	
		Point				2D Quickdraw coordinate, range: -32K to +32K
		Rect				Rectangluar Quickdraw area
		Style				Quickdraw font rendering styles
		StyleParameter		Style when used as a parameter (historical 68K convention)
		StyleField			Style when used as a field (historical 68K convention)
		CharParameter		Char when used as a parameter (historical 68K convention)
		
	Note:   The original Macintosh toolbox in 68K Pascal defined Style as a SET.  
			Both Style and CHAR occupy 8-bits in packed records or 16-bits when 
			used as fields in non-packed records or as parameters. 
		
*********************************************************************************/
struct Point {
	short 							v;
	short 							h;
};
typedef struct Point Point;

typedef Point *							PointPtr;
struct Rect {
	short 							top;
	short 							left;
	short 							bottom;
	short 							right;
};
typedef struct Rect Rect;

typedef Rect *							RectPtr;
typedef short 							CharParameter;

enum {
	normal						= 0,
	bold						= 1,
	italic						= 2,
	underline					= 4,
	outline						= 8,
	shadow						= 0x10,
	condense					= 0x20,
	extend						= 0x40
};

typedef unsigned char 					Style;
typedef short 							StyleParameter;
typedef Style 							StyleField;


/********************************************************************************

	THINK C base objects

		HandleObject		Root class for handle based THINK C++ objects
		PascalObject		Root class for pascal style objects in THINK C++ 

*********************************************************************************/
#if defined(__SC__) && !defined(__STDC__) && defined(__cplusplus)
	class __machdl HandleObject {};
	#if TARGET_CPU_68K
		class __pasobj PascalObject {};
	#endif
#endif


/********************************************************************************

	MacOS versioning structures
	
		VersRec					Contents of a 'vers' resource
		VersRecPtr				Pointer to a VersRecPtr
		VersRecHndl				Resource Handle containing a VersRec
		NumVersion				Packed BCD version representation (e.g. "4.2.1a3" is 0x04214003)
		UniversalProcPtr		Pointer to classic 68K code or a RoutineDescriptor
		
		ProcHandle				Pointer to a ProcPtr
		UniversalProcHandle		Pointer to a UniversalProcPtr
		
*********************************************************************************/
struct NumVersion {
																/* Numeric version part of 'vers' resource */
	UInt8 							majorRev;					/*1st part of version number in BCD*/
	UInt8 							minorAndBugRev;				/*2nd & 3rd part of version number share a byte*/
	UInt8 							stage;						/*stage code: dev, alpha, beta, final*/
	UInt8 							nonRelRev;					/*revision level of non-released version*/
};
typedef struct NumVersion NumVersion;


enum {
																/* Version Release Stage Codes */
	developStage				= 0x20,
	alphaStage					= 0x40,
	betaStage					= 0x60,
	finalStage					= 0x80
};

union NumVersionVariant {
																/* NumVersionVariant is a wrapper so NumVersion can be accessed as a 32-bit value */
	NumVersion 						parts;
	unsigned long 					whole;
};
typedef union NumVersionVariant NumVersionVariant;

struct VersRec {
																/* 'vers' resource format */
	NumVersion 						numericVersion;				/*encoded version number*/
	short 							countryCode;				/*country code from intl utilities*/
	Str255 							shortVersion;				/*version number string - worst case*/
	Str255 							reserved;					/*longMessage string packed after shortVersion*/
};
typedef struct VersRec VersRec;

typedef VersRec *						VersRecPtr;
typedef VersRecPtr *					VersRecHndl;
/*********************************************************************************

	Old names for types
		
*********************************************************************************/
typedef UInt8 							Byte;
typedef SInt8 							SignedByte;
typedef wide *							WidePtr;
typedef UnsignedWide *					UnsignedWidePtr;
typedef Float80 						extended80;
typedef Float96 						extended96;
typedef SInt8 							VHSelect;

#if TARGET_OS_MAC
/*********************************************************************************

	Debugger functions:
	
	Name			MacsBug			Macintosh Debugger					Copland Debugger
	----------		-----------		-----------------------------		-------------------
	Debugger		yes				InterfaceLib maps to DebugStr		yes
	DebugStr		yes				yes									yes
	Debugger68k		yes				InterfaceLib maps to DebugStr		obsolete?
	DebugStr68k		yes				InterfaceLib maps to DebugStr		obsolete?
	debugstr		yes				InterfaceLib maps to DebugStr		yes
	SysBreak		no				InterfaceLib maps to SysError		obsolete?
	SysBreakStr		no				InterfaceLib maps to SysError		obsolete?
	SysBreakFunc	no				InterfaceLib maps to SysError		obsolete?
	SysDebug		?				?									?
	SysDebugStr		?				?									?
	LLDebugger		no				yes									Low Level Nub
	LLDebugStr		no				yes									Low Level Nub
	
*********************************************************************************/

EXTERN_API( void )
Debugger						(void)														ONEWORDINLINE(0xA9FF);

EXTERN_API( void )
DebugStr						(ConstStr255Param 		debuggerMsg)						ONEWORDINLINE(0xABFF);

#if CGLUESUPPORTED
EXTERN_API_C( void )
debugstr						(const char *			debuggerMsg);

#endif  /* CGLUESUPPORTED */

#if TARGET_CPU_PPC
/* Only for System 7 native drivers */
EXTERN_API_C( void )
SysDebug						(void);

EXTERN_API_C( void )
SysDebugStr						(ConstStr255Param 		str);

#endif  /* TARGET_CPU_PPC */

/* SADE break points */
EXTERN_API( void )
SysBreak						(void)														THREEWORDINLINE(0x303C, 0xFE16, 0xA9C9);

EXTERN_API( void )
SysBreakStr						(ConstStr255Param 		debuggerMsg)						THREEWORDINLINE(0x303C, 0xFE15, 0xA9C9);

EXTERN_API( void )
SysBreakFunc					(ConstStr255Param 		debuggerMsg)						THREEWORDINLINE(0x303C, 0xFE14, 0xA9C9);

/* old names for Debugger and DebugStr */
#if OLDROUTINENAMES && TARGET_CPU_68K
	#define Debugger68k()	Debugger()
	#define DebugStr68k(s)	DebugStr(s)
#endif
#endif  /* TARGET_OS_MAC */



#if PRAGMA_STRUCT_ALIGN
	#pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
	#pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
	#pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __TYPES__ */

