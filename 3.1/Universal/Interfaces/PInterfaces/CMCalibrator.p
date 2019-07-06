{
 	File:		CMCalibrator.p
 
 	Contains:	ColorSync Calibration API
 
 	Version:	Technology:	ColorSync 2.5
 				Release:	Universal Interfaces 3.1
 
 	Copyright:	© 1998 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		Please include the the file and version information (from above) with
 				the problem description.  Developers belonging to one of the Apple
 				developer programs can submit bug reports to:
 
 					devsupport@apple.com
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CMCalibrator;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMCALIBRATOR__}
{$SETC __CMCALIBRATOR__ := 1}

{$I+}
{$SETC CMCalibratorIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}
{$IFC UNDEFINED __DISPLAYS__}
{$I Displays.p}
{$ENDC}
{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CalibrateEventProcPtr = PROCEDURE(VAR event: EventRecord);
{$ELSEC}
	CalibrateEventProcPtr = ProcPtr;
{$ENDC}

	CalibrateEventUPP = UniversalProcPtr;
	CalibratorInfoPtr = ^CalibratorInfo;
	CalibratorInfo = RECORD
		displayID:				AVIDType;
		profileLocation:		CMProfileLocation;
		eventProc:				CalibrateEventUPP;
		reserved:				UInt32;
		flags:					UInt32;
		isGood:					BOOLEAN;
		byteFiller:				SInt8;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	CanCalibrateProcPtr = FUNCTION(displayID: AVIDType): BOOLEAN;
{$ELSEC}
	CanCalibrateProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CalibrateProcPtr = FUNCTION(VAR theInfo: CalibratorInfo): OSErr;
{$ELSEC}
	CalibrateProcPtr = ProcPtr;
{$ENDC}

	CanCalibrateUPP = UniversalProcPtr;
	CalibrateUPP = UniversalProcPtr;

CONST
	uppCalibrateEventProcInfo = $000000C0;
	uppCanCalibrateProcInfo = $000000D0;
	uppCalibrateProcInfo = $000000E0;

FUNCTION NewCalibrateEventProc(userRoutine: CalibrateEventProcPtr): CalibrateEventUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewCanCalibrateProc(userRoutine: CanCalibrateProcPtr): CanCalibrateUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewCalibrateProc(userRoutine: CalibrateProcPtr): CalibrateUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallCalibrateEventProc(VAR event: EventRecord; userRoutine: CalibrateEventUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallCanCalibrateProc(displayID: AVIDType; userRoutine: CanCalibrateUPP): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallCalibrateProc(VAR theInfo: CalibratorInfo; userRoutine: CalibrateUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMCalibratorIncludes}

{$ENDC} {__CMCALIBRATOR__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
