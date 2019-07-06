{
 	File:		ColorPicker.p
 
 	Contains:	Color Picker package Interfaces.
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 3.3a1
 
 	Copyright:	© 1987-1999 by Apple Computer, Inc., all rights reserved
 
 	Bugs?:		For bug reports, consult the following page on
 				the World Wide Web:
 
 					http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ColorPicker;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __COLORPICKER__}
{$SETC __COLORPICKER__ := 1}

{$I+}
{$SETC ColorPickerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{ Maximum small fract value, as long }
	kMaximumSmallFract			= $0000FFFF;

	kDefaultColorPickerWidth	= 383;
	kDefaultColorPickerHeight	= 238;

	kAtSpecifiedOrigin			= 0;
	kDeepestColorScreen			= 1;
	kCenterOnMainScreen			= 2;


TYPE
	DialogPlacementSpec					= INTEGER;
{ These are for the flags field in the structs below (for example ColorPickerInfo). }

CONST
	kColorPickerDialogIsMoveable = 1;
	kColorPickerDialogIsModal	= 2;
	kColorPickerCanModifyPalette = 4;
	kColorPickerCanAnimatePalette = 8;
	kColorPickerAppIsColorSyncAware = 16;
	kColorPickerInSystemDialog	= 32;
	kColorPickerInApplicationDialog = 64;
	kColorPickerInPickerDialog	= 128;
	kColorPickerDetachedFromChoices = 256;
	kColorPickerCallColorProcLive = 512;


{$IFC OLDROUTINENAMES }
																{ Maximum small fract value, as long }
	MaxSmallFract				= $0000FFFF;

	kDefaultWidth				= 383;
	kDefaultHeight				= 238;

{ These are for the flags field in the structs below (for example ColorPickerInfo). }
	DialogIsMoveable			= 1;
	DialogIsModal				= 2;
	CanModifyPalette			= 4;
	CanAnimatePalette			= 8;
	AppIsColorSyncAware			= 16;
	InSystemDialog				= 32;
	InApplicationDialog			= 64;
	InPickerDialog				= 128;
	DetachedFromChoices			= 256;
	CallColorProcLive			= 512;

{$ENDC}  {OLDROUTINENAMES}

{ A SmallFract value is just the fractional part of a Fixed number,
which is the low order word.  SmallFracts are used to save room,
and to be compatible with Quickdraw's RGBColor.  They can be
assigned directly to and from INTEGERs. }
{ Unsigned fraction between 0 and 1 }

TYPE
	SmallFract							= UInt16;
{ For developmental simplicity in switching between the HLS and HSV
models, HLS is reordered into HSL. Thus both models start with
hue and saturation values; value/lightness/brightness is last. }

	HSVColorPtr = ^HSVColor;
	HSVColor = RECORD
		hue:					SmallFract;								{ Fraction of circle, red at 0 }
		saturation:				SmallFract;								{ 0-1, 0 for gray, 1 for pure color }
		value:					SmallFract;								{ 0-1, 0 for black, 1 for max intensity }
	END;

	HSLColorPtr = ^HSLColor;
	HSLColor = RECORD
		hue:					SmallFract;								{ Fraction of circle, red at 0 }
		saturation:				SmallFract;								{ 0-1, 0 for gray, 1 for pure color }
		lightness:				SmallFract;								{ 0-1, 0 for black, 1 for white }
	END;

	CMYColorPtr = ^CMYColor;
	CMYColor = RECORD
		cyan:					SmallFract;
		magenta:				SmallFract;
		yellow:					SmallFract;
	END;

	PMColorPtr = ^PMColor;
	PMColor = RECORD
		profile:				CMProfileHandle;
		color:					CMColor;
	END;

	NPMColorPtr = ^NPMColor;
	NPMColor = RECORD
		profile:				CMProfileRef;
		color:					CMColor;
	END;

	Picker = ^LONGINT; { an opaque 32-bit type }
	PickerMenuItemInfoPtr = ^PickerMenuItemInfo;
	PickerMenuItemInfo = RECORD
		editMenuID:				INTEGER;
		cutItem:				INTEGER;
		copyItem:				INTEGER;
		pasteItem:				INTEGER;
		clearItem:				INTEGER;
		undoItem:				INTEGER;
	END;

{ Structs related to deprecated API's have been pulled from this file. }
{ Those structs necessary for developers writing their own color pickers... }
{ have been moved to ColorPickerComponents.h. }

{$IFC TYPED_FUNCTION_POINTERS}
	ColorChangedProcPtr = PROCEDURE(userData: LONGINT; VAR newColor: PMColor);
{$ELSEC}
	ColorChangedProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	NColorChangedProcPtr = PROCEDURE(userData: LONGINT; VAR newColor: NPMColor);
{$ELSEC}
	NColorChangedProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	UserEventProcPtr = FUNCTION(VAR event: EventRecord): BOOLEAN;
{$ELSEC}
	UserEventProcPtr = ProcPtr;
{$ENDC}

	ColorChangedUPP = UniversalProcPtr;
	NColorChangedUPP = UniversalProcPtr;
	UserEventUPP = UniversalProcPtr;
	ColorPickerInfoPtr = ^ColorPickerInfo;
	ColorPickerInfo = RECORD
		theColor:				PMColor;
		dstProfile:				CMProfileHandle;
		flags:					UInt32;
		placeWhere:				DialogPlacementSpec;
		dialogOrigin:			Point;
		pickerType:				OSType;
		eventProc:				UserEventUPP;
		colorProc:				ColorChangedUPP;
		colorProcData:			UInt32;
		prompt:					Str255;
		mInfo:					PickerMenuItemInfo;
		newColorChosen:			BOOLEAN;
		filler:					SInt8;
	END;

	NColorPickerInfoPtr = ^NColorPickerInfo;
	NColorPickerInfo = RECORD
		theColor:				NPMColor;
		dstProfile:				CMProfileRef;
		flags:					UInt32;
		placeWhere:				DialogPlacementSpec;
		dialogOrigin:			Point;
		pickerType:				OSType;
		eventProc:				UserEventUPP;
		colorProc:				NColorChangedUPP;
		colorProcData:			UInt32;
		prompt:					Str255;
		mInfo:					PickerMenuItemInfo;
		newColorChosen:			BOOLEAN;
		reserved:				SInt8;									{ Must be 0 }
	END;


{ 	Below are the color conversion routines. }
FUNCTION Fix2SmallFract(f: Fixed): SmallFract;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0001, $A82E;
	{$ENDC}
FUNCTION SmallFract2Fix(s: SmallFract): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0002, $A82E;
	{$ENDC}
PROCEDURE CMY2RGB({CONST}VAR cColor: CMYColor; VAR rColor: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0003, $A82E;
	{$ENDC}
PROCEDURE RGB2CMY({CONST}VAR rColor: RGBColor; VAR cColor: CMYColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $A82E;
	{$ENDC}
PROCEDURE HSL2RGB({CONST}VAR hColor: HSLColor; VAR rColor: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0005, $A82E;
	{$ENDC}
PROCEDURE RGB2HSL({CONST}VAR rColor: RGBColor; VAR hColor: HSLColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0006, $A82E;
	{$ENDC}
PROCEDURE HSV2RGB({CONST}VAR hColor: HSVColor; VAR rColor: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0007, $A82E;
	{$ENDC}
PROCEDURE RGB2HSV({CONST}VAR rColor: RGBColor; VAR hColor: HSVColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0008, $A82E;
	{$ENDC}

{ 	GetColor() works with or without the Color Picker extension. }
FUNCTION GetColor(where: Point; prompt: Str255; {CONST}VAR inColor: RGBColor; VAR outColor: RGBColor): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0009, $A82E;
	{$ENDC}

{ 	PickColor() requires the Color Picker extension (version 2.0 or greater). }
FUNCTION PickColor(VAR theColorInfo: ColorPickerInfo): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0213, $A82E;
	{$ENDC}
{ 	NPickColor() requires the Color Picker extension (version 2.1 or greater). }
FUNCTION NPickColor(VAR theColorInfo: NColorPickerInfo): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0227, $A82E;
	{$ENDC}

{ A suite of mid-level API calls have been deprecated.  Likely you never...  }
{ used them anyway.  They were removed from this file and should not be... }
{ used in the future as they are not gauranteed to be supported. }

CONST
	uppColorChangedProcInfo = $000003C0;
	uppNColorChangedProcInfo = $000003C0;
	uppUserEventProcInfo = $000000D0;

FUNCTION NewColorChangedUPP(userRoutine: ColorChangedProcPtr): ColorChangedUPP; { old name was NewColorChangedProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNColorChangedUPP(userRoutine: NColorChangedProcPtr): NColorChangedUPP; { old name was NewNColorChangedProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewUserEventUPP(userRoutine: UserEventProcPtr): UserEventUPP; { old name was NewUserEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

PROCEDURE DisposeColorChangedUPP(userUPP: ColorChangedUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeNColorChangedUPP(userUPP: NColorChangedUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE DisposeUserEventUPP(userUPP: UserEventUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

PROCEDURE InvokeColorChangedUPP(userData: LONGINT; VAR newColor: PMColor; userRoutine: ColorChangedUPP); { old name was CallColorChangedProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE InvokeNColorChangedUPP(userData: LONGINT; VAR newColor: NPMColor; userRoutine: NColorChangedUPP); { old name was CallNColorChangedProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InvokeUserEventUPP(VAR event: EventRecord; userRoutine: UserEventUPP): BOOLEAN; { old name was CallUserEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ColorPickerIncludes}

{$ENDC} {__COLORPICKER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
