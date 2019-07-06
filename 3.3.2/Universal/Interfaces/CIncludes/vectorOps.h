/*
     File:       vectorOps.h
 
     Contains:   vector and matrix functions for AltiVec
 
     Version:    Technology: 1.0
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1999-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __VECTOROPS__
#define __VECTOROPS__

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
-------------------------------------------------------------------------------------
                                                                                                                                                                  
 This section is a collection of Basic Linear Algebra Subprograms (BLAS), which   
 use AltiVec technology for their implementations. The functions are grouped into 
 three categories (called levels), as follows:                                    
                                                                                  
    1) Vector-scalar linear algebra subprograms                                   
    2) Matrix-vector linear algebra subprograms                                   
    3) Matrix operations                                                          
                                                                                  
 Following is a list of subprograms and a short description of each one.          
-------------------------------------------------------------------------------------
*/
#ifdef __VEC__
kMinusZero  (vector float)vec_sl((vector unsigned long)(-1),(vector unsigned long)(-1))
#define vec_splat_float(theVector,theFloat) \
{ \
(*((float *)&theVector)) = theFloat; \
theVector = vec_splat(theVector,0); \
}

/*
-------------------------------------------------------------------------------------
     Level 1
-------------------------------------------------------------------------------------
*/
/**************************************************
  vIsamax finds the position of the first vector
  element having the largest magnitude.         
     count  length of vector X (count is a      
            multiple of 4)                      
     X      array of floats                     
**************************************************/
#if CALL_NOT_IN_CARBON
EXTERN_API_C( long )
vIsamax                         (long                   count,
                                 const vector float     x[]);



/**************************************************
  vIsamin finds the position of the first vector
  element having minimum absolute value.        
     count  length of vector X (count is a      
            multiple of 4)                      
     X      array of floats                     
**************************************************/
EXTERN_API_C( long )
vIsamin                         (long                   count,
                                 const vector float     x[]);



/**************************************************
  vIsmax finds the position of the first vector 
  element having maximum value.                 
     count  length of vector X (count is a      
            multiple of 4)                      
     X      array of floats                     
**************************************************/
EXTERN_API_C( long )
vIsmax                          (long                   count,
                                 const vector float     x[]);



/**************************************************
  vIsmin finds the position of the first vector 
  element having minimum value.                 
     count  length of vector X (count is a      
            multiple of 4)                      
     X      array of floats                     
**************************************************/
EXTERN_API_C( long )
vIsmin                          (long                   count,
                                 const vector float     x[]);



/**************************************************
  vSasum finds the sum of the magnitudes of the 
  elements in a vector.                         
     count  length of vector X (count is a      
            multiple of 4)                      
     X      array of floats                     
**************************************************/
EXTERN_API_C( float )
vSasum                          (long                   count,
                                 const vector float     x[]);



/**************************************************
  vSsum is the vector version of sasum but without  
  the absolute value. It takes the value of each
  element of the array and adds them together.      
            multiple of 4)                      
     X      array of floats                     
**************************************************/
EXTERN_API_C( float )
vSsum                           (long                   count,
                                 const vector float     x[]);



/**************************************************
  vSaxpy multiplies a vector X, by a scalar and 
  adds it to a vector Y and stores the result in Y*
     n      number of floats in X (n is a       
            multiple of 4)                      
     Alpha  scalar number is single-precision   
            floating-point                      
     X      array of vector floats              
     Y      array of vector floats, where the   
            the result is stored                
**************************************************/
EXTERN_API_C( void )
vSaxpy                          (long                   n,
                                 float                  alpha,
                                 const vector float     x[],
                                 vector float           y[]);



/*************************************************************
  vScopy copies a vector X, into another vector Y.  
     n      mumber of floats in X and Y (n is a 
            multiple of 4)                      
     X      array of vector floats              
     Y      array of vector floats              
*************************************************************/
EXTERN_API_C( void )
vScopy                          (long                   n,
                                 const vector float     x[],
                                 vector float           y[]);


/*************************************************************
 vSdot finds the dot product of two vectors.      
    n       mumber of floats in X and Y (n is a 
                multiple of 4)                      
    X       array of vector floats              
    Y       array of vector floats              
*************************************************************/
EXTERN_API_C( float )
vSdot                           (long                   n,
                                 const vector float     x[],
                                 const vector float     y[]);


/*************************************************************
 vSnaxpy computes saxpy "n" times.               
   n            number of saxpyV computations to be 
                performed and the number of elements
                in vector A (n is a multiple of 4)  
   m            number of floats in each vector x(i)
                or y(i)                             
   A            array of vector floats containing   
                scalars a(i)                        
   X            matrix containing arrays of vector- 
                floats X(i)                         
   Y            matrix containing vectors Y(i)      
*************************************************************/
EXTERN_API_C( void )
vSnaxpy                         (long                   n,
                                 long                   m,
                                 const vector float     a[],
                                 const vector float     x[],
                                 vector float           y[]);



/*************************************************************
 vSndot computes the dot products "n" times.     
    n       number of dot product computations  
            to be performed and the number of   
                elements in vector S                
    m       number of elements in vectors X(i)  
                and Y(i) for each dot product       
                computation (m is a multiple of 4)  
    S       array of floats. Depending on the   
                value of "isw" different computations/
                are performed and the results are   
                stored in the array S               
    isw     indicates the type of computation   
                to perform.                         
                if isw=1, S(i) <--   X(i)   Y(i)    
                if isw=2, S(i) <-- - X(i)   Y(i)    
                if isw=3, S(i) <-- S(i) + X(i)   Y(i)/
                if isw=4, S(i) <-- S(i) - X(i)   Y(i)/
    X       matrix containing arrays X(i)       
    Y       matrix containing arrays Y(i)       
*************************************************************/
EXTERN_API_C( void )
vSndot                          (long                   n,
                                 long                   m,
                                 float                  s[],
                                 long                   isw,
                                 const vector float     x[],
                                 const vector float     y[]);



/*************************************************************
 vSnrm2 finds the Euclidean length of a vector   
 with scaling of input to avoid destructive      
 underflow and overflow.                         
    count   length of vector (multiple of 4)    
    X       array of vector floats              
*************************************************************/
EXTERN_API_C( float )
vSnrm2                          (long                   count,
                                 const vector float     x[]);



/*************************************************************
 vSnorm2 finds the Euclidean length of a vector  
 with no scaling of input.                       
    count   length of vector (multiple of 4)    
    X       array of vector floats              
*************************************************************/
EXTERN_API_C( float )
vSnorm2                         (long                   count,
                                 const vector float     x[]);



/*************************************************************
 vSrot applies a plane rotation.                 
    n       number of points to be rotated, also
                number of elements in X and Y (n is 
                a multiple of 4)                    
    X       array of vector floats. It is a     
                vector of length n, containing X(i) 
                coordinates of points to be rotated 
    Y       array of vector floats. It is a     
                vector of length n, containing Y(i) 
                coordinates of points to be rotated 
    c       cosine of angle of rotation         
    s       sine of angle of rotation           
*************************************************************/
EXTERN_API_C( void )
vSrot                           (long                   n,
                                 vector float           x[],
                                 vector float           y[],
                                 float                  c,
                                 float                  s);



/*************************************************************
 vSscal multiplies a vector X, by a scalar and   
 stores the result in the vector X.              
    n       number of floats in X (n is a       
                multiple of 4)                      
    Alpha   scalar number is single-precision   
                floating-point                      
    X       array of vector floats              
*************************************************************/
EXTERN_API_C( void )
vSscal                          (long                   n,
                                 float                  alpha,
                                 vector float           X[]);



/*************************************************************
 vSswap interchanges the elements of vectors X   
 and Y                                           
    n       number of floats in X and Y (n is a 
                multiple of 4)                      
    X       array of vector floats              
    Y       array of vector floats              
*************************************************************/
EXTERN_API_C( void )
vSswap                          (long                   n,
                                 vector float           x[],
                                 vector float           y[]);



/*************************************************************
 vSyax multiplies a vector X, by a scalar and    
 stores the result in a vector Y.                
    n       number of floats in X (n is a       
                multiple of 4)                      
    Alpha   scalar number is single-precision   
                floating-point                      
    X       array of vector floats              
    Y       array of vector floats              
*************************************************************/
EXTERN_API_C( void )
vSyax                           (long                   n,
                                 float                  alpha,
                                 const vector float     x[],
                                 vector float           y[]);



/*************************************************************
 vSzaxpy multiplies a vector X, by a scalar and  
 adds it to a vector Y and stores the result in  
 vector Z.                                       
    n       number of floats in X (n is a       
                multiple of 4)                      
    Alpha   scalar number is single-precision   
                floating-point                      
    X       array of vector floats              
    Y       array of vector floats              
    Z       array of vector floats, where the   
                is stored                           
*************************************************************/
EXTERN_API_C( void )
vSzaxpy                         (long                   n,
                                 float                  alpha,
                                 const vector float     x[],
                                 const vector float     yY[],
                                 vector float           z[]);




/*
-------------------------------------------------------------------------------------
     Level 2
-------------------------------------------------------------------------------------
*/
/*************************************************************
 vSgemv multiplies an array of vector floats Y by
 a  scalar Beta, and takes the result and adds it
 to the product of a scalar Alpha multiplied by  
 a matrix A multiplied by a vector X. The above  
 result is stored in array Y. Futhermore, the    
 same function also performs the above calculation/
 with the transpose of matrix A, instead of      
 matrix A. In this function argument "forma"     
 distinguishes between the above two cases.      
    forma   indicates the form of matrix A to   
                use in the computation, where:      
                If forma = "N", Matrix A is used    
                If forma = "T", Transpose of Matrix 
                 A is used                          
    m       number of rows in matrix A and      
                depending on value of forma         
                if forma = "N", it is the length of 
                 vector Y                           
                if forma = "T", it is the length of 
                 vector X. m is a multiple of 4     
    n       number of columns in matrix A and   
                depending on value of forma         
                if forma = "N", it is the length of 
                 vector X                           
                if forma = "T", it is the length of 
                 vector Y. m is a multiple of 4     
    Alpha   is a scaling constant               
    A       is an m by n matrix. Its elements   
                are vector floats                   
    X       is an array of vector floats        
    Beta        is a scaling constant               
    Y       is an array of vector floats        
*************************************************************/
EXTERN_API_C( void )
vSgemv                          (char                   forma,
                                 long                   m,
                                 long                   n,
                                 float                  alpha,
                                 const vector float     a[],
                                 const vector float     x[],
                                 float                  beta,
                                 vector float           y[]);




/*************************************************************
 vSgemx adds an array of vector floats Y to the  
 product of an scalar Alpha by a mtrix A         
 multiplied by an array of vector floats X. It   
 then stores the result in the vector Y.         
    m       number of rows in matrix A and      
                the length of vector Y. m is a      
            multiple of 4                       
    n       number of columns in matrix A and   
                the length of vector X. m is a      
            multiple of 4                       
    Alpha   is a scaling constant               
    A       is an m by n matrix. Its elements   
                are vector floats                   
    X       is an array of vector floats        
    Y       is an array of vector floats        
*************************************************************/
EXTERN_API_C( void )
vSgemx                          (long                   m,
                                 long                   n,
                                 float                  alpha,
                                 const vector float     a[],
                                 const vector float     x[],
                                 vector float           y[]);



/*************************************************************
 vSgemtx takes the transpose of a mtrix A and    
 multiplies it by an array X. It then multiplies 
 the result by a scalar Alpha. Finally adds the  
 above result to an array Y and stores the result
 in array Y.                                     
    m       number of rows in matrix A and      
                the length of vector X. m is a      
            multiple of 4                       
    n       number of columns in matrix A and   
                the length of vector Y. m is a      
            multiple of 4                       
    Alpha   is a scaling constant               
    A       is an m by n matrix. Its elements   
                are vector floats                   
    X       is an array of vector floats        
    Y       is an array of vector floats        
*************************************************************/
EXTERN_API_C( void )
vSgemtx                         (long                   m,
                                 long                   n,
                                 float                  alpha,
                                 const vector float     a[],
                                 const vector float     x[],
                                 vector float           y[]);



/*
-------------------------------------------------------------------------------------
     Level 3
-------------------------------------------------------------------------------------
*/


/*************************************************************
 vSgeadd performs matrix addition for general    
 matrices or their transposes.                   
    height  height of the matrix (it is multiple
                of 4)                               
    width   width of the matrix (it is multiple 
                of 4)                               
    A       matrix A, and depending on forma:   
                if forma='N', A is used in  the     
                computation, and A has m rows and   
                n columns                           
                if forma='T', A(T) is used in the   
                computation, and A has n rows and   
                m columns                           
    forma   indicates the form of matrix A to   
                use in the computation, where:      
                if forma='N', A is used in  the     
                computation                         
                if forma='T', A(T) is used in  the  
                computation                         
    B       matrix B, and depending on formb:   
                if formb='N', B is used in  the     
                computation, and B has m rows and   
                n columns                           
                if formb='T', B(T) is used in the   
                computation, and B has n rows and   
                m columns                           
    formb   indicates the form of matrix B to   
                use in the computation, where:      
                if forma='N', B is used in  the     
                computation                         
                if forma='T', B(T) is used in  the  
                computation                         
    C       is an m by n matrix C, containing   
                the reults of the computation       
*************************************************************/
EXTERN_API_C( void )
vSgeadd                         (long                   height,
                                 long                   width,
                                 const vector float     a[],
                                 char                   forma,
                                 const vector float     b[],
                                 char                   formb,
                                 vector float           c[]);



/*************************************************************
 vSgesub performs matrix subtraction for general 
 matrices or their transposes.                   
    height  height of the matrix (it is multiple
                of 4)                               
    width   width of the matrix (it is multiple 
                of 4)                               
    A       matrix A, and depending on forma:   
                if forma='N', A is used in  the     
                computation, and A has m rows and   
                n columns                           
                if forma='T', A(T) is used in the   
                computation, and A has n rows and   
                m columns                           
    forma   indicates the form of matrix A to   
                use in the computation, where:      
                if forma='N', A is used in  the     
                computation                         
                if forma='T', A(T) is used in  the  
                computation                         
    B       matrix B, and depending on formb:   
                if formb='N', B is used in  the     
                computation, and B has m rows and   
                n columns                           
                if formb='T', B(T) is used in the   
                computation, and B has n rows and   
                m columns                           
    formb   indicates the form of matrix B to   
                use in the computation, where:      
                if forma='N', B is used in  the     
                computation                         
                if forma='T', B(T) is used in  the  
                computation                         
    C       is an m by n matrix C, containing   
                the reults of the computation       
*************************************************************/
EXTERN_API_C( void )
vSgesub                         (long                   height,
                                 long                   width,
                                 const vector float     a[],
                                 char                   forma,
                                 const vector float     b[],
                                 char                   formb,
                                 vector float           c[]);



/*************************************************************
 vSgemul performs matrix multiplication for      
 general matrices or their transposes.           
    l       height of the matrix A (it is       
                multiple of 4)                      
    m       width of  matrix A  (it is multiple 
                of 4)                               
    n       width of  matrix B  (it is multiple 
                of 4)                               
    A       matrix A, and depending on forma:   
                if forma='N', A is used in  the     
                computation, and A has l rows and   
                m columns                           
                if forma='T', A(T) is used in the   
                computation, and A has m rows and   
                l columns                           
    forma   indicates the form of matrix A to   
                use in the computation, where:      
                if forma='N', A is used in  the     
                computation                         
                if forma='T', A(T) is used in  the  
                computation                         
    B       matrix B, and depending on formb:   
                if formb='N', B is used in  the     
                computation, and B has m rows and   
                n columns                           
                if formb='T', B(T) is used in the   
                computation, and B has n rows and   
                m columns                           
    formb   indicates the form of matrix B to   
                use in the computation, where:      
                if forma='N', B is used in  the     
                computation                         
                if forma='T', B(T) is used in  the  
                computation                         
    M       is the matrix M, containing the     
                reults of the computation           
*************************************************************/
EXTERN_API_C( void )
vSgemul                         (long                   l,
                                 long                   m,
                                 long                   n,
                                 const vector float     a[],
                                 char                   forma,
                                 const vector float     b[],
                                 char                   formb,
                                 vector float           m[]);



/*************************************************************
 vSgemm performs combined matrix multiplication  
 and addition for general matrices or their transposes.                                     
    l       number of rows in matrix C (it is   
                multiple of 4)                      
    m       has the following meaning:          
                if forma='N', it is the number of   
                columns in matrix A                 
                if forma='T', it is the number of   
                rows in matrix A. In addition       
                if formb='N', it is the number of   
                rows in matrix B                    
                if formb='T', it is the number of   
                columns in matrix B                 
    n       columns in  matrix C                
    A       matrix A, and depending on forma:   
                if forma='N', A is used in  the     
                computation, and A has l rows and   
                m columns                           
                if forma='T', A(T) is used in the   
                computation, and A has m rows and   
                l columns                           
    forma   indicates the form of matrix A to   
                use in the computation, where:      
                if forma='N', A is used in  the     
                computation                         
                if forma='T', A(T) is used in  the  
                computation                         
    B       matrix B, and depending on formb:   
                if formb='N', B is used in  the     
                computation, and B has m rows and   
                n columns                           
                if formb='T', B(T) is used in the   
                computation, and B has n rows and   
                m columns                           
    formb   indicates the form of matrix B to   
                use in the computation, where:      
                if forma='N', B is used in  the     
                computation                         
                if forma='T', B(T) is used in  the  
                computation                         
    alpha   is a scalar                         
    beta        is a scalar                         
    M       is the l by n matrix M              
*************************************************************/
EXTERN_API_C( void )
vSgemm                          (long                   l,
                                 long                   m,
                                 long                   n,
                                 const vector float     a[],
                                 char                   forma,
                                 const vector float     b[],
                                 char                   formb,
                                 vector float           c[],
                                 float                  alpha,
                                 float                  beta,
                                 vector float           m[]);




/*************************************************************
 vSgetmi performs general matrix transpose (in place).                                         
    size        is the number of rows and columns   
                in matrix X                         
*************************************************************/
EXTERN_API_C( void )
vSgetmi                         (long                   size,
                                 vector float           x[]);




/*************************************************************
 vSgetmo performs general matrix transpose (out-of-place).                                      
    height  is the height of the matrix         
    width   is the width of the matrix          
    X       array of vector floats              
    Y       array of vector floats              
*************************************************************/
EXTERN_API_C( void )
vSgetmo                         (long                   height,
                                 long                   width,
                                 const vector float     x[],
                                 vector float           y[]);




/*************************************************************
 vSgevv is a new function. It takes matrix A and 
 multiplies it by matrix B and puts the result in
 matrix M.                                       
    l       is the height of the matrix         
    n       is the width of the matrix          
    A       array of vector floats of at least  
                l *  m in length                                 
    B       array of vector floats of at least  
                m * n in length                                 
    M       array of vector floats, containing  
                the results of multiplication. It   
                is m * n in size                                
*************************************************************/
EXTERN_API_C( void )
vSgevv                          (long                   l,
                                 long                   n,
                                 const vector float     a[],
                                 const vector float     b[],
                                 vector float           m[]);

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

#endif /* __VECTOROPS__ */

