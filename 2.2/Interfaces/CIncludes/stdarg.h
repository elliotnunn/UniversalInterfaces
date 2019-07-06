/*
	StdArg.h -- Variable arguments
	
	Copyright Apple Computer,Inc.	1987, 1990, 1994
	All rights reserved.

*/


#ifndef __STDARG__
#define __STDARG__

/*
 * Get common declarations 
 */

#include <NullDef.h>
#include <SizeTDef.h>
#include <VaListTDef.h>

#if !defined (__SC__) || defined (__CFM68K__)
	/*	most normal compilers are long-word aligned…  */
	#define va_start(ap, parmN) ap = (va_list)((unsigned int)&(parmN) + (((sizeof(parmN)+3)/4)*4))
#else
	/*	…but Symantec C is word aligned.  */
	#define va_start(ap, parmN) ap = (va_list)((char*)&parmN + (((sizeof(parmN)+1)/2)*2))
#endif

#define va_arg(ap, type) ((type *)(ap += sizeof (type)))[-1]
#define va_end(ap)	/* do nothing */


#endif
