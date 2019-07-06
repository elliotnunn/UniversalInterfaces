/*
 	File:		AVComponents.k.h
 
 	Contains:	Standard includes for standard AV panels
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.2
 
 	Copyright:	© 1989-1998 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
*/
#ifndef __AVCOMPONENTS_K__
#define __AVCOMPONENTS_K__

#include <AVComponents.h>

/*
	Example usage:

		#define AVENGINECOMPONENT_BASENAME()	Fred
		#define AVENGINECOMPONENT_GLOBALS()	FredGlobalsHandle
		#include <AVComponents.k.h>

	To specify that your component implementation does not use globals, do not #define AVENGINECOMPONENT_GLOBALS
*/
#ifdef AVENGINECOMPONENT_BASENAME
	#ifndef AVENGINECOMPONENT_GLOBALS
		#define AVENGINECOMPONENT_GLOBALS() 
		#define ADD_AVENGINECOMPONENT_COMMA 
	#else
		#define ADD_AVENGINECOMPONENT_COMMA ,
	#endif
	#define AVENGINECOMPONENT_GLUE(a,b) a##b
	#define AVENGINECOMPONENT_STRCAT(a,b) AVENGINECOMPONENT_GLUE(a,b)
	#define ADD_AVENGINECOMPONENT_BASENAME(name) AVENGINECOMPONENT_STRCAT(AVENGINECOMPONENT_BASENAME(),name)

	EXTERN_API( ComponentResult  ) ADD_AVENGINECOMPONENT_BASENAME(GetFidelity) (AVENGINECOMPONENT_GLOBALS() ADD_AVENGINECOMPONENT_COMMA DisplayIDType  displayID, DMFidelityType * engineFidelity);

	EXTERN_API( ComponentResult  ) ADD_AVENGINECOMPONENT_BASENAME(TargetDevice) (AVENGINECOMPONENT_GLOBALS() ADD_AVENGINECOMPONENT_COMMA DisplayIDType  displayID);

#endif	/* AVENGINECOMPONENT_BASENAME */

/*
	Example usage:

		#define AVPANEL_BASENAME()	Fred
		#define AVPANEL_GLOBALS()	FredGlobalsHandle
		#include <AVComponents.k.h>

	To specify that your component implementation does not use globals, do not #define AVPANEL_GLOBALS
*/
#ifdef AVPANEL_BASENAME
	#ifndef AVPANEL_GLOBALS
		#define AVPANEL_GLOBALS() 
		#define ADD_AVPANEL_COMMA 
	#else
		#define ADD_AVPANEL_COMMA ,
	#endif
	#define AVPANEL_GLUE(a,b) a##b
	#define AVPANEL_STRCAT(a,b) AVPANEL_GLUE(a,b)
	#define ADD_AVPANEL_BASENAME(name) AVPANEL_STRCAT(AVPANEL_BASENAME(),name)

	EXTERN_API( ComponentResult  ) ADD_AVPANEL_BASENAME(FakeRegister) (AVPANEL_GLOBALS());

	EXTERN_API( ComponentResult  ) ADD_AVPANEL_BASENAME(SetCustomData) (AVPANEL_GLOBALS() ADD_AVPANEL_COMMA long  theCustomData);

	EXTERN_API( ComponentResult  ) ADD_AVPANEL_BASENAME(GetDitl) (AVPANEL_GLOBALS() ADD_AVPANEL_COMMA Handle * ditl);

	EXTERN_API( ComponentResult  ) ADD_AVPANEL_BASENAME(GetTitle) (AVPANEL_GLOBALS() ADD_AVPANEL_COMMA StringPtr  title);

	EXTERN_API( ComponentResult  ) ADD_AVPANEL_BASENAME(Install) (AVPANEL_GLOBALS() ADD_AVPANEL_COMMA DialogPtr  dialog, long  itemOffset);

	EXTERN_API( ComponentResult  ) ADD_AVPANEL_BASENAME(Event) (AVPANEL_GLOBALS() ADD_AVPANEL_COMMA DialogPtr  dialog, long  itemOffset, EventRecord * event, short * itemHit, Boolean * handled);

	EXTERN_API( ComponentResult  ) ADD_AVPANEL_BASENAME(Item) (AVPANEL_GLOBALS() ADD_AVPANEL_COMMA DialogPtr  dialog, long  itemOffset, short  itemNum);

	EXTERN_API( ComponentResult  ) ADD_AVPANEL_BASENAME(Remove) (AVPANEL_GLOBALS() ADD_AVPANEL_COMMA DialogPtr  dialog, long  itemOffset);

	EXTERN_API( ComponentResult  ) ADD_AVPANEL_BASENAME(ValidateInput) (AVPANEL_GLOBALS() ADD_AVPANEL_COMMA Boolean * ok);

	EXTERN_API( ComponentResult  ) ADD_AVPANEL_BASENAME(GetSettingsIdentifiers) (AVPANEL_GLOBALS() ADD_AVPANEL_COMMA short * theID, OSType * theType);

	EXTERN_API( ComponentResult  ) ADD_AVPANEL_BASENAME(GetSettings) (AVPANEL_GLOBALS() ADD_AVPANEL_COMMA Handle * userDataHand, long  flags, DialogPtr  theDialog, long  itemsOffset);

	EXTERN_API( ComponentResult  ) ADD_AVPANEL_BASENAME(SetSettings) (AVPANEL_GLOBALS() ADD_AVPANEL_COMMA Handle  userDataHand, long  flags, DialogPtr  theDialog, long  itemsOffset);

	EXTERN_API( ComponentResult  ) ADD_AVPANEL_BASENAME(GetFidelity) (AVPANEL_GLOBALS() ADD_AVPANEL_COMMA DisplayIDType  displayID, DMFidelityType * panelFidelity);

	EXTERN_API( ComponentResult  ) ADD_AVPANEL_BASENAME(ComponentTargetDevice) (AVPANEL_GLOBALS() ADD_AVPANEL_COMMA DisplayIDType  displayID, DialogPtr  theDialog, long  itemsOffset);

	EXTERN_API( ComponentResult  ) ADD_AVPANEL_BASENAME(ComponentGetPanelClass) (AVPANEL_GLOBALS() ADD_AVPANEL_COMMA ResType * panelClass, ResType * subClass, Ptr  reserved1, Ptr  reserved2);

#endif	/* AVPANEL_BASENAME */

/*
	Example usage:

		#define AVPORT_BASENAME()	Fred
		#define AVPORT_GLOBALS()	FredGlobalsHandle
		#include <AVComponents.k.h>

	To specify that your component implementation does not use globals, do not #define AVPORT_GLOBALS
*/
#ifdef AVPORT_BASENAME
	#ifndef AVPORT_GLOBALS
		#define AVPORT_GLOBALS() 
		#define ADD_AVPORT_COMMA 
	#else
		#define ADD_AVPORT_COMMA ,
	#endif
	#define AVPORT_GLUE(a,b) a##b
	#define AVPORT_STRCAT(a,b) AVPORT_GLUE(a,b)
	#define ADD_AVPORT_BASENAME(name) AVPORT_STRCAT(AVPORT_BASENAME(),name)

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(GetAVDeviceFidelity) (AVPORT_GLOBALS() ADD_AVPORT_COMMA AVIDType  deviceAVID, DMFidelityType * portFidelity);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(GetWiggle) (AVPORT_GLOBALS() ADD_AVPORT_COMMA Boolean * wiggleDevice);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(SetWiggle) (AVPORT_GLOBALS() ADD_AVPORT_COMMA Boolean  wiggleDevice);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(GetName) (AVPORT_GLOBALS() ADD_AVPORT_COMMA Str255  portName);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(GetGraphicInfo) (AVPORT_GLOBALS() ADD_AVPORT_COMMA PicHandle * thePict, Handle * theIconSuite, AVLocationPtr  theLocation);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(SetActive) (AVPORT_GLOBALS() ADD_AVPORT_COMMA Boolean  setActive);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(GetActive) (AVPORT_GLOBALS() ADD_AVPORT_COMMA Boolean * isPortActive, Boolean * portCanBeActivated, void * reserved);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(GetAVID) (AVPORT_GLOBALS() ADD_AVPORT_COMMA AVIDType * avPortID);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(SetAVID) (AVPORT_GLOBALS() ADD_AVPORT_COMMA AVIDType  avPortID);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(SetDeviceAVID) (AVPORT_GLOBALS() ADD_AVPORT_COMMA AVIDType  avDeviceID);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(GetDeviceAVID) (AVPORT_GLOBALS() ADD_AVPORT_COMMA AVIDType * avDeviceID);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(GetPowerState) (AVPORT_GLOBALS() ADD_AVPORT_COMMA AVPowerStatePtr  getPowerState);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(SetPowerState) (AVPORT_GLOBALS() ADD_AVPORT_COMMA AVPowerStatePtr  setPowerState);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(GetMakeAndModel) (AVPORT_GLOBALS() ADD_AVPORT_COMMA DisplayIDType  theDisplayID, ResType * manufacturer, UInt32 * model, UInt32 * serialNumber);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(GetInterfaceSignature) (AVPORT_GLOBALS() ADD_AVPORT_COMMA OSType * interfaceSignature);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(GetManufactureInfo) (AVPORT_GLOBALS() ADD_AVPORT_COMMA DisplayIDType  theDisplayID, DMMakeAndModelPtr  theMakeAndModel);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(CheckTimingMode) (AVPORT_GLOBALS() ADD_AVPORT_COMMA DisplayIDType  theDisplayID, VDDisplayConnectInfoPtr  connectInfo, VDTimingInfoPtr  modeTiming, UInt32  reserved);

	EXTERN_API( ComponentResult  ) ADD_AVPORT_BASENAME(GetDisplayTimingInfo) (AVPORT_GLOBALS() ADD_AVPORT_COMMA VDTimingInfoPtr  modeTiming, UInt32  requestedVersion, DMDisplayTimingInfoPtr  modeInfo, UInt32  reserved);

#endif	/* AVPORT_BASENAME */

/*
	Example usage:

		#define AVDEVICE_BASENAME()	Fred
		#define AVDEVICE_GLOBALS()	FredGlobalsHandle
		#include <AVComponents.k.h>

	To specify that your component implementation does not use globals, do not #define AVDEVICE_GLOBALS
*/
#ifdef AVDEVICE_BASENAME
	#ifndef AVDEVICE_GLOBALS
		#define AVDEVICE_GLOBALS() 
		#define ADD_AVDEVICE_COMMA 
	#else
		#define ADD_AVDEVICE_COMMA ,
	#endif
	#define AVDEVICE_GLUE(a,b) a##b
	#define AVDEVICE_STRCAT(a,b) AVDEVICE_GLUE(a,b)
	#define ADD_AVDEVICE_BASENAME(name) AVDEVICE_STRCAT(AVDEVICE_BASENAME(),name)

	EXTERN_API( ComponentResult  ) ADD_AVDEVICE_BASENAME(GetName) (AVDEVICE_GLOBALS() ADD_AVDEVICE_COMMA Str255  portName);

	EXTERN_API( ComponentResult  ) ADD_AVDEVICE_BASENAME(GetGraphicInfo) (AVDEVICE_GLOBALS() ADD_AVDEVICE_COMMA PicHandle * thePict, Handle * theIconSuite, AVLocationPtr  theLocation);

	EXTERN_API( ComponentResult  ) ADD_AVDEVICE_BASENAME(GetPowerState) (AVDEVICE_GLOBALS() ADD_AVDEVICE_COMMA AVPowerStatePtr  getPowerState);

	EXTERN_API( ComponentResult  ) ADD_AVDEVICE_BASENAME(SetPowerState) (AVDEVICE_GLOBALS() ADD_AVDEVICE_COMMA AVPowerStatePtr  setPowerState);

	EXTERN_API( ComponentResult  ) ADD_AVDEVICE_BASENAME(GetAVID) (AVDEVICE_GLOBALS() ADD_AVDEVICE_COMMA AVIDType * avDeviceID);

	EXTERN_API( ComponentResult  ) ADD_AVDEVICE_BASENAME(SetAVID) (AVDEVICE_GLOBALS() ADD_AVDEVICE_COMMA AVIDType  avDeviceID);

#endif	/* AVDEVICE_BASENAME */


#endif /* __AVCOMPONENTS_K__ */

