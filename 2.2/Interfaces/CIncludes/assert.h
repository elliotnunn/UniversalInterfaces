/************************************************************

	Assert.h
	Diagnostics
	
	Copyright © Apple Computer,Inc.  1987-1990, 1994,1995.
	All Rights Reserved.

************************************************************/

#undef assert

#ifdef NDEBUG

	#define assert(ignore) ((void) 0)

#else

	#if defined (__CFM68K__) && !defined (UsingStaticLibs)
		#pragma import on
	#endif
	
	#ifdef __cplusplus
		extern "C" {
	#endif

	void __assertprint(const char* file, int line, const char* expr);

	#ifdef __cplusplus
		}
	#endif
	
	#define assert(expression) \
		( (expression) ? (void) 0 : (__assertprint(__FILE__, __LINE__, #expression)) )

	#if defined (__CFM68K__) && !defined (UsingStaticLibs)
		#pragma import off
	#endif
			
#endif
