{
 	File:		CursorDevices.p
 
 	Contains:	Cursor Devices (mouse/trackball/etc) Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CursorDevices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CURSORDEVICES__}
{$SETC __CURSORDEVICES__ := 1}

{$I+}
{$SETC CursorDevicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
{
	                   * * *  W A R N I N G  * * * 

	On currently shipping PowerMacs, the CursorDevices manager is implemented
	in 68K code and emulated.  Unfortunately, the MixedMode glue in InterfaceLib
	is incorrect.  It and the 1.0 version of this file had incorrect parameter
	lists for most functions.
	
	As a first step to avoid runtime errors, the functions in this file were 
	renamed (e.g. from"CrsrDevButtons" to "CursorDeviceButtons").  This will result
	in a link time error if a PowerPC application tries to call the functions.
	When InterfaceLib is fixed, the new names will be exported and PowerPC
	code will then be able to call them.
	
}
	
TYPE
	ButtonOpcode = INTEGER;

{ ButtonOpcodes }

CONST
	kButtonNoOp					= 0;							{ No action for this button }
	kButtonSingleClick			= 1;							{ Normal mouse button }
	kButtonDoubleClick			= 2;							{ Click-release-click when pressed }
	kButtonClickLock			= 3;							{ Click on press, release on next press }
	kButtonCustom				= 6;							{ Custom behavior, data = CursorDeviceCustomButtonUPP }

{ Device Classes }
	kDeviceClassAbsolute		= 0;							{ a flat-response device }
	kDeviceClassMouse			= 1;							{ mechanical or optical mouse }
	kDeviceClassTrackball		= 2;							{  trackball  }
	kDeviceClassTrackPad		= 3;
	kDeviceClass3D				= 6;							{ a 3D pointing device }

{ Structures used in Cursor Device Manager calls }

TYPE
	CursorData = RECORD
		nextCursorData:			^CursorData;							{ next in global list }
		displayInfo:			Ptr;									{ unused (reserved for future) }
		whereX:					Fixed;									{ horizontal position }
		whereY:					Fixed;									{ vertical position }
		where:					Point;									{ the pixel position }
		isAbs:					BOOLEAN;								{ has been stuffed with absolute coords }
		buttonCount:			SInt8; (* UInt8 *)						{ number of buttons currently pressed }
		screenRes:				INTEGER;								{ pixels per inch on the current display }
		privateFields:			ARRAY [0..21] OF INTEGER;				{ fields use internally by CDM }
	END;

	CursorDataPtr = ^CursorData;

	CursorDevice = RECORD
		nextCursorDevice:		^CursorDevice;							{ pointer to next record in linked list }
		whichCursor:			^CursorData;							{ pointer to data for target cursor }
		refCon:					LONGINT;								{ application-defined }
		unused:					LONGINT;								{ reserved for future }
		devID:					OSType;									{ device identifier (from ADB reg 1) }
		resolution:				Fixed;									{ units/inch (orig. from ADB reg 1) }
		devClass:				SInt8; (* UInt8 *)						{ device class (from ADB reg 1) }
		cntButtons:				SInt8; (* UInt8 *)						{ number of buttons (from ADB reg 1) }
		filler1:				SInt8; (* UInt8 *)						{ reserved for future }
		buttons:				SInt8; (* UInt8 *)						{ state of all buttons }
		buttonOp:				ARRAY [0..7] OF SInt8; (* UInt8 *)		{ action performed per button }
		buttonTicks:			ARRAY [0..7] OF LONGINT;				{ ticks when button last went up (for debounce) }
		buttonData:				ARRAY [0..7] OF LONGINT;				{ data for the button operation }
		doubleClickTime:		LONGINT;								{ device-specific double click speed }
		acceleration:			Fixed;									{ current acceleration }
		privateFields:			ARRAY [0..14] OF INTEGER;				{ fields used internally to CDM }
	END;

	CursorDevicePtr = ^CursorDevice;

{ for use with CursorDeviceButtonOp when opcode = kButtonCustom }
	{
		CursorDeviceCustomButtonProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => ourDevice   	A2.L
		 => button      	D3.W
	}
	CursorDeviceCustomButtonProcPtr = Register68kProcPtr;  { register PROCEDURE CursorDeviceCustomButton(ourDevice: CursorDevicePtr; button: INTEGER); }
	CursorDeviceCustomButtonUPP = UniversalProcPtr;

CONST
	uppCursorDeviceCustomButtonProcInfo = $000ED802; { Register PROCEDURE (4 bytes in A2, 2 bytes in D3); }

FUNCTION NewCursorDeviceCustomButtonProc(userRoutine: CursorDeviceCustomButtonProcPtr): CursorDeviceCustomButtonUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallCursorDeviceCustomButtonProc(ourDevice: CursorDevicePtr; button: INTEGER; userRoutine: CursorDeviceCustomButtonUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION CursorDeviceMove(ourDevice: CursorDevicePtr; deltaX: LONGINT; deltaY: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $AADB;
	{$ENDC}
FUNCTION CursorDeviceMoveTo(ourDevice: CursorDevicePtr; absX: LONGINT; absY: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $AADB;
	{$ENDC}
FUNCTION CursorDeviceFlush(ourDevice: CursorDevicePtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $AADB;
	{$ENDC}
FUNCTION CursorDeviceButtons(ourDevice: CursorDevicePtr; buttons: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7003, $AADB;
	{$ENDC}
FUNCTION CursorDeviceButtonDown(ourDevice: CursorDevicePtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7004, $AADB;
	{$ENDC}
FUNCTION CursorDeviceButtonUp(ourDevice: CursorDevicePtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7005, $AADB;
	{$ENDC}
FUNCTION CursorDeviceButtonOp(ourDevice: CursorDevicePtr; buttonNumber: INTEGER; opcode: ButtonOpcode; data: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7006, $AADB;
	{$ENDC}
FUNCTION CursorDeviceSetButtons(ourDevice: CursorDevicePtr; numberOfButtons: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7007, $AADB;
	{$ENDC}
FUNCTION CursorDeviceSetAcceleration(ourDevice: CursorDevicePtr; acceleration: Fixed): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7008, $AADB;
	{$ENDC}
FUNCTION CursorDeviceDoubleTime(ourDevice: CursorDevicePtr; durationTicks: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7009, $AADB;
	{$ENDC}
FUNCTION CursorDeviceUnitsPerInch(ourDevice: CursorDevicePtr; resolution: Fixed): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700A, $AADB;
	{$ENDC}
FUNCTION CursorDeviceNextDevice(VAR ourDevice: CursorDevicePtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700B, $AADB;
	{$ENDC}
FUNCTION CursorDeviceNewDevice(VAR ourDevice: CursorDevicePtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700C, $AADB;
	{$ENDC}
FUNCTION CursorDeviceDisposeDevice(ourDevice: CursorDevicePtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700D, $AADB;
	{$ENDC}

{
	                   * * *  W A R N I N G  * * * 
				
	Even though the glue in InterfaceLib on PowerMacs for CursorDevices
	is generally wrong, the two popular routines CrsrDevNextDevice
	and CrsrDevMoveTo actually work.  Because we still don't have a 
	fixed library, we are adding back prototypes (with the old name)
	so that these functions can be called.


}
FUNCTION CrsrDevMoveTo(ourDevice: CursorDevicePtr; absX: LONGINT; absY: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $AADB;
	{$ENDC}
FUNCTION CrsrDevNextDevice(VAR ourDevice: CursorDevicePtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700B, $AADB;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CursorDevicesIncludes}

{$ENDC} {__CURSORDEVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
