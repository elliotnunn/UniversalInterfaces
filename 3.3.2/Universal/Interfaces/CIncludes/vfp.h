/*
     File:       vfp.h
 
     Contains:   MathLib style functions for vectors
 
     Version:    Technology: 1.0
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1999-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __VFP__
#define __VFP__

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

/*
———————————————————————————————————————————————————————————————————————————————
                                                                                
    A collection of numerical functions designed to facilitate a wide         
    range of numerical programming for the Altivect Programming model.      
                                                                                
———————————————————————————————————————————————————————————————————————————————
*/
#ifdef __VEC__
/*
————————————————————————[ Computational Functions]—————————————————————————————
                                                                                
    Divf        C = A ÷ B                                                       
    Sqrtf       B = √A                                                          
    RSqrtf      B = 1/√A                                                        
                                                                                
———————————————————————————————————————————————————————————————————————————————
*/
#if CALL_NOT_IN_CARBON
EXTERN_API_C( vector float ) vDivf(vector float A, vector float B);

EXTERN_API_C( vector float ) vSqrtf(vector float X);

EXTERN_API_C( vector float ) vRSqrtf(vector float X);



/*
——————————————————————————[ Exponential Functions]—————————————————————————————
                                                                                
    Exp         B = Exp(A)                                                      
    ExpM1       ExpM1(x) = Exp(x) - 1.  But, for small enough arguments,        
                ExpM1(x) is expected to be more accurate than Exp(x) - 1.       
    Log         B = Log(A)                                                      
    Log1P       Log1P = Log(1 + x). But, for small enough arguments,            
                Log1P is expected to be more accurate than Log(1 + x).          
    Logb        Extracts the exponent of its argument, as a signed integral     
                value. A subnormal argument is treated as though it were first  
                normalized. Thus:                                               
                1   <=   x * 2^(-logb(x))   <   2                           
    Scalb       Computes x * 2^n efficently.  This is not normally done by      
                computing 2^n explicitly.                                       
                                                                                
———————————————————————————————————————————————————————————————————————————————
*/
EXTERN_API_C( vector float ) vExpf(vector float X);

EXTERN_API_C( vector float ) vExpM1f(vector float X);

EXTERN_API_C( vector float ) vLogf(vector float X);

EXTERN_API_C( vector float ) vLog1Pf(vector float X);

EXTERN_API_C( vector float ) vLogbf(vector float X);

EXTERN_API_C( vector float ) vScalbf(vector float X, vector signed int n);



/*
———————————————————————————[ Auxiliary Functions]——————————————————————————————
                                                                                
    fab             Absolute value is part of the programming model, however    
                    completeness it is included in the library.                 
    copysign        Produces a value with the magnitude of its first argument   
                    and sign of its second argument.  NOTE: the order of the    
                    arguments matches the recommendation of the IEEE 754        
                    floating point standard,  which is opposite from the SANE   
                    copysign function.                                          
    nextafter       Computes the next representable value after 'x' in the      
                    direction of 'y'.  if x == y, then y is returned.           
                                                                                
———————————————————————————————————————————————————————————————————————————————
*/
EXTERN_API_C( vector float ) vFabf(vector float v);

EXTERN_API_C( vector float ) vCopySignf(vector float arg2, vector float arg1);

EXTERN_API_C( vector float ) vNextafterf(vector float x, vector float y);



/*
—————————————————————————————[ Inquiry Functions]——————————————————————————————
                                                                                
    classify        Returns one of the FP_≈ values.                             
    signbit         Non-zero if and only if the sign of the argument x is       
                    negative.  This includes, NaNs, infinities and zeros.       
                                                                                
———————————————————————————————————————————————————————————————————————————————
*/
EXTERN_API_C( vector unsigned int ) vClassifyf(vector float arg);

EXTERN_API_C( vector unsigned int ) vSignBitf(vector float arg);



/*
—————————————————————————[ Transandental Functions]————————————————————————————
                                                                                
    sin             B = Sin(A).                                                 
    cos             B = Cos(A).                                                 
    tan             B = Tan(A).                                                 
                                                                                
———————————————————————————————————————————————————————————————————————————————
*/
EXTERN_API_C( vector float ) vSinf(vector float arg);

EXTERN_API_C( vector float ) vCosf(vector float arg);

EXTERN_API_C( vector float ) vTanf(vector float arg);



/*
—————————————————————————[ Trigonometric Functions]————————————————————————————
                                                                                
    asin        result is in [-pi/2,pi/2].                                      
    acos        result is in [0,pi].                                            
    atan        result is in [-pi/2,pi/2].                                      
    atan2       Computes the arc tangent of y/x in [-pi,pi] using the sign of   
                both arguments to determine the quadrant of the computed value. 
                                                                                
———————————————————————————————————————————————————————————————————————————————
*/
EXTERN_API_C( vector float ) vASinf(vector float arg);

EXTERN_API_C( vector float ) vACosf(vector float arg);

EXTERN_API_C( vector float ) vATanf(vector float arg);

EXTERN_API_C( vector float ) vATan2f(vector float arg1, vector float arg2);



/*
——————————————————————————[ Hyperbolic Functions]——————————————————————————————
                                                                                
    Sinh        Sine Hyperbolic.                                                
    Cosh        Cosine Hyperbolic.                                              
    Tanh        Tangent Hyperbolic.                                             
                                                                                
———————————————————————————————————————————————————————————————————————————————
*/
EXTERN_API_C( vector float ) vSinhf(vector float X);

EXTERN_API_C( vector float ) vCoshf(vector float X);

EXTERN_API_C( vector float ) vTanhf(vector float X);



/*
———————————————————————————[ Remainder Functions]——————————————————————————————
                                                                                
    mod             B = X mod Y.                                                
    remainder       IEEE 754 floating point standard for remainder.             
    remquo          SANE remainder.  It stores into 'quotient' the 7 low-order  
                    bits of the integer quotient x/y, such that:                
                    -127 <= quotient <= 127.                                
                                                                                
———————————————————————————————————————————————————————————————————————————————
*/
EXTERN_API_C( vector float ) vFModf(vector float X, vector float Y);

EXTERN_API_C( vector float ) vRemainderf(vector float X, vector float Y);

EXTERN_API_C( vector float ) vRemQuof(vector float X, vector float Y, vector unsigned int *QUO);



/*
——————————————————————————————[ Power Functions]——————————————————————————————
                                                                                
    ipow            Returns x raised to the integer power of y.                 
    pow             Returns x raised to the power of y.  Result is more         
                    accurate than using exp(log(x)*y).                          
                                                                                
———————————————————————————————————————————————————————————————————————————————
*/
EXTERN_API_C( vector float ) vIPowf(vector float X, vector signed int Y);

EXTERN_API_C( vector float ) vPowf(vector float X, vector float Y);



/*
———————————————————————————————————————————————————————————————————————————————
    Useful                                                                      
———————————————————————————————————————————————————————————————————————————————
*/
EXTERN_API_C( vector unsigned int ) vTableLookUp(vector signed int Index_Vect, unsigned long *Table);

#endif  /* CALL_NOT_IN_CARBON */

#endif  /* defined(__VEC__) */


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

#endif /* __VFP__ */

