/*
	StdDef.h -- Common definitions
	
	Copyright Apple Computer,Inc.	1987-1990, 1994
	All rights reserved.

	wchar_t - this type is defined only by stddef and stdlib.
*/

#ifndef __WCHARTDEF__
#define __WCHARTDEF__

	#ifdef	__xlC
		typedef unsigned short wchar_t;
	#else	/* __xlC */
		typedef short wchar_t;
	#endif	/* __xlC */

#endif	/* __WCHARTDEF__ */
