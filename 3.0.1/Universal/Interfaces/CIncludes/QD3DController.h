/******************************************************************************
 **																			 **
 ** 	Module:		QD3DController.h										 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose: 	Each physical device is represented in the system by a	 **
 ** 				Controller record.  A device driver typically creates	 **
 ** 				a controller.  Controller feeds changes in coordinates	 **
 ** 				to a Tracker.											 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1992-1997 Apple Computer, Inc.  All rights reserved.	 **
 ** 																		 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DController_h
#define QD3DController_h

#include "QD3D.h"

#if defined(PRAGMA_ONCE) && PRAGMA_ONCE
	#pragma once
#endif  /*  PRAGMA_ONCE  */

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=int
	#pragma options align=power
#elif defined(__MWERKS__)
	#pragma enumsalwaysint on
	#pragma options align=native
#elif defined(__MRC__) || defined(__SC__)
	#if __option(pack_enums)
		#define PRAGMA_ENUM_RESET_QD3DCONTROL 1
	#endif
	#pragma options(!pack_enums)
	#pragma options align=power
#endif

#endif  /* OS_MACINTOSH */


#ifdef __cplusplus
extern "C" {
#endif  /*  __cplusplus  */


/******************************************************************************
 **																			 **
 **								Type Definitions							 **
 **																			 **
 *****************************************************************************/

#define kQ3ControllerSetChannelMaxDataSize		256

typedef TQ3Status (QD3D_CALLBACK *TQ3ChannelGetMethod) (
	TQ3ControllerRef			controllerRef,
	unsigned long				channel,
	void						*data,
	unsigned long				*dataSize);

typedef TQ3Status (QD3D_CALLBACK *TQ3ChannelSetMethod) (
	TQ3ControllerRef			controllerRef,
	unsigned long				channel,
	const void					*data,
	unsigned long				dataSize);

typedef struct TQ3ControllerData {
	char						*signature;
	unsigned long				valueCount;
	unsigned long				channelCount;
	TQ3ChannelGetMethod			channelGetMethod;
	TQ3ChannelSetMethod			channelSetMethod;
} TQ3ControllerData;


/******************************************************************************
 **																			 **
 **									 Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_GetListChanged (
	TQ3Boolean					*listChanged,
	unsigned long				*serialNumber);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_Next(
	TQ3ControllerRef			controllerRef,
	TQ3ControllerRef			*nextControllerRef);

QD3D_EXPORT TQ3ControllerRef QD3D_CALL Q3Controller_New(
	const TQ3ControllerData		*controllerData);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_Decommission(
	TQ3ControllerRef			controllerRef);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_SetActivation(
	TQ3ControllerRef			controllerRef,
	TQ3Boolean					active);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_GetActivation(
	TQ3ControllerRef			controllerRef,
	TQ3Boolean					*active);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_GetSignature(
	TQ3ControllerRef			controllerRef,
	char						*signature,
	unsigned long				numChars);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_SetChannel(
	TQ3ControllerRef			controllerRef,
	unsigned long				channel,
	const void					*data,
	unsigned long				dataSize);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_GetChannel(
	TQ3ControllerRef			controllerRef,
	unsigned long				channel,
	void						*data,
	unsigned long				*dataSize);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_GetValueCount(
	TQ3ControllerRef			controllerRef,
	unsigned long				*valueCount);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_SetTracker(
	TQ3ControllerRef			controllerRef,
	TQ3TrackerObject			tracker);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_HasTracker(
	TQ3ControllerRef			controllerRef,
	TQ3Boolean					*hasTracker);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_Track2DCursor(
	TQ3ControllerRef			controllerRef,
	TQ3Boolean					*track2DCursor);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_Track3DCursor(
	TQ3ControllerRef			controllerRef,
	TQ3Boolean					*track3DCursor);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_GetButtons(
	TQ3ControllerRef			controllerRef,
	unsigned long				*buttons);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_SetButtons(
	TQ3ControllerRef			controllerRef,
	unsigned long				buttons);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_GetTrackerPosition(
	TQ3ControllerRef			controllerRef,
	TQ3Point3D					*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_SetTrackerPosition(
	TQ3ControllerRef			controllerRef,
	const TQ3Point3D			*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_MoveTrackerPosition(
	TQ3ControllerRef			controllerRef,
	const TQ3Vector3D			*delta);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_GetTrackerOrientation(
	TQ3ControllerRef			controllerRef,
	TQ3Quaternion				*orientation);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_SetTrackerOrientation(
	TQ3ControllerRef			controllerRef,
	const TQ3Quaternion			*orientation);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_MoveTrackerOrientation(
	TQ3ControllerRef			controllerRef,
	const TQ3Quaternion			*delta);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_GetValues(
	TQ3ControllerRef			controllerRef,
	unsigned long				valueCount,
	float						*values,
	TQ3Boolean					*changed,
	unsigned long				*serialNumber);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Controller_SetValues(
	TQ3ControllerRef			controllerRef,
	const float					*values,
	unsigned long				valueCount);


/******************************************************************************
 **																			 **
 **								 Routines									 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ControllerStateObject QD3D_CALL Q3ControllerState_New(
	TQ3ControllerRef			controllerRef);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ControllerState_SaveAndReset(
	TQ3ControllerStateObject	controllerStateObject);

QD3D_EXPORT TQ3Status QD3D_CALL Q3ControllerState_Restore(
	TQ3ControllerStateObject	controllerStateObject);


/******************************************************************************
 **																			 **
 **							Type Definitions								 **
 **																			 **
 *****************************************************************************/

typedef TQ3Status (QD3D_CALLBACK *TQ3TrackerNotifyFunc) (
	TQ3TrackerObject			trackerObject,
	TQ3ControllerRef			controllerRef);


/******************************************************************************
 **																			 **
 **								 Routines									 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3TrackerObject QD3D_CALL Q3Tracker_New(
	TQ3TrackerNotifyFunc		notifyFunc);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tracker_SetNotifyThresholds(
	TQ3TrackerObject			trackerObject,
	float						positionThresh,
	float						orientationThresh);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tracker_GetNotifyThresholds(
	TQ3TrackerObject			trackerObject,
	float						*positionThresh,
	float						*orientationThresh);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tracker_SetActivation (
	TQ3TrackerObject			trackerObject,
	TQ3Boolean					active);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tracker_GetActivation (
	TQ3TrackerObject			trackerObject,
	TQ3Boolean					*active);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tracker_GetButtons(
	TQ3TrackerObject			trackerObject,
	unsigned long				*buttons);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tracker_ChangeButtons(
	TQ3TrackerObject			trackerObject,
	TQ3ControllerRef			controllerRef,
	unsigned long				buttons,
	unsigned long				buttonMask);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tracker_GetPosition(
	TQ3TrackerObject			trackerObject,
	TQ3Point3D					*position,
	TQ3Vector3D					*delta,
	TQ3Boolean					*changed,
	unsigned long				*serialNumber);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tracker_SetPosition(
	TQ3TrackerObject			trackerObject,
	TQ3ControllerRef			controllerRef,
	const TQ3Point3D			*position);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tracker_MovePosition(
	TQ3TrackerObject			trackerObject,
	TQ3ControllerRef			controllerRef,
	const TQ3Vector3D			*delta);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tracker_GetOrientation(
	TQ3TrackerObject			trackerObject,
	TQ3Quaternion				*orientation,
	TQ3Quaternion				*delta,
	TQ3Boolean					*changed,
	unsigned long				*serialNumber);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tracker_SetOrientation(
	TQ3TrackerObject			trackerObject,
	TQ3ControllerRef			controllerRef,
	const TQ3Quaternion			*orientation);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tracker_MoveOrientation(
	TQ3TrackerObject			trackerObject,
	TQ3ControllerRef			controllerRef,
	const TQ3Quaternion			*delta);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tracker_SetEventCoordinates(
	TQ3TrackerObject			trackerObject,
	unsigned long				timeStamp,
	unsigned long				buttons,
	const TQ3Point3D			*position,
	const TQ3Quaternion			*orientation);

QD3D_EXPORT TQ3Status QD3D_CALL Q3Tracker_GetEventCoordinates(
	TQ3TrackerObject			trackerObject,
	unsigned long				timeStamp,
	unsigned long				*buttons,
	TQ3Point3D					*position,
	TQ3Quaternion				*orientation);


/******************************************************************************
 **																			 **
 **								 Types										 **
 **																			 **
 *****************************************************************************/
 
typedef void (QD3D_CALLBACK *TQ3CursorTrackerNotifyFunc) (void);

/******************************************************************************
 **																			 **
 **								 Routines									 **
 **																			 **
 *****************************************************************************/
 
QD3D_EXPORT TQ3Status QD3D_CALL Q3CursorTracker_PrepareTracking(
	void);

QD3D_EXPORT TQ3Status QD3D_CALL Q3CursorTracker_SetTrackDeltas(
	TQ3Boolean					trackDeltas);

QD3D_EXPORT TQ3Status QD3D_CALL Q3CursorTracker_GetAndClearDeltas(
	float						*depth,
	TQ3Quaternion				*orientation,
	TQ3Boolean					*hasOrientation,
	TQ3Boolean					*changed,
	unsigned long				*serialNumber);

QD3D_EXPORT TQ3Status QD3D_CALL Q3CursorTracker_SetNotifyFunc(
	TQ3CursorTrackerNotifyFunc	notifyFunc);

QD3D_EXPORT TQ3Status QD3D_CALL Q3CursorTracker_GetNotifyFunc(
	TQ3CursorTrackerNotifyFunc	*notifyFunc);
	
#ifdef __cplusplus
}
#endif  /*  __cplusplus  */

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#if defined(__xlc__) || defined(__XLC121__)
	#pragma options enum=reset
	#pragma options align=reset
#elif defined(__MWERKS__)
	#pragma enumsalwaysint reset
	#pragma options align=reset
#elif defined(__MRC__) || defined(__SC__)
	#if PRAGMA_ENUM_RESET_QD3DCONTROL
		#pragma options(pack_enums)
		#undef PRAGMA_ENUM_RESET_QD3DCONTROL
	#endif
	#pragma options align=reset
#endif

#endif  /* OS_MACINTOSH */

#endif  /*  QD3DController_h  */
