/*
 	File:		LocationManager.k.h
 
 	Contains:	Interfaces for writing a Location Manager component
 
 	Version:	Technology:	System 7.6
 				Release:	Universal Interfaces 3.0.1
 
 	Copyright:	© 1995-1997 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
*/
#ifndef __LOCATIONMANAGER_K__
#define __LOCATIONMANAGER_K__

#include <LocationManager.h>

#if OLDROUTINENAMES
#endif
/*
	Example usage:

		#define ALM_BASENAME()	Fred
		#define ALM_GLOBALS()	FredGlobalsHandle
		#include <LocationManager.k.h>

	To specify that your component implementation does not use globals, do not #define ALM_GLOBALS
*/
#ifdef ALM_BASENAME
	#ifndef ALM_GLOBALS
		#define ALM_GLOBALS() 
		#define ADD_ALM_COMMA 
	#else
		#define ADD_ALM_COMMA ,
	#endif
	#define ALM_GLUE(a,b) a##b
	#define ALM_STRCAT(a,b) ALM_GLUE(a,b)
	#define ADD_ALM_BASENAME(name) ALM_STRCAT(ALM_BASENAME(),name)

	EXTERN_API( ComponentResult  ) ADD_ALM_BASENAME(GetCurrent) (ALM_GLOBALS() ADD_ALM_COMMA Handle  setting);

	EXTERN_API( ComponentResult  ) ADD_ALM_BASENAME(SetCurrent) (ALM_GLOBALS() ADD_ALM_COMMA Handle  setting, ALMRebootFlags * flags);

	EXTERN_API( ComponentResult  ) ADD_ALM_BASENAME(CompareSetting) (ALM_GLOBALS() ADD_ALM_COMMA Handle  setting1, Handle  setting2, Boolean * equal);

	EXTERN_API( ComponentResult  ) ADD_ALM_BASENAME(DescribeSetting) (ALM_GLOBALS() ADD_ALM_COMMA Handle  setting, CharsHandle  text);

	EXTERN_API( ComponentResult  ) ADD_ALM_BASENAME(DescribeError) (ALM_GLOBALS() ADD_ALM_COMMA OSErr  lastErr, Str255  errStr);

	EXTERN_API( ComponentResult  ) ADD_ALM_BASENAME(EditSetting) (ALM_GLOBALS() ADD_ALM_COMMA Handle  setting);

	EXTERN_API( ComponentResult  ) ADD_ALM_BASENAME(ImportExport) (ALM_GLOBALS() ADD_ALM_COMMA Boolean  import, Handle  setting, SInt16  resRefNum);

	EXTERN_API( ComponentResult  ) ADD_ALM_BASENAME(GetScriptInfo) (ALM_GLOBALS() ADD_ALM_COMMA ALMScriptManagerInfoPtr  info);

	EXTERN_API( ComponentResult  ) ADD_ALM_BASENAME(GetInfo) (ALM_GLOBALS() ADD_ALM_COMMA CharsHandle * text, STHandle * style, ModalFilterUPP  filter);

#if OLDROUTINENAMES
	EXTERN_API( ComponentResult  ) ADD_ALM_BASENAME(DescribeSettings) (ALM_GLOBALS() ADD_ALM_COMMA Handle  setting, CharsHandle  text);

#endif

	/* MixedMode ProcInfo constants for component calls */
	enum {
		uppALMGetCurrentProcInfo = 0x000003F0,
		uppALMSetCurrentProcInfo = 0x00000FF0,
		uppALMCompareSettingProcInfo = 0x00003FF0,
		uppALMDescribeSettingProcInfo = 0x00000FF0,
		uppALMDescribeErrorProcInfo = 0x00000EF0,
		uppALMEditSettingProcInfo = 0x000003F0,
		uppALMImportExportProcInfo = 0x00002DF0,
		uppALMGetScriptInfoProcInfo = 0x000003F0,
		uppALMGetInfoProcInfo = 0x00003FF0,
		uppALMDescribeSettingsProcInfo = 0x00000FF0
	};

#endif	/* ALM_BASENAME */


/* selectors for component calls */
enum {
	kALMGetCurrentSelect = 0x0000,
	kALMSetCurrentSelect = 0x0001,
	kALMCompareSettingSelect = 0x0002,
	kALMDescribeSettingSelect = 0x0004,
	kALMDescribeErrorSelect = 0x0005,
	kALMEditSettingSelect = 0x0003,
	kALMImportExportSelect = 0x0006,
	kALMGetScriptInfoSelect = 0x0007,
	kALMGetInfoSelect = 0x0008,
	kALMDescribeSettingsSelect = 0x0004
};

#endif /* __LOCATIONMANAGER_K__ */

