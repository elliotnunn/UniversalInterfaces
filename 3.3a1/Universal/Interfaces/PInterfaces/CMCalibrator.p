{
 	File:		CMCalibrator.p
 
 	Contains:	ColorSync Calibration API
 
 	Version:	Technology:	ColorSync 2.5
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1998-1999 by Apple Computer, Inc., all rights reserved.
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
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

{  Interface for new ColorSync monitor calibrators (ColorSync 2.6 and greater)  }


CONST
	kCalibratorNamePrefix		= 'cali';


TYPE
	CalibratorInfoPtr = ^CalibratorInfo;
	CalibratorInfo = RECORD
		dataSize:				UInt32;									{  Size of this structure - compatibility  }
		displayID:				AVIDType;								{  Contains an hDC on Win32  }
		profileLocationSize:	UInt32;									{  Max size for returned profile location  }
		profileLocationPtr:		CMProfileLocationPtr;					{  For returning the profile  }
		eventProc:				CalibrateEventUPP;						{  Ignored on Win32  }
		isGood:					BOOLEAN;								{  true or false  }
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	CanCalibrateProcPtr = FUNCTION(displayID: AVIDType; VAR errMessage: Str255): BOOLEAN;
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
	uppCanCalibrateProcInfo = $000003D0;
	uppCalibrateProcInfo = $000000E0;

FUNCTION NewCalibrateEventUPP(userRoutine: CalibrateEventProcPtr): CalibrateEventUPP; { old name was NewCalibrateEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewCanCalibrateUPP(userRoutine: CanCalibrateProcPtr): CanCalibrateUPP; { old name was NewCanCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewCalibrateUPP(userRoutine: CalibrateProcPtr): CalibrateUPP; { old name was NewCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeCalibrateEventUPP(userUPP: CalibrateEventUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeCanCalibrateUPP(userUPP: CanCalibrateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeCalibrateUPP(userUPP: CalibrateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeCalibrateEventUPP(VAR event: EventRecord; userRoutine: CalibrateEventUPP); { old name was CallCalibrateEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeCanCalibrateUPP(displayID: AVIDType; VAR errMessage: Str255; userRoutine: CanCalibrateUPP): BOOLEAN; { old name was CallCanCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeCalibrateUPP(VAR theInfo: CalibratorInfo; userRoutine: CalibrateUPP): OSErr; { old name was CallCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$IFC OLDROUTINENAMES }
{  Interface for original ColorSync monitor calibrators (ColorSync 2.5.x)  }

CONST
	kOldCalibratorNamePrefix	= 'Cali';


TYPE
	OldCalibratorInfoPtr = ^OldCalibratorInfo;
	OldCalibratorInfo = RECORD
		displayID:				AVIDType;								{  Contains an hDC on Win32  }
		profileLocation:		CMProfileLocation;
		eventProc:				CalibrateEventUPP;						{  Ignored on Win32  }
		reserved:				UInt32;									{  Unused  }
		flags:					UInt32;									{  Unused  }
		isGood:					BOOLEAN;								{  true or false  }
		byteFiller:				SInt8;									{  Unused  }
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	OldCanCalibrateProcPtr = FUNCTION(displayID: AVIDType): BOOLEAN;
{$ELSEC}
	OldCanCalibrateProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	OldCalibrateProcPtr = FUNCTION(VAR theInfo: OldCalibratorInfo): OSErr;
{$ELSEC}
	OldCalibrateProcPtr = ProcPtr;
{$ENDC}

	OldCanCalibrateUPP = UniversalProcPtr;
	OldCalibrateUPP = UniversalProcPtr;

CONST
	uppOldCanCalibrateProcInfo = $000000D0;
	uppOldCalibrateProcInfo = $000000E0;
{$IFC CALL_NOT_IN_CARBON }

FUNCTION NewOldCanCalibrateUPP(userRoutine: OldCanCalibrateProcPtr): OldCanCalibrateUPP; { old name was NewOldCanCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewOldCalibrateUPP(userRoutine: OldCalibrateProcPtr): OldCalibrateUPP; { old name was NewOldCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeOldCanCalibrateUPP(userUPP: OldCanCalibrateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeOldCalibrateUPP(userUPP: OldCalibrateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

FUNCTION InvokeOldCanCalibrateUPP(displayID: AVIDType; userRoutine: OldCanCalibrateUPP): BOOLEAN; { old name was CallOldCanCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeOldCalibrateUPP(VAR theInfo: OldCalibratorInfo; userRoutine: OldCalibrateUPP): OSErr; { old name was CallOldCalibrateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMCalibratorIncludes}

{$ENDC} {__CMCALIBRATOR__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
