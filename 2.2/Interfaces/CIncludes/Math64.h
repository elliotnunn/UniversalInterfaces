/*
 	File:		Math64.h
 
 	Contains:	64-bit integer math Interfaces.
 
 	Version:	Technology:	Math64Lib
 				Package:	Use with Universal Interfaces 2.1
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __MATH64__
#define __MATH64__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

/*--------------------------------------------------------------------------------
				These routines are intended to provide C software support for
				64 bit integer types.  Their behavior should mimic anticipated
				64 bit hardware. This implementation should replace use of the
				"wide" type found in PowerPC.

	The following routines are available for performing math on 64-bit integers:
	
	S64Max
				Returns the largest representable SInt64.
	S64Min
				Returns the smallest (i.e. most negative) SInt64.  Note: the negative
				(absolute value) of this number is not representable in an SInt64.
				That means that S64Negate(S64Min) is not representable (in fact,
				it returns S64Min).
	S64Add
				Adds two integers, producing an integer result.  If an overflow
				occurs the result is congruent mod (2^64) as if the operands and
				result were unsigned.  No overflow is signaled.
	
	S64Subtract
				Subtracts two integers, producing an integer result.  If an overflow
				occurs the result is congruent mod (2^64) as if the operands and
				result were unsigned.  No overflow is signaled.

	S64Negate
				Returns the additive inverse of a signed number (i.e. it returns
				0 - the number).  S64Negate (S64Min) is not representable (in fact,
				it returns S64Min).
	
	S64Absolute
				Returns the absolute value of the number (i.e. the number if
				it is positive, or 0 - the number if it is negative).
				See S64Negate above.
				
	S64Multiply
				Multiplies two signed numbers, producing a signed result.  Overflow
				is ignored and the low-order part of the product is returned.  The
				sign of the result is not guaranteed to be correct if the magnitude
				of the product is not representable.
	S64Divide
				Divides dividend by divisor, returning the quotient.  The remainder
				is returned in *remainder if remainder (the pointer) is non-NULL.
				The sign of the remainder is the same as the sign of the dividend
				(i.e. it takes the absolute values of the operands, does the division,
				then fixes the sign of the quotient and remainder).  If the divisor
				is zero, then S64Max() will be returned (or S64Min() if the dividend
				is negative), and the remainder will be the dividend; no error is
				reported.
	
	S64Set
				Given an SInt32, returns an SInt64 with the same value.  Use this
				routine instead of coding 64-bit constants (at least when the
				constant will fit in an SInt32).
	
	S64SetU
				Given a UInt32, returns a SInt64 with the same value.
	
	S64Compare
				Given two signed numbers, left and right, returns an
				SInt32 that compares with zero the same way left compares with
				right.  If you wanted to perform a comparison on 64-bit integers
				of the form:
						operand_1 <operation> operand_2
				then you could use an expression of the form:
						xxxS64Compare(operand_1,operand_2) <operation> 0
				to test for the same condition.
				
				CAUTION: DO NOT depend on the exact value returned by this routine.
				Only the sign (i.e. positive, zero, or negative) of the result is
				guaranteed.

	S64And, S64Or, S64Eor and S64Not
	
				Return Boolean (1 or 0) depending on the outcome of the logical
				operation.

	S64BitwiseAnd, S64BitwiseOr, S64BitwiseEor and S64BitwiseNot
	
				Return the Bitwise result.
				
	S64ShiftRight and S64ShiftLeft
	
				The lower 7 bits of the shift argument determines the amount of 
				shifting.  S64ShiftRight is an arithmetic shift while U64ShiftRight
				is a logical shift.

	SInt64ToLongDouble
				
				Converts SInt64 to long double.  Note all SInt64s fit exactly into 
				long doubles, thus, the binary -> decimal conversion routines
				in fp.h can be used to achieve SInt64 -> long double -> decimal
				conversions.
				
	LongDoubleToSInt64
	
				Converts a long double to a SInt64.  Any decimal string that fits
				into a SInt64 can be converted exactly into a long double, using the
				conversion routines found in fp.h.  Then this routine can be used
				to complete the conversion to SInt64.
				
				
	
	The corresponding UInt64 routines are also included.
	
--------------------------------------------------------------------------------*/
struct SInt64 {
	SInt32							hi;
	UInt32							lo;
};
typedef struct SInt64 SInt64;

struct UInt64 {
	UInt32							hi;
	UInt32							lo;
};
typedef struct UInt64 UInt64;

#if GENERATINGPOWERPC
extern SInt64 S64Max(void);
extern SInt64 S64Min(void);
extern SInt64 S64Add(SInt64 x, SInt64 y);
extern SInt64 S64Subtract(SInt64 left, SInt64 right);
extern SInt64 S64Negate(SInt64 value);
extern SInt64 S64Absolute(SInt64 value);
extern SInt64 S64Multiply(SInt64 xparam, SInt64 yparam);
extern SInt64 S64Divide(SInt64 dividend, SInt64 divisor, SInt64 *remainder);
extern SInt64 S64Set(SInt32 value);
extern SInt64 S64SetU(UInt32 value);
extern SInt32 S32Set(SInt64 value);
extern int S64Compare(SInt64 left, SInt64 right);
extern Boolean S64And(SInt64 left, SInt64 right);
extern Boolean S64Or(SInt64 left, SInt64 right);
extern Boolean S64Eor(SInt64 left, SInt64 right);
extern Boolean S64Not(SInt64 value);
extern SInt64 S64BitwiseAnd(SInt64 left, SInt64 right);
extern SInt64 S64BitwiseOr(SInt64 left, SInt64 right);
extern SInt64 S64BitwiseEor(SInt64 left, SInt64 right);
extern SInt64 S64BitwiseNot(SInt64 value);
extern SInt64 S64ShiftRight(SInt64 value, UInt32 shift);
extern SInt64 S64ShiftLeft(SInt64 value, UInt32 shift);
extern long double SInt64ToLongDouble(SInt64 value);
extern SInt64 LongDoubleToSInt64(long double value);
extern UInt64 U64Max(void);
extern UInt64 U64Add(UInt64 x, UInt64 y);
extern UInt64 U64Subtract(UInt64 left, UInt64 right);
extern UInt64 U64Multiply(UInt64 xparam, UInt64 yparam);
extern UInt64 U64Divide(UInt64 dividend, UInt64 divisor, UInt64 *remainder);
extern UInt64 U64Set(SInt32 value);
extern UInt64 U64SetU(UInt32 value);
extern UInt32 U32SetU(UInt64 value);
extern int U64Compare(UInt64 left, UInt64 right);
extern Boolean U64And(UInt64 left, UInt64 right);
extern Boolean U64Or(UInt64 left, UInt64 right);
extern Boolean U64Eor(UInt64 left, UInt64 right);
extern Boolean U64Not(UInt64 value);
extern UInt64 U64BitwiseAnd(UInt64 left, UInt64 right);
extern UInt64 U64BitwiseOr(UInt64 left, UInt64 right);
extern UInt64 U64BitwiseEor(UInt64 left, UInt64 right);
extern UInt64 U64BitwiseNot(UInt64 value);
extern UInt64 U64ShiftRight(UInt64 value, UInt32 shift);
extern UInt64 U64ShiftLeft(UInt64 value, UInt32 shift);
extern long double UInt64ToLongDouble(UInt64 value);
extern UInt64 LongDoubleToUInt64(long double value);
extern SInt64 UInt64ToSInt64(UInt64 value);
extern UInt64 SInt64ToUInt64(SInt64 value);
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __MATH64__ */
