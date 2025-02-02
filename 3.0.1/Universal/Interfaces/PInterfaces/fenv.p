{
 	File:		fenv.p
 
 	Contains:	Floating-Point environment for PowerPC and 68K
 
 	Version:	Technology:	MathLib v2
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1987-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT fenv;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FENV__}
{$SETC __FENV__ := 1}

{$I+}
{$SETC fenvIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
		A collection of functions designed to provide access to the floating
		point environment for numerical programming. It is modeled after
		the floating-point requirements in C9X.
		
		The file <fenv.h> declares many functions in support of numerical
		programming.  It provides a set of environmental controls similar to
		the ones found in <SANE.h>.  Programs that test flags or run under
		non-default modes must do so under the effect of an enabling
		"fenv_access" pragma.
}

{$IFC TARGET_CPU_PPC }
{    The typedef fenv_t is a type for representing the entire floating-point
      environment in a single object.                                         }

TYPE
	fenv_t								= LONGINT;
{    The typedef fexcept_t is a type for representing the floating-point
      exception flag state collectively.                                      }
	fexcept_t							= LONGINT;
{    Definitions of floating-point exception macros                          }

CONST
	FE_INEXACT					= $02000000;
	FE_DIVBYZERO				= $04000000;
	FE_UNDERFLOW				= $08000000;
	FE_OVERFLOW					= $10000000;
	FE_INVALID					= $20000000;

{    Definitions of rounding direction macros                                }
	FE_TONEAREST				= $00000000;
	FE_TOWARDZERO				= $00000001;
	FE_UPWARD					= $00000002;
	FE_DOWNWARD					= $00000003;

{$ENDC}  {TARGET_CPU_PPC}

{$IFC TARGET_CPU_68K }
{$IFC TARGET_RT_MAC_68881 }

TYPE
	fexcept_t							= LONGINT;
	fenv_tPtr = ^fenv_t;
	fenv_t = RECORD
		FPCR:					LONGINT;
		FPSR:					LONGINT;
	END;


CONST
	FE_INEXACT					= $00000008;					{  ((long)(8))    }
	FE_DIVBYZERO				= $00000010;					{  ((long)(16))   }
	FE_UNDERFLOW				= $00000020;					{  ((long)(32))   }
	FE_OVERFLOW					= $00000040;					{  ((long)(64))   }
	FE_INVALID					= $00000080;					{  ((long)(128))  }

{$ELSEC}

TYPE
	fexcept_t							= INTEGER;
	fenv_t								= INTEGER;

CONST
	FE_INVALID					= $0001;						{  ((short)(1))   }
	FE_UNDERFLOW				= $0002;						{  ((short)(2))   }
	FE_OVERFLOW					= $0004;						{  ((short)(4))   }
	FE_DIVBYZERO				= $0008;						{  ((short)(8))   }
	FE_INEXACT					= $0010;						{  ((short)(16))  }

{$ENDC}
	FE_TONEAREST				= $0000;						{  ((short)(0))   }
	FE_UPWARD					= $0001;						{  ((short)(1))   }
	FE_DOWNWARD					= $0002;						{  ((short)(2))   }
	FE_TOWARDZERO				= $0003;						{  ((short)(3))   }

{    Definitions of rounding precision macros  (68K only)                    }
	FE_LDBLPREC					= $0000;						{  ((short)(0))   }
	FE_DBLPREC					= $0001;						{  ((short)(1))   }
	FE_FLTPREC					= $0002;						{  ((short)(2))   }

{$ENDC}  {TARGET_CPU_68K}

{    The bitwise OR of all exception macros                                  }

CONST
	FE_ALL_EXCEPT = ( FE_INEXACT + FE_DIVBYZERO + FE_UNDERFLOW + FE_OVERFLOW + FE_INVALID );

{    Definition of pointer to IEEE default environment object               }
VAR
 {$PUSH}
 {$J+}
 _FE_DFL_ENV: fenv_t;               { default environment object        }
 {$POP}

{******************************************************************************
*     The following functions provide access to the exception flags.  The      *
*     "int" input argument can be constructed by bitwise ORs of the exception  *
*     macros: for example: FE_OVERFLOW | FE_INEXACT.                           *
******************************************************************************}
{******************************************************************************
*     The function "feclearexcept" clears the supported exceptions represented *
*     by its argument.                                                         *
******************************************************************************}
PROCEDURE feclearexcept(excepts: LONGINT); C;


{******************************************************************************
*    The function "fegetexcept" stores a representation of the exception       *
*     flags indicated by the argument "excepts" through the pointer argument   *
*     "flagp".                                                                 *
******************************************************************************}
PROCEDURE fegetexcept(VAR flagp: fexcept_t; excepts: LONGINT); C;


{******************************************************************************
*     The function "feraiseexcept" raises the supported exceptions             *
*     represented by its argument.                                             *
******************************************************************************}
PROCEDURE feraiseexcept(excepts: LONGINT); C;


{******************************************************************************
*     The function "fesetexcept" sets or clears the exception flags indicated  *
*     by the int argument "excepts" according to the representation in the     *
*     object pointed to by the pointer argument "flagp".  The value of         *
*     "*flagp" must have been set by a previous call to "fegetexcept".         *
*     This function does not raise exceptions; it just sets the state of       *
*     the flags.                                                               *
******************************************************************************}
PROCEDURE fesetexcept({CONST}VAR flagp: fexcept_t; excepts: LONGINT); C;


{******************************************************************************
*     The function "fetestexcept" determines which of the specified subset of  *
*     the exception flags are currently set.  The argument "excepts" specifies *
*     the exception flags to be queried as a bitwise OR of the exception       *
*     macros.  This function returns the bitwise OR of the exception macros    *
*     corresponding to the currently set exceptions included in "excepts".     *
******************************************************************************}
FUNCTION fetestexcept(excepts: LONGINT): LONGINT; C;


{******************************************************************************
*     The following functions provide control of rounding direction modes.     *
******************************************************************************}
{******************************************************************************
*     The function "fegetround" returns the value of the rounding direction    *
*     macro which represents the current rounding direction.                   *
******************************************************************************}
FUNCTION fegetround: LONGINT; C;


{******************************************************************************
*     The function "fesetround" establishes the rounding direction represented *
*     by its argument.  It returns nonzero if and only if the argument matches *
*     a rounding direction macro.  If not, the rounding direction is not       *
*     changed.                                                                 *
******************************************************************************}
FUNCTION fesetround(round: LONGINT): LONGINT; C;


{******************************************************************************
*    The following functions manage the floating-point environment, exception  *
*    flags and dynamic modes, as one entity.                                   *
******************************************************************************}
{******************************************************************************
*     The function "fegetenv" stores the current floating-point environment    *
*     in the object pointed to by its pointer argument "envp".                 *
******************************************************************************}
PROCEDURE fegetenv(VAR envp: fenv_t); C;


{******************************************************************************
*     The function "feholdexcept" saves the current environment in the object  *
*     pointed to by its pointer argument "envp", clears the exception flags,   *
*     and clears floating-point exception enables.  This function supersedes   *
*     the SANE function "procentry", but it does not change the current        *
*     rounding direction mode.                                                 *
******************************************************************************}
FUNCTION feholdexcept(VAR envp: fenv_t): LONGINT; C;


{******************************************************************************
*     The function "fesetenv" installs the floating-point environment          *
*     environment represented by the object pointed to by its argument         *
*     "envp".  The value of "*envp" must be set by a call to "fegetenv" or     *
*     "feholdexcept", by an implementation-defined macro of type "fenv_t",     *
*     or by the use of the pointer macro FE_DFL_ENV as the argument.           *
******************************************************************************}
PROCEDURE fesetenv({CONST}VAR envp: fenv_t); C;


{******************************************************************************
*     The function "feupdateenv" saves the current exceptions into its         *
*     automatic storage, installs the environment represented through its      *
*     pointer argument "envp", and then re-raises the saved exceptions.        *
*     This function, which supersedes the SANE function "procexit", can be     *
*     used in conjunction with "feholdexcept" to write routines which hide     *
*     spurious exceptions from their callers.                                  *
******************************************************************************}
PROCEDURE feupdateenv({CONST}VAR envp: fenv_t); C;


{$IFC TARGET_CPU_68K }
{******************************************************************************
*     The following functions provide control of rounding precision.           *
*     Because the PowerPC does not provide this capability, these functions    *  
*     are available only for the 68K Macintosh.  Rounding precision values     *
*     are defined by the rounding precision macros.  These functions are       *
*     equivalent to the SANE functions getprecision and setprecision.          *
******************************************************************************}
FUNCTION fegetprec: LONGINT; C;
FUNCTION fesetprec(precision: LONGINT): LONGINT; C;
{$ENDC}  {TARGET_CPU_68K}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := fenvIncludes}

{$ENDC} {__FENV__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
