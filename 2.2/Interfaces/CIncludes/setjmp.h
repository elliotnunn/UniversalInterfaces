/*
   SetJmp.h

   Copyright Apple Computer, Inc.	1986-1990, 1993-1995
   All rights reserved.
 */

/* Conditional Macros:
 *	UsingStaticLibs	- for CFM-68K:  Insures that #pragma import is never used.
 *	<none>			- for CFM-68K:	Insures that all functions and data items are
 *									marked as library imports
 */

#ifndef __SETJMP__
#define __SETJMP__

#ifdef __CFM68K__
	/* We MUST use the new, larger jmp_buf for CFM-68K */
	#undef OLD_JMPBUF
#endif

#if defined (powerc)
	typedef long *jmp_buf[64];      /*  PowerPC  */
#elif defined (OLD_JMPBUF)
	typedef long *jmp_buf[12];		/*	old 68K:  D2-D7,PC,A2-A4,A6,SP  */
#else
	typedef long *jmp_buf[16];		/*	new 68K:  D2-D7,PC,A2-A4,A6,SP,FLAGS,A5,RESVD,RESVD  */
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if defined (__CFM68K__) && !defined (UsingStaticLibs)
	#pragma import on
#endif

int __setjmp(jmp_buf env);
#define setjmp(env) __setjmp(env)
void longjmp(jmp_buf, int);

#if defined (__CFM68K__) && !defined (UsingStaticLibs)
	#pragma import off
#endif

#ifdef __cplusplus
}
#endif

#endif
