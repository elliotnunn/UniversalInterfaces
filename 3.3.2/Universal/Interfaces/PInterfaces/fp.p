{
     File:       fp.p
 
     Contains:   FPCE Floating-Point Definitions and Declarations.
 
     Version:    Technology: MathLib v2
                 Release:    Universal Interfaces 3.3.2
 
     Copyright:  © 1987-2000 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT fp;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FP__}
{$SETC __FP__ := 1}

{$I+}
{$SETC fpIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}

{*******************************************************************************
*                                                                               *
*    A collection of numerical functions designed to facilitate a wide          *
*    range of numerical programming as required by C9X.                         *
*                                                                               *
*    The <fp.h> declares many functions in support of numerical programming.    *
*    It provides a superset of <math.h> and <SANE.h> functions.  Some           *
*    functionality previously found in <SANE.h> and not in the FPCE <fp.h>      *
*    can be found in this <fp.h> under the heading "__NOEXTENSIONS__".          *
*                                                                               *
*    All of these functions are IEEE 754 aware and treat exceptions, NaNs,      *
*    positive and negative zero and infinity consistent with the floating-      *
*    point standard.                                                            *
*                                                                               *
*******************************************************************************}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{*******************************************************************************
*                                                                               *
*                            Efficient types                                    *
*                                                                               *
*    float_t         Most efficient type at least as wide as float              *
*    double_t        Most efficient type at least as wide as double             *
*                                                                               *
*      CPU            float_t(bits)                double_t(bits)               *
*    --------        -----------------            -----------------             *
*    PowerPC          float(32)                    double(64)                   *
*    68K              long double(80/96)           long double(80/96)           *
*    x86              long double(80)              long double(80)              *
*                                                                               *
*******************************************************************************}
{$IFC TARGET_CPU_PPC }

TYPE
	float_t								= Single;
	double_t							= Double;
{$ELSEC}
  {$IFC TARGET_CPU_68K }
TYPE
    float_t                             = extended;
    double_t                            = extended;
  {$ELSEC}
    {$IFC TARGET_CPU_X86 }
    {$IFC NeXT }

TYPE
	float_t								= Double;
	double_t							= Double;
    {$ELSEC}

TYPE
	float_t								= LongDouble;
	double_t							= LongDouble;
    {$ENDC}  {NeXT}
    {$ELSEC}
      {$IFC TARGET_CPU_MIPS }

TYPE
	float_t								= Double;
	double_t							= Double;
      {$ELSEC}
        {$IFC TARGET_CPU_ALPHA }

TYPE
	float_t								= Double;
	double_t							= Double;
        {$ELSEC}
          {$IFC TARGET_CPU_SPARC }

TYPE
	float_t								= Double;
	double_t							= Double;
          {$ELSEC}
{ Unsupported CPU }
          {$ENDC}
        {$ENDC}
      {$ENDC}
    {$ENDC}
  {$ENDC}
{$ENDC}

{*******************************************************************************
*                                                                               *
*                              Define some constants.                           *
*                                                                               *
*    HUGE_VAL            IEEE 754 value of infinity.                            *
*    INFINITY            IEEE 754 value of infinity.                            *
*    NAN                 A generic NaN (Not A Number).                          *
*    DECIMAL_DIG         Satisfies the constraint that the conversion from      *
*                        double to decimal and back is the identity function.   *
*                                                                               *
*******************************************************************************}
CONST
{$IFC TARGET_CPU_PPC }
    DECIMAL_DIG                         = 17; 
{$ELSEC}
    DECIMAL_DIG                         = 21;
{$ENDC}
{$IFC TARGET_OS_MAC }
{*******************************************************************************
*                                                                               *
*                            Trigonometric functions                            *
*                                                                               *
*   acos        result is in [0,pi].                                            *
*   asin        result is in [-pi/2,pi/2].                                      *
*   atan        result is in [-pi/2,pi/2].                                      *
*   atan2       Computes the arc tangent of y/x in [-pi,pi] using the sign of   *
*               both arguments to determine the quadrant of the computed value. *
*                                                                               *
*******************************************************************************}
FUNCTION cos(x: double_t): double_t; C;
FUNCTION sin(x: double_t): double_t; C;
FUNCTION tan(x: double_t): double_t; C;
FUNCTION acos(x: double_t): double_t; C;
FUNCTION asin(x: double_t): double_t; C;
FUNCTION atan(x: double_t): double_t; C;
FUNCTION atan2(y: double_t; x: double_t): double_t; C;


{*******************************************************************************
*                                                                               *
*                              Hyperbolic functions                             *
*                                                                               *
*******************************************************************************}
FUNCTION cosh(x: double_t): double_t; C;
FUNCTION sinh(x: double_t): double_t; C;
FUNCTION tanh(x: double_t): double_t; C;
FUNCTION acosh(x: double_t): double_t; C;
FUNCTION asinh(x: double_t): double_t; C;
FUNCTION atanh(x: double_t): double_t; C;


{*******************************************************************************
*                                                                               *
*                              Exponential functions                            *
*                                                                               *
*   expm1       expm1(x) = exp(x) - 1.  But, for small enough arguments,        *
*               expm1(x) is expected to be more accurate than exp(x) - 1.       *
*   frexp       Breaks a floating-point number into a normalized fraction       *
*               and an integral power of 2.  It stores the integer in the       *
*               object pointed by *exponent.                                    *
*   ldexp       Multiplies a floating-point number by an integer power of 2.    *
*   log1p       log1p = log(1 + x). But, for small enough arguments,            *
*               log1p is expected to be more accurate than log(1 + x).          *
*   logb        Extracts the exponent of its argument, as a signed integral     *
*               value. A subnormal argument is treated as though it were first  *
*               normalized. Thus:                                               *
*                                  1   <=   x * 2^(-logb(x))   <   2            *
*   modf        Returns fractional part of x as function result and returns     *
*               integral part of x via iptr. Note C9X uses double not double_t. *
*   scalb       Computes x * 2^n efficently.  This is not normally done by      *
*               computing 2^n explicitly.                                       *
*                                                                               *
*******************************************************************************}
FUNCTION exp(x: double_t): double_t; C;
FUNCTION expm1(x: double_t): double_t; C;
FUNCTION exp2(x: double_t): double_t; C;
FUNCTION frexp(x: double_t; VAR exponent: LONGINT): double_t; C;
FUNCTION ldexp(x: double_t; n: LONGINT): double_t; C;
FUNCTION log(x: double_t): double_t; C;
FUNCTION log2(x: double_t): double_t; C;
FUNCTION log1p(x: double_t): double_t; C;
FUNCTION log10(x: double_t): double_t; C;
FUNCTION logb(x: double_t): double_t; C;
FUNCTION modf(x: double_t; VAR iptr: double_t): double_t; C;
FUNCTION modff(x: Single; VAR iptrf: Single): Single; C;

FUNCTION scalb(x: double_t; n: LONGINT): double_t; C;
{*******************************************************************************
*                                                                               *
*                     Power and absolute value functions                        *
*                                                                               *
*   hypot       Computes the square root of the sum of the squares of its       *
*               arguments, without undue overflow or underflow.                 *
*   pow         Returns x raised to the power of y.  Result is more accurate    *
*               than using exp(log(x)*y).                                       *
*                                                                               *
*******************************************************************************}
FUNCTION fabs(x: double_t): double_t; C;
FUNCTION hypot(x: double_t; y: double_t): double_t; C;
FUNCTION pow(x: double_t; y: double_t): double_t; C;
FUNCTION sqrt(x: double_t): double_t; C;


{*******************************************************************************
*                                                                               *
*                        Gamma and Error functions                              *
*                                                                               *
*   erf         The error function.                                             *
*   erfc        Complementary error function.                                   *
*   gamma       The gamma function.                                             *
*   lgamma      Computes the base-e logarithm of the absolute value of          *
*               gamma of its argument x, for x > 0.                             *
*                                                                               *
*******************************************************************************}
FUNCTION erf(x: double_t): double_t; C;
FUNCTION erfc(x: double_t): double_t; C;
FUNCTION gamma(x: double_t): double_t; C;
FUNCTION lgamma(x: double_t): double_t; C;


{*******************************************************************************
*                                                                               *
*                        Nearest integer functions                              *
*                                                                               *
*   rint        Rounds its argument to an integral value in floating point      *
*               format, honoring the current rounding direction.                *
*                                                                               *
*   nearbyint   Differs from rint only in that it does not raise the inexact    *
*               exception. It is the nearbyint function recommended by the      *
*               IEEE floating-point standard 854.                               *
*                                                                               *
*   rinttol     Rounds its argument to the nearest long int using the current   *
*               rounding direction.  NOTE: if the rounded value is outside      *
*               the range of long int, then the result is undefined.            *
*                                                                               *
*   round       Rounds the argument to the nearest integral value in floating   *
*               point format similar to the Fortran "anint" function. That is:  *
*               add half to the magnitude and chop.                             *
*                                                                               *
*   roundtol    Similar to the Fortran function nint or to the Pascal round.    *
*               NOTE: if the rounded value is outside the range of long int,    *
*               then the result is undefined.                                   *
*                                                                               *
*   trunc       Computes the integral value, in floating format, nearest to     *
*               but no larger in magnitude than its argument.   NOTE: on 68K    *
*               compilers when using -elems881, trunc must return an int        *
*                                                                               *
*******************************************************************************}
FUNCTION ceil(x: double_t): double_t; C;
FUNCTION floor(x: double_t): double_t; C;
FUNCTION rint(x: double_t): double_t; C;
FUNCTION nearbyint(x: double_t): double_t; C;
FUNCTION rinttol(x: double_t): LONGINT; C;
FUNCTION round(x: double_t): double_t; C;
FUNCTION roundtol(round: double_t): LONGINT; C;
{$IFC TARGET_RT_MAC_68881 }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION trunc(x: double_t): LONGINT; C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ELSEC}
FUNCTION trunc(x: double_t): double_t; C;
{$ENDC}  {TARGET_RT_MAC_68881}

{*******************************************************************************
*                                                                               *
*                            Remainder functions                                *
*                                                                               *
*   remainder       IEEE 754 floating point standard for remainder.             *
*   remquo          SANE remainder.  It stores into 'quotient' the 7 low-order  *
*                   bits of the integer quotient x/y, such that:                *
*                       -127 <= quotient <= 127.                                *
*                                                                               *
*******************************************************************************}
FUNCTION fmod(x: double_t; y: double_t): double_t; C;
FUNCTION remainder(x: double_t; y: double_t): double_t; C;
FUNCTION remquo(x: double_t; y: double_t; VAR quo: LONGINT): double_t; C;


{*******************************************************************************
*                                                                               *
*                             Auxiliary functions                               *
*                                                                               *
*   copysign        Produces a value with the magnitude of its first argument   *
*                   and sign of its second argument.  NOTE: the order of the    *
*                   arguments matches the recommendation of the IEEE 754        *
*                   floating point standard,  which is opposite from the SANE   *
*                   copysign function.                                          *
*                                                                               *
*   nan             The call 'nan("n-char-sequence")' returns a quiet NaN       *
*                   with content indicated through tagp in the selected         *
*                   data type format.                                           *
*                                                                               *
*   nextafter       Computes the next representable value after 'x' in the      *
*                   direction of 'y'.  if x == y, then y is returned.           *
*                                                                               *
*******************************************************************************}
FUNCTION copysign(x: double_t; y: double_t): double_t; C;
FUNCTION nan(tagp: ConstCStringPtr): Double; C;
FUNCTION nanf(tagp: ConstCStringPtr): Single; C;
FUNCTION nextafterd(x: Double; y: Double): Double; C;
FUNCTION nextafterf(x: Single; y: Single): Single; C;


{*******************************************************************************
*                                                                               *
*                              Inquiry macros                                   *
*                                                                               *
*   fpclassify      Returns one of the FP_≈ values.                             *
*   isnormal        Non-zero if and only if the argument x is normalized.       *
*   isfinite        Non-zero if and only if the argument x is finite.           *
*   isnan           Non-zero if and only if the argument x is a NaN.            *
*   signbit         Non-zero if and only if the sign of the argument x is       *
*                   negative.  This includes, NaNs, infinities and zeros.       *
*                                                                               *
*******************************************************************************}

CONST
	FP_SNAN						= 0;							{       signaling NaN                          }
	FP_QNAN						= 1;							{       quiet NaN                              }
	FP_INFINITE					= 2;							{       + or - infinity                        }
	FP_ZERO						= 3;							{       + or - zero                            }
	FP_NORMAL					= 4;							{       all normal numbers                     }
	FP_SUBNORMAL				= 5;							{       denormal numbers                       }





FUNCTION __fpclassifyd(x: Double): LONGINT; C;
FUNCTION __fpclassifyf(x: Single): LONGINT; C;
FUNCTION __isnormald(x: Double): LONGINT; C;
FUNCTION __isnormalf(x: Single): LONGINT; C;
FUNCTION __isfinited(x: Double): LONGINT; C;
FUNCTION __isfinitef(x: Single): LONGINT; C;
FUNCTION __isnand(x: Double): LONGINT; C;
FUNCTION __isnanf(x: Single): LONGINT; C;
FUNCTION __signbitd(x: Double): LONGINT; C;
FUNCTION __signbitf(x: Single): LONGINT; C;
FUNCTION __inf: double_t; C;


{*******************************************************************************
*                                                                               *
*                      Max, Min and Positive Difference                         *
*                                                                               *
*   fdim        Determines the 'positive difference' between its arguments:     *
*               ( x - y, if x > y ), ( +0, if x <= y ).  If one argument is     *
*               NaN, then fdim returns that NaN.  if both arguments are NaNs,   *
*               then fdim returns the first argument.                           *
*                                                                               *
*   fmax        Returns the maximum of the two arguments.  Corresponds to the   *
*               max function in FORTRAN.  NaN arguments are treated as missing  *
*               data.  If one argument is NaN and the other is a number, then   *
*               the number is returned.  If both are NaNs then the first        *
*               argument is returned.                                           *
*                                                                               *
*   fmin        Returns the minimum of the two arguments.  Corresponds to the   *
*               min function in FORTRAN.  NaN arguments are treated as missing  *
*               data.  If one argument is NaN and the other is a number, then   *
*               the number is returned.  If both are NaNs then the first        *
*               argument is returned.                                           *
*                                                                               *
*******************************************************************************}
FUNCTION fdim(x: double_t; y: double_t): double_t; C;
FUNCTION fmax(x: double_t; y: double_t): double_t; C;
FUNCTION fmin(x: double_t; y: double_t): double_t; C;

{******************************************************************************
*                                Constants                                     *
******************************************************************************}
{$IFC NOT UNDEFINED MWERKS}
    {$IFC MWERKS > $1500}
        CONST pi : double_t = 3.1415926535;
    {$ENDC}
{$ENDC}
{*******************************************************************************
*                                                                               *
*                              Non NCEG extensions                              *
*                                                                               *
*******************************************************************************}
{$IFC UNDEFINED __NOEXTENSIONS__ }
{*******************************************************************************
*                                                                               *
*                              Financial functions                              *
*                                                                               *
*   compound        Computes the compound interest factor "(1 + rate)^periods"  *
*                   more accurately than the straightforward computation with   *
*                   the Power function.  This is SANE's compound function.      *
*                                                                               *
*   annuity         Computes the present value factor for an annuity            *
*                   "(1 - (1 + rate)^(-periods)) /rate" more accurately than    *
*                   the straightforward computation with the Power function.    *
*                   This is SANE's annuity function.                            *
*                                                                               *
*******************************************************************************}
FUNCTION compound(rate: double_t; periods: double_t): double_t; C;
FUNCTION annuity(rate: double_t; periods: double_t): double_t; C;


{*******************************************************************************
*                                                                               *
*                              Random function                                  *
*                                                                               *
*   randomx         A pseudorandom number generator.  It uses the iteration:    *
*                               (7^5*x)mod(2^31-1)                              *
*                                                                               *
*******************************************************************************}
FUNCTION randomx(VAR x: double_t): double_t; C;


{******************************************************************************
*                              Relational operator                             *
******************************************************************************}
{      relational operator      }

TYPE
	relop								= INTEGER;

CONST
	GREATERTHAN					= 0;
	LESSTHAN					= 1;
	EQUALTO						= 2;
	UNORDERED					= 3;

FUNCTION relation(x: double_t; y: double_t): relop; C;


{*******************************************************************************
*                                                                               *
*                         Binary to decimal conversions                         *
*                                                                               *
*   SIGDIGLEN   Significant decimal digits.                                     *
*                                                                               *
*   decimal     A record which provides an intermediate unpacked form for       *
*               programmers who wish to do their own parsing of numeric input   *
*               or formatting of numeric output.                                *
*                                                                               *
*   decform     Controls each conversion to a decimal string.  The style field  *
*               is either FLOATDECIMAL or FIXEDDECIMAL. If FLOATDECIMAL, the    *
*               value of the field digits is the number of significant digits.  *
*               If FIXEDDECIMAL value of the field digits is the number of      *
*               digits to the right of the decimal point.                       *
*                                                                               *
*   num2dec     Converts a double_t to a decimal record using a decform.        *
*   dec2num     Converts a decimal record d to a double_t value.                *
*   dec2str     Converts a decform and decimal to a string using a decform.     *
*   str2dec     Converts a string to a decimal struct.                          *
*   dec2d       Similar to dec2num except a double is returned (68k only).      *
*   dec2f       Similar to dec2num except a float is returned.                  *
*   dec2s       Similar to dec2num except a short is returned.                  *
*   dec2l       Similar to dec2num except a long is returned.                   *
*                                                                               *
*******************************************************************************}
CONST
{$IFC TARGET_CPU_PPC }
    SIGDIGLEN                   = 36;
{$ELSEC}
    {$IFC TARGET_CPU_68K }
        SIGDIGLEN               = 20;
    {$ELSEC}
        {$IFC TARGET_CPU_X86 }
            SIGDIGLEN           = 20;
        {$ENDC}
    {$ENDC}
{$ENDC}
    DECSTROUTLEN                = 80;
TYPE
    DecimalKind = (FLOATDECIMAL, FIXEDDECIMAL);


    decimal = RECORD
        sgn:    0..1;           { sign 0 for +, 1 for -  }
        exp:    INTEGER;
        sig:    STRING[SIGDIGLEN];
    END;

    decform = RECORD
        style:  DecimalKind;
        digits: INTEGER;
    END;

PROCEDURE num2dec({CONST}VAR f: decform; x: double_t; VAR d: decimal); C;
FUNCTION dec2num({CONST}VAR d: decimal): double_t; C;
PROCEDURE dec2str({CONST}VAR f: decform; {CONST}VAR d: decimal; s: CStringPtr); C;
PROCEDURE str2dec(s: ConstCStringPtr; VAR ix: INTEGER; VAR d: decimal; VAR vp: INTEGER); C;
{$IFC TARGET_CPU_68K }
{$IFC CALL_NOT_IN_CARBON }
FUNCTION dec2d({CONST}VAR d: decimal): Double; C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_CPU_68K}
FUNCTION dec2f({CONST}VAR d: decimal): Single; C;
FUNCTION dec2s({CONST}VAR d: decimal): INTEGER; C;
FUNCTION dec2l({CONST}VAR d: decimal): LONGINT; C;



{*******************************************************************************
*                                                                               *
*                         68k-only Transfer Function Prototypes                 *
*                                                                               *
*******************************************************************************}
{$IFC TARGET_CPU_68K }
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE x96tox80({CONST}VAR x: extended96; VAR x80: extended80); C;
PROCEDURE x80tox96({CONST}VAR x80: extended80; VAR x: extended96); C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_CPU_68K}
{$ENDC}
{*******************************************************************************
*                                                                               *
*                         PowerPC-only Function Prototypes                      *
*                                                                               *
*******************************************************************************}

{$IFC TARGET_CPU_PPC }
FUNCTION cosl(x: LongDouble): LongDouble; C;
FUNCTION sinl(x: LongDouble): LongDouble; C;
FUNCTION tanl(x: LongDouble): LongDouble; C;
FUNCTION acosl(x: LongDouble): LongDouble; C;
FUNCTION asinl(x: LongDouble): LongDouble; C;
FUNCTION atanl(x: LongDouble): LongDouble; C;
FUNCTION atan2l(y: LongDouble; x: LongDouble): LongDouble; C;
FUNCTION coshl(x: LongDouble): LongDouble; C;
FUNCTION sinhl(x: LongDouble): LongDouble; C;
FUNCTION tanhl(x: LongDouble): LongDouble; C;
FUNCTION acoshl(x: LongDouble): LongDouble; C;
FUNCTION asinhl(x: LongDouble): LongDouble; C;
FUNCTION atanhl(x: LongDouble): LongDouble; C;
FUNCTION expl(x: LongDouble): LongDouble; C;
FUNCTION expm1l(x: LongDouble): LongDouble; C;
FUNCTION exp2l(x: LongDouble): LongDouble; C;
FUNCTION frexpl(x: LongDouble; VAR exponent: LONGINT): LongDouble; C;
FUNCTION ldexpl(x: LongDouble; n: LONGINT): LongDouble; C;
FUNCTION logl(x: LongDouble): LongDouble; C;
FUNCTION log1pl(x: LongDouble): LongDouble; C;
FUNCTION log10l(x: LongDouble): LongDouble; C;
FUNCTION log2l(x: LongDouble): LongDouble; C;
FUNCTION logbl(x: LongDouble): LongDouble; C;
FUNCTION scalbl(x: LongDouble; n: LONGINT): LongDouble; C;
FUNCTION fabsl(x: LongDouble): LongDouble; C;
FUNCTION hypotl(x: LongDouble; y: LongDouble): LongDouble; C;
FUNCTION powl(x: LongDouble; y: LongDouble): LongDouble; C;
FUNCTION sqrtl(x: LongDouble): LongDouble; C;
FUNCTION erfl(x: LongDouble): LongDouble; C;
FUNCTION erfcl(x: LongDouble): LongDouble; C;
FUNCTION gammal(x: LongDouble): LongDouble; C;
FUNCTION lgammal(x: LongDouble): LongDouble; C;
FUNCTION ceill(x: LongDouble): LongDouble; C;
FUNCTION floorl(x: LongDouble): LongDouble; C;
FUNCTION rintl(x: LongDouble): LongDouble; C;
FUNCTION nearbyintl(x: LongDouble): LongDouble; C;
FUNCTION rinttoll(x: LongDouble): LONGINT; C;
FUNCTION roundl(x: LongDouble): LongDouble; C;
FUNCTION roundtoll(round: LongDouble): LONGINT; C;
FUNCTION truncl(x: LongDouble): LongDouble; C;
FUNCTION remainderl(x: LongDouble; y: LongDouble): LongDouble; C;
FUNCTION remquol(x: LongDouble; y: LongDouble; VAR quo: LONGINT): LongDouble; C;
FUNCTION copysignl(x: LongDouble; y: LongDouble): LongDouble; C;
FUNCTION fdiml(x: LongDouble; y: LongDouble): LongDouble; C;
FUNCTION fmaxl(x: LongDouble; y: LongDouble): LongDouble; C;
FUNCTION fminl(x: LongDouble; y: LongDouble): LongDouble; C;
{$IFC UNDEFINED __NOEXTENSIONS__ }
FUNCTION relationl(x: LongDouble; y: LongDouble): relop; C;
PROCEDURE num2decl({CONST}VAR f: decform; x: LongDouble; VAR d: decimal); C;
FUNCTION dec2numl({CONST}VAR d: decimal): LongDouble; C;
PROCEDURE x80told({CONST}VAR x80: extended80; VAR x: LongDouble); C;
PROCEDURE ldtox80({CONST}VAR x: LongDouble; VAR x80: extended80); C;
{    
            MathLib v2 has two new transfer functions: x80tod and dtox80.  They can 
            be used to directly transform 68k 80-bit extended data types to double
            and back for PowerPC based machines without using the functions
            x80told or ldtox80.  Double rounding may occur. 
        }
FUNCTION x80tod({CONST}VAR x80: extended80): Double; C;
PROCEDURE dtox80({CONST}VAR x: Double; VAR x80: extended80); C;
{$ENDC}
{$ENDC}  {TARGET_CPU_PPC}
{$IFC TARGET_CPU_X86 }
{$IFC UNDEFINED __NOEXTENSIONS__ }
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE x80told({CONST}VAR x80: extended80; VAR x: LongDouble); C;
PROCEDURE ldtox80({CONST}VAR x: LongDouble; VAR x80: extended80); C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}
{$ENDC}  {TARGET_CPU_X86}
{$ELSEC}
{
    Non-Mac platforms may have long doubles.
}
{$IFC CALL_NOT_IN_CARBON }
PROCEDURE x80told({CONST}VAR x80: extended80; VAR x: LongDouble); C;
PROCEDURE ldtox80({CONST}VAR x: LongDouble; VAR x80: extended80); C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_MAC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := fpIncludes}

{$ENDC} {__FP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
